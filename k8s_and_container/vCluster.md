# vCluster

## INSTALLATION

### CLIENT

Check release number on [](https://github.com/loft-sh/vcluster)

```bash
$ export VCLUSTER_VERSION=v0.27.0
$ curl -L -o vcluster "https://github.com/loft-sh/vcluster/releases/download/${VCLUSTER_VERSION}/vcluster-linux-amd64" && sudo install -c -m 0755 vcluster /usr/local/bin && rm -f vcluster
```

### vCLUSTER

#### WITH CLIENT

Create `vcluster.yaml` with configuration like a Helm Chart

```bash
$ vcluster create vcluster-01 \
--namespace vcluster-01 \
--values vcluster.yaml
```

#### WITH HELM CHART

```bash
$ helm repo add loft-sh https://charts.loft.sh
$ helm repo update
$ helm upgrade vcluster-01 loft-sh/vcluster \
--install \
--namespace vcluster-01
```

#### WITH ARGOCD

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-vcluster
  namespace: argocd
spec:
  project: default
  source:
    chart: vcluster
    repoURL: https://charts.loft.sh
    targetRevision: *
    helm:
      releaseName: my-vcluster
  destination:
    server: https://kubernetes.default.svc
    namespace: team-x
```

[Virtual Clusters in Minutes](https://www.vcluster.com/install)

## USE THE vCLUSTER

Switch to vCluster

```bash
$ vcluster connect vcluster-01 -n vcluster-01
```

Since you are using port-forwarding to connect, you will need to leave this terminal open

- Use CTRL+C to return to your previous kube context
- Use `kubectl get namespaces` in another terminal to access the vcluster

or:

```bash
$ vcluster disconnect
```

## EXPOSE vCLUSTER

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    # We need the ingress to pass through ssl traffic to the vCluster
    # This only works for the nginx-ingress (enable via --enable-ssl-passthrough
    # https://kubernetes.github.io/ingress-nginx/user-guide/tls/#ssl-passthrough )
    # for other ingress controllers check their respective documentation.
    nginx.ingress.kubernetes.io/backend-protocol: HTTPS
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
  name: vcluster-ingress
  namespace: vcluster-01
spec:
  ingressClassName: nginx # use your ingress class name
  rules:
    - host: vcluster-01.example.com
      http:
        paths:
          - backend:
              service:
                name: vcluster-01
                port:
                  number: 443
            path: /
            pathType: ImplementationSpecific
```

Deploy ingress:

```bash
$ kubectl apply \
-f ingress.yaml \
-n my-vcluster
```

Details see [Expose vCluster](https://www.vcluster.com/docs/vcluster/manage/accessing-vcluster#expose-vcluster)

## CREATE A KUBE CONTEXT FOR A vCLUSTER ADMIN

```bash
vcluster connect vcluster-01 -n vcluster-01 \
--service-account kube-system/admin-user-01 \
--cluster-role cluster-admin
```

Details see: [Connect using Service Accounts](https://www.vcluster.com/docs/vcluster/manage/accessing-vcluster#connect-using-service-accounts)

## LINKS

- [Helm Char install](https://github.com/loft-sh/vcluster/tree/main/chart)
- [Documentation](https://www.vcluster.com/docs/vcluster/)
