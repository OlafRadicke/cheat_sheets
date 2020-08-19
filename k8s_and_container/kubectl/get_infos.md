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

Get infos about pvc
-------------------

[or@augsburg02 migrationsabschnitt-2020-000]$ kubectl describe pv 
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
