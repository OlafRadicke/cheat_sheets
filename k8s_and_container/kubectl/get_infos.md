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

Wit detail information

```bash
kubectl get pods --output=wide -A
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

Get infos about pvc
-------------------

```bash
kubectl get pv
```

```bash
$ kubectl describe pv

Name:              pvc-d2ed7e21-5b89-4e1b-a1a3-5992115eb6b6
Labels:            failure-domain.beta.kubernetes.io/region=westeurope
Annotations:       pv.kubernetes.io/bound-by-controller: yes
                   pv.kubernetes.io/provisioned-by: kubernetes.io/azure-disk
                   volumehelper.VolumeDynamicallyCreatedByKey: azure-disk-dynamic-provisioner
Finalizers:        [kubernetes.io/pv-protection]
StorageClass:      managed-premium
Status:            Bound
Claim:             demoenv/demo-azure-managed-disk
Reclaim Policy:    Delete
Access Modes:      RWO
VolumeMode:        Filesystem
Capacity:          2Gi
```

About routing
-------------

Find ingress resources

```
kubectl get ingress -A
```

Show ingress routes:

```
kubectl describe ingressroutes -A
```

```
sudo kubectl describe service traefik -n kube-system
```

```
kubectl logs -f traefik-56c4b88c4b-j4686 -n kube-system
```

```
kubectl get  IngressRoute -n kube-system
```

Get infos about evalabile resources typs
----------------------------------------

```
kubectl api-resources
```