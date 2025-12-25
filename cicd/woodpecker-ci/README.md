# WOODPECKER CI

## INSTALLATION WITH ARGOCD

Woodpecker is using OCI for the chart repo. So you need ArgoCD 2.6 or higher.

## OAUTH IS NEEDED (TOKEN ALTERNATIVE)

If you want to use all the features, you have to link Woodpecker and Forgejo via OAuth. Forgejo can act as the OAuth provider. Alternatively, you can use tokens, but this limits the functionality.

`Settings` → `Applications` → `Manage OAuth2 Applications` → `New OAuth2 Application`

Redirect URI: `https://woodpecker.example.com/authorize`

Woodpecker‑Helm‑Values:

```yaml
server:
env:
WOODPECKER_FORGE_TYPE: gitea
WOODPECKER_GITEA_URL: "https://forgejo.example.com"
WOODPECKER_GITEA_CLIENT: "<client-id>"
WOODPECKER_GITEA_SECRET: "<client-secret>"
```

## LINKS

- [Projec site](https://woodpecker-ci.org/)
- [Git-Repo](https://github.com/woodpecker-ci/helm)
- [Installation (K8s with Cart)](https://woodpecker-ci.org/docs/administration/installation/helm-chart)
- [Buld docker images with Buildkit](https://woodpecker-ci.org/plugins/docker-buildx)
