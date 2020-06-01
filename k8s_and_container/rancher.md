Rancher
=======

* [About concepts](https://rancher.com/blog/2019/2019-02-04-rancher-vs-rke/)

### Cloud-Config ###

* [Documentation](https://rancher.com/docs/os/v1.x/en/configuration/#cloud-config)

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

* [Documentation](https://github.com/rancher/k3os)
* [High Availability with an External DB](https://rancher.com/docs/k3s/latest/en/installation/ha/)


k3os
----

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