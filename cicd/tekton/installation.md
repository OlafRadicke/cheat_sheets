### INSTALLATION

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
