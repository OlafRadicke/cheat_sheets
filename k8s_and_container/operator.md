Kubernetes Operator (with SDK)
==============================


Install the Operator SDK CLI
----------------------------

Under Linux:

[Download released bin](https://github.com/operator-framework/operator-sdk/releases/),
make it executable and copy to /usr/local/bin/operator-sdk


Build an operator using the Operator SDK
----------------------------------------

Init a ansible operator project:

```bash
operator-sdk init --plugins=ansible --domain example.com
```

Create an API scaffold:

```bash
operator-sdk create api --group cache --version v1alpha1 --kind Memcached --generate-role
```

Building and pushing the operator container to your registry:

```bash
make docker-build docker-push IMG=<some-registry>/<project-name>:tag
```


How to contribute an Operator
-----------------------------



Externel documentation
----------------------

- [Download released bin](https://github.com/operator-framework/operator-sdk/releases/)
- [github.com project](https://github.com/operator-framework/operator-sdk)
- [installation](https://github.com/operator-framework/operator-sdk/blob/master/doc/user/install-operator-sdk.md)
- [install / sdk.operatorframework.io](https://sdk.operatorframework.io/docs/installation/)
- [contribute an operator](https://operatorhub.io/contribute)