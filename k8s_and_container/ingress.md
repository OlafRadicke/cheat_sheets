INGRESS
=======


K3s / traefik
-------------

### Exempel

```yaml
---

apiVersion:               traefik.containo.us/v1alpha1
kind:                     IngressRoute
metadata:
  name:                   tif-test-ingress-route
spec:
  entryPoints:
                          - web
                          - websecure
  routes:
    - match:              Host(`test.the-independent-friend.de`) && PathPrefix(`/`)
      kind:               Rule
      services:
        - name:           test-the-independent-friend-de
          port:           80
      middlewares:
        - name:           redirect-https-pulumi

  tls:
    secretName:           test-the-independent-friend-de

---

apiVersion:               traefik.containo.us/v1alpha1
kind:                     Middleware
metadata:
  name:                   redirect-https-pulumi
spec:
  redirectScheme:
    scheme:               https
    permanent:            true

---

apiVersion:               cert-manager.io/v1
kind:                     Certificate
metadata:
  name:                   test-the-independent-friend-de
spec:
  dnsNames:
                          - test.the-independent-friend.de
  secretName:             test-the-independent-friend-de
  issuerRef:
    name:                 letsencrypt-staging
    kind:                 ClusterIssuer

```