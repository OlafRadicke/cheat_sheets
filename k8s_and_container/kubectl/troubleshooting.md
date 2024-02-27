Troubleshooting
===============

Get pod details
---------------

```bash
kubectl describe pod lb-69967cfdb-jlsf5

```

```bash
$ kubectl describe pod monitoring-677f86fcff-27mjl -n monitoring-01
```

Get details of all Pods
-----------------------

```bash
kubectl describe pods
```

```bash
$ kubectl get pods -o wide
```

Port forward
------------

```bash
export POD_NAME=$(kubectl get pods --namespace testenv -l "app=my-concourse-web" -o jsonpath="{.items[0].metadata.name}")

kubectl port-forward $POD_NAME 8080:8080 --namespace testenv
```

or alternative over service

```bash
kubectl port-forward service/testenv 8080:80 -n testenv
```


After this step visit now http://127.0.0.1:8080

Is it on a remote host, open a new ssh connection with:

```
ssh -L [LOCAL_IP:]LOCAL_PORT:DESTINATION:DESTINATION_PORT [USER@]SSH_SERVER
```

Adhoc (network) checks
----------------------

```bash
$ kubectl exec loadbalancer-85df47799d-94jms -- ping -c 1 10.0.224.30
PING 10.0.224.30 (10.0.224.30): 56 data bytes

--- 10.0.224.30 ping statistics ---
1 packets transmitted, 0 packets received, 100% packet loss
command terminated with exit code 1
```

Get logs of http-application-routing
------------------------------------

```bash
kubectl logs -f deploy/

```

Attach on running pod
---------------------

```bash
kubectl exec -it my-pod-k8s-5cd4c85695-8lxlc sh

```

or

```bash
$ kubectl exec -it [pod-name] -c [container-name] -n [namespace]  -- sh
```

Attach on crashed pods
----------------------

```bash
$ kubectl run buildbot-demo --image=olafradicke/alternativ_buildbot_master:vv2.7.0r6 --restart=Never
pod/buildbot-demo created

$ kubectl get pods
NAME                             READY   STATUS             RESTARTS   AGE
buildbot-demo                    1/1     Running            0          11s
buildbot-f6ff5c469-5frw9         0/1     CrashLoopBackOff   9          22m
db-7875648874-6wzvm              1/1     Running            0          26m
loadbalancer-846f8b8dc4-djfjv    1/1     Running            0          26m
mq-5f79c957d4-cmwnq              1/1     Running            0          25m
webapp-74c75bbb86-87gkq          1/1     Running            0          25m
worker-5665cb8df5-zd4g6          1/1     Running            7          25m

$ kubectl exec -it buildbot-demo sh
/srv/buildbot $ ls
buildbot.tac       http.log           master.cfg         master.cfg.sample  start_buildbot.sh  twistd.pid
/srv/buildbot $
```

### Get events ###

```bash
$ kubectl get events -n bla

LAST SEEN   TYPE      REASON               OBJECT                                        MESSAGE
10m         Warning   FailedScheduling     pod/influxdb-59fc9776bb-jzct9                 0/1 nodes are available: 1 pod has unbound immediate PersistentVolumeClaims.
10m         Warning   FailedScheduling     pod/influxdb-59fc9776bb-jzct9                 0/1 nodes are available: 1 pod has unbound immediate PersistentVolumeClaims.
10m         Normal    SuccessfulCreate     replicaset/influxdb-59fc9776bb                Created pod: influxdb-59fc9776bb-jzct9
4s          Warning   ProvisioningFailed   persistentvolumeclaim/influxdb-managed-disk   no volume plugin matched name: kubernetes.io/Azure-disk
10m         Normal    ScalingReplicaSet    deployment/influxdb                           Scaled up replica set influxdb-59fc9776bb to 1
```


ImagePullBackOff
----------------

Pull image interactive

```bash
$ sudo crictl pull --creds "sp-ansible:XEHLwnCYayXXXXXXX"   "gitlab-01-01.room-dev.lab-sn.de:5050/secure-collaboration-room/sr-portal/sr-portal:1.2.3"

Image is up to date for sha256:0600ad29e4b4ea05fb1c80912356dbf305118924046af7b6d2904e64a6c58c78
```


Ingress
-------

```bash
$ kubectl logs -l app=ingress-nginx --since 10m
```

Kubernetes Namespaces stuck in Terminating status
-------------------------------------------------

```bash
NAMESPACE=hugo-operator-system ; \
kubectl get namespace $NAMESPACE -o json \
| jq 'del(.spec.finalizers[0])' \
| kubectl replace --raw "/api/v1/namespaces/$NAMESPACE/finalize" -f -
```

Kubernetes pod stuck in Terminating status
------------------------------------------


```bash
kubectl delete pod xxxxx --grace-period=0  --force -n namespace
```

Remove a node from cluster

```bash
kubectl cordon <node-name>
kubectl drain <node-name> --force --ignore-daemonsets  --delete-emptydir-data
kubectl delete node <node-name>
```