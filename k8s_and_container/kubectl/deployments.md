Deployments
===========

```bash
kubectl create -f somthing.yaml
```

Delete deployments
------------------

```bash
kubectl delete deployment my-pod
```

Using a private image repository with secrets
---------------------------------------------

Create secrets "regcred" in ansible:

```yml
- name:          Create secret
  shell:         |
                  kubectl create \
                  secret \
                  docker-registry regcred \
                  --docker-server="{{ registry_url }}" \
                  --docker-username="{{ container_repo_user }}" \
                  --docker-password="{{ container_repo_user_password }}" \
                  --docker-email=ansible@fondsfinanc.de
  register:      return_value
  ignore_errors: yes
  no_log:        true

```
Us secrets "regcred" in kubernetes:

```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
    name: registry-test
    labels:
        app: registry-test
spec:
    replicas: 1
    selector:
        matchLabels:
            app: registry-test
    template:
        metadata:
            labels:
                app: registry-test
        spec:
            containers:
            - name: registry-test
              image: {{ registry_url }}/nsa/docker/nginx:3.0.0
              ports:
              - containerPort: 80
            imagePullSecrets:
            - name: regcred
```