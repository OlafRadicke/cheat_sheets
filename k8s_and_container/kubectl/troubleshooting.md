Troubleshooting
===============

Get pod details
---------------

```bash
kubectl describe pod lb-69967cfdb-jlsf5

```

Get details of all Pods
-----------------------

```bash
kubectl describe pods
```

Adhoc (network) checks
----------------------

```bash
$ [or@augsburg03 local]$ kubectl exec loadbalancer-85df47799d-94jms -- ping -c 1 10.0.224.30
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

Attach on crashed pods
----------------------

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
