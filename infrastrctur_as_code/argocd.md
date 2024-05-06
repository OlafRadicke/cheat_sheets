ArgoCD
======


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

Links
-----

- [Project documentaion](https://argo-cd.readthedocs.io/en/stable/)