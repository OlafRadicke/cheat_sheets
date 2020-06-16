Secrets
=======

Create a secret
---------------

...for a private docker registry:

```bash
kubectl create secret docker-registry \
        regcred \
        --docker-server=dockerhub.stage.xxxxxxxxx.local \
        --docker-username=userme \
        --docker-password=xxxxxxxxxxxxx \
        --docker-email=foo.bar@xxxxxx.xx
        secret/regcred created
```

Get secrets
-----------

```bash
kubectl get secrets
```

Delete a secret
---------------

```bash
kubectl delete secret "regcred"
```
