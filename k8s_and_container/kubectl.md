kubectl (k8s/k3s) cheat sheet
=============================

Installation
------------

```bash
sudo dnf install kubernetes-client
```

Configuration
-------------

### Remote control (k3s) ###


For remote controll of k3s, you have copy the file /etc/rancher/k3s/k3s.yaml 
to your control server, in the homedirectory of the control user:

```bash
mkdir ~/.kube/
scp root@k3s-server:/etc/rancher/k3s/k3s.yaml ~/.kube/config
```

And change the server adress in the configuration.

```bash
sed -i "s#server: https://localhost:6443#server: https://k3s-server:6443#g" ~/.kube/config
```

### Remote control (Azure Cloud) ###

See [Azure cheats](../azure/)


Overview cluster
----------------

### List pods ###

```bash
kubectl get pod
```

From all name spaces, enter:

```bash
kubectl get pods -A
```

### Get cluster nodes ###

```bash
kubectl get nodes
```

### List pod ports ###


```bash
kubectl get svc
```

### Display CPU/Memory/Storage ####

```bash
kubectl top node
kubectl top pod -A
```

### Check cluster state ###

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

### List the current namespaces ###

```bash
kubectl get namespaces
```

### Creating a new namespace ###

```bash
kubectl create namespace <insert-namespace-name-here>
```

### Deleting a namespace ###

This deletes everything under the namespace!

```bash
kubectl delete namespaces development
```

### Delete all pods and services in a namespace ###

```bash
kubectl -n my-namespace delete po,svc --all
```

Service resources
-----------------

In Kubernetes, a Service is an abstraction which defines a logical set of Pods
and a policy by which to access them (sometimes this pattern is called a
micro-service).

### List services ###

```bash
kubectl get service
```

### Delete deployments ###

```bash
kubectl delete deployment my-pod
```

port-forward
------------

```bash
export POD_NAME=$(kubectl get pods --namespace testenv -l "app=my-concourse-web" -o jsonpath="{.items[0].metadata.name}")
    kubectl port-forward --namespace testenv $POD_NAME 8080:8080
```

After this step visit now http://127.0.0.1:8080


Troubleshooting
---------------

### Get pod details ###

```bash
kubectl describe pod lb-69967cfdb-jlsf5

```

### Get details of all Pods ###

```bash
kubectl describe pods
```

### Adhoc (network) checks ###

```bash
$ [or@augsburg03 local]$ kubectl exec loadbalancer-85df47799d-94jms -- ping -c 1 10.0.224.30
PING 10.0.224.30 (10.0.224.30): 56 data bytes

--- 10.0.224.30 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss
command terminated with exit code 1

```

### Get logs of http-application-routing ###

```bash
kubectl logs -f deploy/

```

### Attach on crashed pods ###

```bash
[or@augsburg03 low_level_k8s_buildbot_deployment]$ kubectl run buildbot-demo --image=olafradicke/alternativ_buildbot_master:vv2.7.0r6 --restart=Never
pod/buildbot-demo created

[or@augsburg03 low_level_k8s_buildbot_deployment]$ kubectl get pods
NAME                             READY   STATUS             RESTARTS   AGE
buildbot-demo                    1/1     Running            0          11s
buildbot-f6ff5c469-5frw9         0/1     CrashLoopBackOff   9          22m
db-7875648874-6wzvm              1/1     Running            0          26m
loadbalancer-846f8b8dc4-djfjv    1/1     Running            0          26m
mq-5f79c957d4-cmwnq              1/1     Running            0          25m
webapp-74c75bbb86-87gkq          1/1     Running            0          25m
worker-5665cb8df5-zd4g6          1/1     Running            7          25m

[or@augsburg03 low_level_k8s_buildbot_deployment]$ kubectl exec -it buildbot-demo sh
/srv/buildbot $ ls
buildbot.tac       http.log           master.cfg         master.cfg.sample  start_buildbot.sh  twistd.pid
/srv/buildbot $ 
```