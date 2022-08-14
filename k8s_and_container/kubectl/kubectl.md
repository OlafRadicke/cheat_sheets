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


Overview about the cluster
--------------------------

For debugging and more...

See [kubectl/get_infos.md](get_infos.md)


Understanding namespaces and DNS
--------------------------------

See [kubectl/namespaces.md](namespaces.md)

Troubleshooting
---------------

See [kubectl/troubleshooting.md](troubleshooting.md)


Delete deployments
------------------

See [kubectl/deployments.md](deployments.md)


Secrets
-------

See [kubectl/secrets.md](kubectl/secrets.md)
