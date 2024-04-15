FLUX CD
=======


INSTALLATION CLI
----------------

See [Flux installation docu](https://fluxcd.io/flux/installation/)



TROUBLESHOOTING
---------------

### GETTING BASIC INFORMATION

```bash
$ flux check
```
or

```bash
$ flux get all -A
```

or

```bash
$ flux get all -A --status-selector ready=false
```

### GET WARNINGS

```bash
$ kubectl get events -n flux-system --field-selector type=Warning
```

### GET GIT REPOS

```bash
$ kubectl get gitrepositories.source.toolkit.fluxcd.io -A
```

### GET ALL HELM CHART REPOS

```bash
$ kubectl get helmrepositories.source.toolkit.fluxcd.io -A
```

or

```bash
$ kubectl get helmcharts.source.toolkit.fluxcd.io -A
```

### CHECK KUSTOMIZATIONS

```bash
$ flux get kustomizations -A
```

or

```bash
$ kubectl get kustomizations.kustomize.toolkit.fluxcd.io -A
```

### CHECK HELMRELEASES

```bash
$ flux get helmreleases -A
```

or

```bash
$ kubectl get helmreleases.helm.toolkit.fluxcd.io -A
```

### RETRIGGER HELM DEPLOYMENT


```bash
$ flux reconcile kustomization mastodon -n flux-system
```

### GET LOGS

Of the last 10 minutes...

```bash
$ flux logs --all-namespaces --since=10m
```