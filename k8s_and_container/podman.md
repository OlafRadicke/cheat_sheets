podman
======

Deploy K8S-Deployment
---------------------

```bash
podman play kube ./k8s/my-deployment.yaml
```

With configmaps

```bash
$ podman play kube demo.yml --configmap configmap-foo.yml,configmap-bar.yml
```


Pods
----

### Inspect ###

```bash
podman pod inspect foobar
```

### List ###

```bash
$ podman pod ps
```

### Delete pods ###

```bash
podman pod rm -f 860a4b23
```

Delete all pods

```bash
podman pod rm -f -a
```

### Top ###

```bash
podman pod top 24b211d1fe7e
```

Port listing
------------

```bash
podman port -a
```
