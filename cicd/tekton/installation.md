### INSTALLATION

## BASIC INFOS

- [Git-Repo](https://github.com/tektoncd)
- [Pac - pipelinesascode](https://pipelinesascode.com/docs/install/kubernetes/)
- [Git-Repo of Pac](https://github.com/openshift-pipelines/pipelines-as-code)
- [Tekton-Catalog](https://github.com/tektoncd/catalog)
- [Git-Repo dashboard](https://github.com/tektoncd/dashboard/blob/main/releases.md)

## tkn-pac INSTALL

Go to release Git-Repo of Pac download tar.gz-file, extract the file and copy it to `~/.local/bin/`

Check installation:

```bash
$ tkn-pac info install
```

## WITH ARGOCD

```yaml
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: tekton-operator
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  sources:
    - path: charts/tekton-operator
      repoURL: https://github.com/tektoncd/operator.git
      targetRevision: v0.78.1
      helm:
        valueFiles:
          - $values/argocd-app-of-apps/cluster/irish-sea/tekton-operator/values.yaml
    - repoURL: "https://github.com/OlafRadicke/own_dog_food.git"
      targetRevision: main
      ref: values

  destination:
    namespace: tekton-operator
    server: https://kubernetes.default.svc
  project: tekton-operator
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: true
    syncOptions:
      - CreateNamespace=true
```

Values:

```yaml
openshift:
  enabled: false
## If the Tekton-operator CRDs should automatically be installed and upgraded
## Setting this to true will cause a cascade deletion of all Tekton resources when you uninstall the chart - danger!
installCRDs: true
## Controllers to install
controllers: "tektonconfig,tektonpipeline,tektontrigger,tektonhub,tektonchain,tektonresult,tektondashboard,manualapprovalgate,tektonpruner"
## Control the creation of RBAC resources (Serviceaccount, Role, ClusterRole, ClusterRoleBinding)
rbac:
  create: true
operator:
  autoInstallComponents: true
  # The namespace in which Tekton components should be deployed
  # Defaults to "tekton-pipelines" for Kubernetes and to "openshift-pipelines" for Openshift flavor.
  defaultTargetNamespace: "tekton-operator"
  logLevel: info
```

## CONFIGURATION OVER THE CONFIGMAP

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/part-of: pipelines-as-code
    app.kubernetes.io/version: v0.39.3
  name: pipelines-as-code
data:
  application-name: Pipelines as Code CI
  auto-configure-new-github-repo: "false"
  auto-configure-repo-namespace-template: ""
  auto-configure-repo-repository-template: ""
  bitbucket-cloud-additional-source-ip: ""
  bitbucket-cloud-check-source-ip: "true"
  default-max-keep-runs: ""
  enable-cancel-in-progress-on-pull-requests: "false"
  enable-cancel-in-progress-on-push: "false"
  error-detection-from-container-logs: "true"
  error-detection-max-number-of-lines: "50"
  error-detection-simple-regexp:
    ^(?P<filename>[^:]*):(?P<line>[0-9]+):(?P<column>[0-9]+)?([
    ]*)?(?P<error>.*)
  error-log-snippet: "true"
  error-log-snippet-number-of-lines: "3"
  hub-catalog-type: artifacthub
  hub-url: https://artifacthub.io
  max-keep-run-upper-limit: ""
  remember-ok-to-test: "false"
  remote-tasks: "true"
  require-ok-to-test-sha: "false"
  secret-auto-create: "true"
  secret-github-app-scope-extra-repos: ""
  secret-github-app-token-scoped: "true"
  skip-push-event-for-pr-commits: "true"
  tekton-dashboard-url: "" # <- this is needed for the WEB-GUI feedback in forgejo!
```

## TROUBLESHOOTING

### CHECK PAC INSTALLATION

```bash
$ kubectl get deployment -A | grep pipelines-as-code
```
