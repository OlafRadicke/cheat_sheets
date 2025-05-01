ArgoCD
======

- [ArgoCD](#argocd)
  - [Get password](#get-password)
  - [Connect web console](#connect-web-console)
  - [Use Helm Chart in a git repo](#use-helm-chart-in-a-git-repo)
  - [Known issue](#known-issue)
    - [ArgoCD =\> ERR\_TOO\_MANY\_REDIRECTS](#argocd--err_too_many_redirects)
  - [Links](#links)
  - [Waves](#waves)



Get password
------------

(default user admin)


```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

Connect web console
-------------------

```bash
kubectl port-forward service/argocd-server -n argocd 8080:80
```

Use Helm Chart in a git repo
----------------------------


```yaml
---

apiVersion:         argoproj.io/v1alpha1
kind:               Application
metadata:
  name:             firefish-quakers-social
  namespace:        argocd
spec:
  project:          firefish-quakers-social
  source:
    path:           chart
    repoURL:        https://firefish.dev/iacore/firefish.git
    targetRevision: develop
    helm:
      valuesObject:
        firefish:
          isManagedHosting: true
  destination:
    server:         https://kubernetes.default.svc
    namespace:      argocd-aoa
```



Known issue
-----------

### ArgoCD => ERR_TOO_MANY_REDIRECTS

The install yaml need a change:

```
*** 10235,10244 ****
--- 10235,10245 ----
                topologyKey: kubernetes.io/hostname
              weight: 5
        containers:
        - command:
          - argocd-server
+         - --insecure
          env:
          - name: ARGOCD_SERVER_INSECURE
            valueFrom:
              configMapKeyRef:
                key: server.insecure
```

Alternativ:

```yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: argocd-cmd-params-cm
    app.kubernetes.io/part-of: argocd
    name: argocd-cmd-params-cm
    namespace: argocd
data:
  server.insecure: "true"
```


And enter for restart:

```bash
$ kubectl apply -f ./manuel-conf/insecure.yaml

$ kubectl scale -n argocd deployment/argocd-server --replicas=0 && \
  kubectl scale -n argocd deployment/argocd-server --replicas=1
```


Links
-----

- [Project documentaion](https://argo-cd.readthedocs.io/en/stable/)


Waves
-----

Specify the wave using the following annotation:

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "5"
```

When Argo CD starts a sync, it orders the resources in the following precedence:

- The phase
- The wave they are in (lower values first for creation & updation and higher values first for deletion)
- By kind (e.g. namespaces first and then other Kubernetes resources, followed by custom resources)
- By name