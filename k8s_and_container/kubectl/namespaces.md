Understanding namespaces and DNS
================================

When you create a Service, it creates a corresponding DNS entry. This entry is
of the form <service-name>.<namespace-name>.svc.cluster.local, which means that
if a container just uses <service-name> it will resolve to the service which
is local to a namespace. This is useful for using the same configuration
across multiple namespaces such as Development, Staging and Production. If
you want to reach across namespaces, you need to use the fully qualified
domain name (FQDN)

List the current namespaces
---------------------------

```bash
kubectl get namespaces
```

Creating a new namespace
------------------------

```bash
kubectl create namespace <insert-namespace-name-here>
```

Deleting a namespace
--------------------

This deletes everything under the namespace!

```bash
kubectl delete namespaces development
```

Delete all pods and services in a namespace
-------------------------------------------

```bash
kubectl -n my-namespace delete po,svc --all
```
