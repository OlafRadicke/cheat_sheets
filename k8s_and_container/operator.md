Kubernetes Operator (with SDK)
==============================


Install the Operator SDK CLI
----------------------------

Under Linux:

[Download released bin](https://github.com/operator-framework/operator-sdk/releases/),
make it executable and copy to /usr/local/bin/operator-sdk


Add an alias for podman.

```
ln -s /usr/bin/podman /usr/local/bin/docker
```


Build an operator using the Operator SDK
----------------------------------------

Init a ansible operator project:

```bash
operator-sdk init --plugins=ansible --domain example.com
```

Create an API scaffold
----------------------

```bash
operator-sdk create api \
  --group cache \
  --version v1alpha1 \
  --kind Memcached \
  --generate-role
```

Building and push the operator image
------------------------------------

To building and push the operator image to your registry,
edit version in Makefile and enter:

```bash
make docker-build docker-push
make deploy
```

or set operator version over env variable:

```bash
make docker-build docker-push  VERSION="0.0.2"
make deploy  VERSION="0.0.2"
```

Deploy operator and used
------------------------

```bash
kubectl get deployment -n memcached-operator-system
kubectl apply -f config/samples/cache_v1alpha1_memcached.yaml
kubectl get pods  -n default
```

TROUBLESHOOTING
---------------

### WATCH LOGS

```bash
$ kubectl logs deployment/memcached-operator-controller-manager -c manager -n memcached-operator-system -f
```

### CHANGE LOG LEVEL OF ANSIBLE

Add

```yaml
  containers:
  - name: manager
    env:
    - name: ANSIBLE_DEBUG_LOGS
      value: "True"
```

In file config/manager/manager.yaml


How to contribute an Operator
-----------------------------

todo

Externel documentation
----------------------

- [Download released bin](https://github.com/operator-framework/operator-sdk/releases/)
- [github.com project](https://github.com/operator-framework/operator-sdk)
- [installation](https://github.com/operator-framework/operator-sdk/blob/master/doc/user/install-operator-sdk.md)
- [install / sdk.operatorframework.io](https://sdk.operatorframework.io/docs/installation/)
- [contribute an operator](https://operatorhub.io/contribute)