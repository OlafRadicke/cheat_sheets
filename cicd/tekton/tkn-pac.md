# TKN-PAC

## CRETE NEW PIPELINE

```bash
$ kubectl create namespace teckton-pac-demo-pipeline
$ tkn-pac create repo \
      --name teckton-pac-demo \
      --namespace teckton-pac-demo-pipeline \
      --pac-namespace pipelines-as-code \
      --url https://codeberg.org/OlafRadicke/teckton-pac-demo.git
```
