# forgejo

## LINKS

- [https://codeberg.org/forgejo/forgejo](https://codeberg.org/forgejo/forgejo)
- [Git-Repo Helm Chart](https://code.forgejo.org/forgejo-helm/forgejo-helm)

## GET ADMIN PASSWORT

```bash
$ kubectl get secret forgejo-admin -n forgejo -oyaml
```

```
$ kubectl get secret forgejo-admin \
  -n forgejo \
  -o jsonpath="{.data.password}" | \
  base64 -d; echo
```

## KNOWN ISSUE

### (PaC-operatot log) cannot find a repository match for http://git.example.com/

Add this block in the values file:

```yaml
deployment:
  env:
    - name: ROOT_URL
      value: "http://localhost:8086/"
    - name: SSH_DOMAIN
      value: "https://localhost:8486/"
```

### (in ArgoCD) unable to lock level db at /data/queues/common

Only one instace can run. Kill the old pod instance. Rolling releases is not supported.
