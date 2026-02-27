# ExternalSecret

## Beispiel für Pullsecret

```bash
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: group-gitlab-pull-secret
spec:
  secretStoreRef:
    name: infra-openbao
    kind: ClusterSecretStore
  refreshInterval: 1h
  target:
    name: group-gitlab-pull-secret
    creationPolicy: Owner
    # The template part
    template:
      metadata:
        labels:
          environment: "dev"
          usage: kubernetes
      type: kubernetes.io/dockerconfigjson
      data:
        .dockerconfigjson: '{"auths":{"registry.devops.innolab.local":{"username":"{{ .template_token_username }}","password":"{{ .template_token_secret }}","auth":"{{ printf "%s:%s" .template_token_secret .template_token_secret | b64enc }}"}}}'
  data:
   - secretKey: "template_token_secret"
      remoteRef:
        key: "my-pull-secret"
        property: GitlabDeployTokenAppsSecret

    - secretKey: "template_token_username"
      remoteRef:
        key: "my-pull-secret"
        property: GitlabDeployTokenAppsUsername

```
