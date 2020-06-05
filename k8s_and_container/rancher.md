Rancher
=======

* [About concepts](https://rancher.com/blog/2019/2019-02-04-rancher-vs-rke/)



### Cloud-Config ###

* [Documentation](https://rancher.com/docs/os/v1.x/en/configuration/#cloud-config)

***Node: ssh key with password are not working with k3os!***

Example:

```yaml
---

hostname: rancheros-01
ssh_authorized_keys:
  -   ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzNWhN/MJbTHy3iqERpb2KK0tbj7aPAU/[...]]9DI8= radickeo@NB-FF-654
rancher:
  docker:
    tls: true
  resize_device: /dev/sda
```

Validating a Configuration File:

```bash
sudo ros config validate -i http://192.168.178.60/rancheros-01.yml
```


Rancher Kubernetes Engine (RKE)
-------------------------------

* [Documentatio](https://rancher.com/docs/rke/latest/en/)
* [Download RKE](https://github.com/rancher/rke/releases) and copy to */usr/local/bin/rke*
* [Kubernetes Configuration Options](https://rancher.com/docs/rke/latest/en/config-options/)

The reference distribution of RKE is Ubuntu LTS.

Create a cluser configuration:

```bash
rke config --name cluster.yml
```

Rollut the cluster configuration:

```bash
rke -d up
```

k3s
---

* [High Availability with an External DB](https://rancher.com/docs/k3s/latest/en/installation/ha/)

Cluster access (only on Master):

```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get pods --all-namespaces
```

Add a worker to a cluster:

```bash
 sudo k3s agent --server https://192.168.178.72:6443  --token ThisClusterConfigurationIsNeverForProduction
```

With label:

```bash
 sudo k3s agent --server https://192.168.178.72:6443 \
      --token ThisClusterConfigurationIsNeverForProduction \
      --node-name kube-poc-02 \
      --node-label worker
```

k3os
----

* [Documentation](https://github.com/rancher/k3os)

For installation enter

```bash
sudo k3os install
```

Find the kube config:

```bash
 sudo cat /etc/rancher/k3s/k3s.yaml
 ```

Get cluster token. Enter on the master:

```bash
sudo cat  /var/lib/rancher/k3s/server/node-token
```

k3s configuration is located in  /k3os/system/config.yaml



RancherOS
---------

* [Image download](https://github.com/rancher/os/releases/)



### Install with ISO file ###

* Configure a webserver with the node configuration (Cloud-Config). 
* Boot IOS image.
* Enter 
```bash
sudo ros install -c http://192.168.178.60/rancheros-01.yml -d /dev/sda
```