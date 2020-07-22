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

See [kubectl/get_infos.md](kubectl/get_infos.md)


Understanding namespaces and DNS
--------------------------------

See [kubectl/namespaces.md](kubectl/namespaces.md)

Troubleshooting
---------------

See [kubectl/troubleshooting.md](kubectl/troubleshooting.md)


Delete deployments
------------------

See [kubectl/deployments.md](kubectl/deployments.md)

Port forward
------------

```bash
export POD_NAME=$(kubectl get pods --namespace testenv -l "app=my-concourse-web" -o jsonpath="{.items[0].metadata.name}")
    kubectl port-forward --namespace testenv $POD_NAME 8080:8080
```

After this step visit now http://127.0.0.1:8080


Secrets
-------

See [kubectl/secrets.md](kubectl/secrets.md)
