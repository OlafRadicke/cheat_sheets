Overview about the cluster
==========================

List pods
---------

```bash
kubectl get pod
```

From all name spaces, enter:

```bash
kubectl get pods -A
```

Get cluster nodes
-----------------

```bash
kubectl get nodes
```

List of services
----------------

```bash
kubectl get service -A
```

Display CPU/Memory/Storage
--------------------------

```bash
kubectl top node
kubectl top pod -A
```

Check cluster state
-------------------

```bash
kubectl cluster-info dump
```