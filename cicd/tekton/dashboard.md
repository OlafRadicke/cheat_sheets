# DASHBOARD

## INSTALLATION

Download CRD-manifest: https://github.com/tektoncd/dashboard/blob/main/releases.md

`release.yaml` is read-only and `release-full.yaml` is read/write.

Wenn man das in einen selbstgewählten Namespace installieren will, muss man mit kustomization arbeiten.

```yaml
---
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: tekton-deshboard
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  sources:
    - path: argocd-app-of-apps/cluster/irish-sea/tekton-pipelines-deshboard/manifests/overlays
      repoURL: "https://github.com/OlafRadicke/own_dog_food.git"
      targetRevision: main
      ref: values
      # kustomize: {}
  destination:
    namespace: tekton-deshboard
    server: https://kubernetes.default.svc
  project: tekton-deshboard
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: true
    syncOptions:
      - CreateNamespace=true
```

`overlays/kustomization.yaml`:

```yaml
resources:
  - ../base/

patches:
  - target:
      kind: ServiceAccount
    patch: |-
      - op: replace
        path: /metadata/namespace
        value: tekton-deshboard

  - target:
      kind: Role
    patch: |-
      - op: replace
        path: /metadata/namespace
        value: tekton-deshboard

  - target:
      kind: ClusterRole
    patch: |-
      - op: replace
        path: /metadata/namespace
        value: tekton-deshboard

  - target:
      kind: RoleBinding
    patch: |-
      - op: replace
        path: /metadata/namespace
        value: tekton-deshboard

  - target:
      kind: ClusterRoleBinding
    patch: |-
      - op: replace
        path: /metadata/namespace
        value: tekton-deshboard

  - target:
      kind: ConfigMap
    patch: |-
      - op: replace
        path: /metadata/namespace
        value: tekton-deshboard

  - target:
      kind: Service
    patch: |-
      - op: replace
        path: /metadata/namespace
        value: tekton-deshboard

  - target:
      kind: Deployment
    patch: |-
      - op: replace
        path: /metadata/namespace
        value: tekton-deshboard
```

`base/kustomization.yaml`:

```yaml
resources:
  - tekton-deshboar-v0.63.1-LTE-release.yaml
```
