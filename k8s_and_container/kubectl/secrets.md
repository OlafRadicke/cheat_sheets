Secrets
=======

- [Secrets](#secrets)
  - [Create a secret](#create-a-secret)
  - [Create secret as yaml file](#create-secret-as-yaml-file)
  - [base64 encoding](#base64-encoding)
  - [Get secrets](#get-secrets)
  - [Pod that uses your Secret](#pod-that-uses-your-secret)
  - [Apply registry secret to serviceaccount "default"](#apply-registry-secret-to-serviceaccount-default)
  - [Delete a secret](#delete-a-secret)


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

Create secret as yaml file
--------------------------

```bash
kubectl create secret tls example-tls-secret \
  --cert certificate.pem \
  --key key.pem  \
  --dry-run=true \
  -o yaml
```

base64 encoding
---------------

Without line breaks

```
cat /registry.crt | base64 -w0
```

```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: registry-tls
type: Opaque
data:
  tls.crt: {{ crt_base64 }}
  tls.key: {{ key_base64 }}
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

Apply registry secret to serviceaccount "default"
-------------------------------------------------

```bash
kubectl patch \
        serviceaccount \
        default \
        -p '{"imagePullSecrets": [{"name": "regcred"}]}'
```

Delete a secret
---------------

```bash
kubectl delete secret "regcred"
```
