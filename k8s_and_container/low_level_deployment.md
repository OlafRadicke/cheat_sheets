# K8s low level deployment #

Example for a deployment manifast (deployment.yaml) for a pod "demo":

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
    name: demo
    labels:
        app: demo
spec:
    replicas: 1
    selector:
        matchLabels:
            app: demo
    template:
        metadata:
            labels:
                app: demo
        spec:
            containers:
            - name: demo
              image: ngenx
              ports:
              - containerPort: 80
```

Enter:

```bash
uubectl apply -f ./deployment.yaml
```

Service manifest file (service.yaml):

```yaml
apiVersion: extensions/v1beta1
kind: Service
metadata:
    name: demo
    labels:
        app: demo
spec:
    ports:
    - port: 80
      protocol: TCP
      targetPort: 8080
    selector:
        app: demo
    type: ClusterIP
```

Enter:

```bash
uubectl apply -f ./service.yaml