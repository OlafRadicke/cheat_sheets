kubectl (k8s/k3s) cheat sheet
=============================

Remote control
--------------

For remote controll of k3s, you have copy the file /etc/rancher/k3s/k3s.yaml 
to your control server, in the homedirectory of the control user:

```bash
mkdir ~/.kube/
scp k3s-server:/etc/rancher/k3s/k3s.yaml ~/.kube/config
```

And change the server adress in the configuration.

```bash
sed -i "s#server: https://localhost:6443#server: https://k3s-server:6443#g" ~/.kube/config
```

List pods
---------

Enter:

```bash
kubectl get pod
```

From all name spaces, enter:

```bash
kubectl get pods -A
```

Get cluster nodes
-----------------

Enter:

```bash
kubectl get nodes
```

List pod ports
--------------

Enter:

```bash
kubectl get svc
```

Check cluster state
-------------------

Enter:

```bash
kubectl cluster-info dump
```

Understanding namespaces and DNS
--------------------------------

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

Service resources
-----------------

In Kubernetes, a Service is an abstraction which defines a logical set of Pods
and a policy by which to access them (sometimes this pattern is called a
micro-service).

List services
-------------

```bash
kubectl get service
```

Delete deployments
------------------

```bash
kubectl delete deployment my-pod
```

Delete all pods and services in a namespace
-------------------------------------------

```bash
kubectl -n my-namespace delete po,svc --all
```

Troubleshooting
---------------

```bash

[or@augsburg03 tmp]$ kubectl describe pod lb-69967cfdb-jlsf5
Name:           lb-69967cfdb-jlsf5
Namespace:      buildbot-test
Priority:       0
Node:           aks-default-25584779-vmss000000/10.240.0.4
Start Time:     Sun, 29 Mar 2020 15:05:11 +0200
Labels:         app=lb
                pod-template-hash=69967cfdb
Annotations:    <none>
Status:         Pending
IP:             
Controlled By:  ReplicaSet/lb-69967cfdb
Containers:
  lb:
    Container ID:   
    Image:          dockercloud/haproxy
    Image ID:       
    Ports:          8080/TCP, 9989/TCP
    Host Ports:     0/TCP, 0/TCP
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-4ck7q (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  lb-claim0:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  lb-claim0
    ReadOnly:   false
  default-token-4ck7q:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-4ck7q
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason              Age                  From                                      Message
  ----     ------              ----                 ----                                      -------
  Warning  FailedScheduling    29m (x5 over 29m)    default-scheduler                         pod has unbound immediate PersistentVolumeClaims
  Normal   Scheduled           29m                  default-scheduler                         Successfully assigned buildbot-test/lb-69967cfdb-jlsf5 to aks-default-25584779-vmss000000
  Warning  FailedMount         2m6s (x12 over 27m)  kubelet, aks-default-25584779-vmss000000  Unable to mount volumes for pod "lb-69967cfdb-jlsf5_buildbot-test(be73f78b-773d-4666-8325-ff9c05097817)": timeout expired waiting for volumes to attach or mount for pod "buildbot-test"/"lb-69967cfdb-jlsf5". list of unmounted volumes=[lb-claim0]. list of unattached volumes=[lb-claim0 default-token-4ck7q]
  Warning  FailedAttachVolume  30s (x22 over 29m)   attachdetach-controller                   AttachVolume.Attach failed for volume "pvc-7f8ea625-3605-4941-bda3-72a1f09b665f" : compute.VirtualMachineScaleSetVMsClient#Update: Failure sending request: StatusCode=400 -- Original Error: Code="InvalidParameter" Message="Requested operation cannot be performed because the VM size Standard_D2_v2 does not support the storage account type Premium_LRS of disk 'kubernetes-dynamic-pvc-7f8ea625-3605-4941-bda3-72a1f09b665f'. Consider updating the VM to a size that supports Premium storage." Target="dataDisk.managedDisk.storageAccountType"
```