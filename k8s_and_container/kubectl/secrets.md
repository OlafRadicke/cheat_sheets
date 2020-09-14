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

Pod that uses your Secret
-------------------------

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  containers:
  - name: private-reg-container
    image: <your-private-image>
  imagePullSecrets:
  - name: regcred
```


Delete a secret
---------------

```bash
kubectl delete secret "regcred"
```
