# PIPELINE AS CODE

- [PIPELINE AS CODE](#pipeline-as-code)
  - [BIG PICTURE](#big-picture)
  - [CONFIGURE THE REPOSITORY](#configure-the-repository)
  - [CREATE PIPELINE DEFINITION](#create-pipeline-definition)
  - [CONFIGURE THE WEBHOOK In FORGEJO](#configure-the-webhook-in-forgejo)
  - [DEBUGGING](#debugging)
    - [TEST REPOSITORY CR WITH](#test-repository-cr-with)
    - [PODS LOGS](#pods-logs)
    - [CONFIGURE LOGGING](#configure-logging)
    - [WEBHOOK](#webhook)
      - [PaC‑Webhook‑Endpoint testen](#pacwebhookendpoint-testen)
    - [PIPELINES](#pipelines)

## BIG PICTURE

```mermaid
---
config:
  flowchart:
    htmlLabels: false
---
flowchart TD
  step01[Push/PR in Forgejo]
  step02[Webhook to PaC]
  step03[PaC matcht Repository]
  step04[Sercht .tekton/*.yaml]
  step05[Creates Tekton PipelineRun]

  step01 --> step02
  step02 --> step03
  step03 --> step04
  step04 --> step05
```

For airgap system you can use [gosmee](https://github.com/chmouel/gosmee).

## CONFIGURE THE REPOSITORY

With your code.

```yaml
apiVersion: pipelinesascode.tekton.dev/v1alpha1
kind: Repository
metadata:
  name: forgejo-olaf-test-repo
  namespace: pipelines-as-code # same of PaC-Controller
spec:
  url: "http://localhost:8086/gitea_admin/teckton-pac-test" # your Forgejo-Repo-URL

  webhookSecret:
    name: pac-webhook-secret
    key: webhook-secret
```

Create secret:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: pac-webhook-secret
  namespace: pipelines-as-code
type: Opaque
stringData:
  webhook-secret: "XXXChangeMeXXX"
```

## CREATE PIPELINE DEFINITION

Create in your targe gir repo a directory with name .tekton/ and insert a file

with the pipeline code (for example):

```yaml
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  name: pr-simple-run
  annotations:
    pipelinesascode.tekton.dev/on-event: "[pull_request, push]"
    pipelinesascode.tekton.dev/on-target-branch: "[main]"
spec:
  pipelineSpec:
    workspaces:
      - name: source
    tasks:
      - name: clone
        taskRef:
          kind: ClusterTask
          name: git-clone # aus tektoncd/catalog
        workspaces:
          - name: output
            workspace: source
        params:
          - name: url
            value: "$(params.repo_url)"
          - name: revision
            value: "$(params.revision)"
          - name: deleteExisting
            value: "true"

      - name: echo
        runAfter: [clone]
        taskSpec:
          workspaces:
            - name: source
          steps:
            - name: say-hello
              image: alpine:3.18
              workingDir: /workspace/source
              script: |
                echo "Hello from Tekton + Forgejo"
  params:
    - name: repo_url
      value: "$(params.repository_url)" # von PaC gesetzt
    - name: revision
      value: "$(params.revision)" # von PaC gesetzt
  workspaces:
    - name: source
      volumeClaimTemplate:
        spec:
          accessModes: ["ReadWriteOnce"]
          resources:
            requests:
              storage: 1Gi
```

## CONFIGURE THE WEBHOOK In FORGEJO

In the Forgejo repo:

`Settings` → `Webhooks` → `Add Webhook`

URL: your PaC-Endpoint, for example:

`https://tekton-pac.example.org`

or

`/hook-Endpoint`

Secret (German "Geheimnis"): exakt the same string of the webhook-secret.

Events: Push / Pull Request.

## DEBUGGING

### TEST REPOSITORY CR WITH

```bash
$ tkn-pac resolve \
  -f cicd/tekton/.tekton/PipelineRun-example-forgejo.yaml \
  -o /tmp/PipelineRun-example-forgejo.yaml \
  && kubectl create \
  -f /tmp/PipelineRun-example-forgejo.yaml \
  -n pipelines-as-code
```

### PODS LOGS

```bash
$ kubectl describe deploy pipelines-as-code-controller \
  -n pipelines-as-code
```

```bash
$ kubectl logs deploy/pipelines-as-code-controller \
  -n pipelines-as-code -f
```

### CONFIGURE LOGGING

```bash
$ kubectl get configmap pac-config-logging \
    -n pipelines-as-code \
    -o yaml
```

Patch log level:

```bash
$ kubectl patch configmap pac-config-logging -n pipelines-as-code --type json -p '[{"op": "replace", "path": "/data/loglevel.pac-watcher", "value":"debug"}]'

$ kubectl patch configmap pac-config-logging -n pipelines-as-code --type json -p '[{"op": "replace", "path": "/data/loglevel.pipelines-as-code-webhook", "value":"debug"}]'

$ kubectl patch configmap pac-config-logging -n pipelines-as-code --type json -p '[{"op": "replace", "path": "/data/loglevel.pipelinesascode", "value":"debug"}]'
```

See too: https://github.com/openshift-pipelines/pipelines-as-code/blob/main/docs/content/docs/install/logging.md

### WEBHOOK

Check the logs:

```bash
$ kubectl logs -n pipelines-as-code deploy/pipelines-as
-code-controller -f
```

#### PaC‑Webhook‑Endpoint testen

```bash
$ MY_NS=debugging-tools
$ HOOK_ADDR='https://pipelines-as-code-webhook.pipelines-as-code.svc:443'
$ HOOK_ADDR='http://pipelines-as-code-controller.pipelines-as-code.svc:8080/incoming'
$ SIG=xxxx
```

Einfacher Test:

```bash
$ kubectl exec -it \
  $(
    kubectl get pod \
      -l app=debugger \
      -o jsonpath='{.items[0].metadata.name}' \
      -n ${MY_NS}) \
   -n ${MY_NS} \
  -- curl -v -I ${HOOK_ADDR}
```

```bash
$ kubectl exec -it \
  $(
    kubectl get pod \
      -l app=debugger \
      -o jsonpath='{.items[0].metadata.name}' \
      -n ${MY_NS}) \
   -n ${MY_NS} \
  -- curl \
    -vk \
    -X POST \
    -H "Content-Type: application/json" \
    -H "X-Gitea-Event: push" \
    -H "X-Gitea-Signature: ${SIG}" \
    -d '{"ref":"refs/heads/main",
    "repository": {"clone_url": "https://forgejo-http.forgejo:3000/gitea_admin/teckton-pac-test.git"}}' \
    ${HOOK_ADDR}
```

```bash
$ kubectl exec -it \
  $(
    kubectl get pod \
      -l app=debugger \
      -o jsonpath='{.items[0].metadata.name}' \
      -n ${MY_NS}) \
   -n ${MY_NS} \
  -- curl \
    -H "Content-Type: application/json" \
    -k \
    -X POST \
    "${HOOK_ADDR}/" \
    -d '{"repository":"repo","branch":"main","pipelinerun":"target-pipelinerun","secret":"pac-webhook-secret", "clone_url": "https://forgejo-http.forgejo:3000/gitea_admin/teckton-pac-test.git"}'
```

### PIPELINES

```bash
kubectl get pipelineruns -A
```

```bash
$ kubectl describe pipelinerun example-forgejo-s89gk -n pipelines-as-code
```
