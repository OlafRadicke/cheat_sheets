Helm cheat sheet
================

Installation helm
-----------------

Check available versions: [GitHub Project](https://github.com/helm/helm/releases):

```bash
HELMVERSION=3.2.0-rc.1
HELMVERSION=3.5.4
wget https://get.helm.sh/helm-v${HELMVERSION}-linux-amd64.tar.gz
tar -xvzf ./helm-v${HELMVERSION}-linux-amd64.tar.gz
sudo cp ./linux-amd64/helm  /usr/local/bin/helm
```
Version 3.x is *triller less* ;-)


Overview about available helm commands
--------------------------------------

```
  completion  Generate autocompletions script for the specified shell (bash or zsh)
  create      create a new chart with the given name
  dependency  manage a chart's dependencies
  env         Helm client environment information
  get         download extended information of a named release
  help        Help about any command
  history     fetch release history
  install     install a chart
  lint        examines a chart for possible issues
  list        list releases
  package     package a chart directory into a chart archive
  plugin      install, list, or uninstall Helm plugins
  pull        download a chart from a repository and (optionally) unpack it in local directory
  repo        add, list, remove, update, and index chart repositories
  rollback    roll back a release to a previous revision
  search      search for a keyword in charts
  show        show information of a chart
  status      displays the status of the named release
  template    locally render templates
  test        run tests for a release
  uninstall   uninstall a release
  upgrade     upgrade a release
  verify      verify that a chart at the given path has been signed and is valid
  version     print the client version information

```

Working with helm charts
------------------------

### Search charts in hub ###

Search for a gitlab chart in the helm repo:

```bash
helm search hub gitlab
```

### Add a repo ###

Add the repo of the official Helm stable charts:

```bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
```

### Serach in a repo ###

Search for a gitlab chart in all repos:

```bash
helm search repo gitlab
```

### Information about an chart ###

```bash
helm show chart stable/gitlab-ce
```

### Get and configure chart variables ###

Get variables of a chart:

```bash
helm show values stable/mariadb
```

Set variables of a chart:

```bash
$ echo '{mariadbUser: user0, mariadbDatabase: user0db}' > config.yaml
$ helm install -f config.yaml stable/mariadb --generate-name
```


### Install a chart ###

```bash
helm install my-postgresql-installation stable/postgresql
```

### Check (list) installations ###

```bash
helm ls
```

or

```bash
helm list -aq
```

### Deinstall a helm chart ###
----------------------

```bash
helm delete my-postgresql-installation --namespace testenv
```

Developing
----------

### Check you helm code (linting) ###

```bash
[or@augsburg02 buildbot-helm-operator]$ ~/bin/helm  lint ./helm-charts/buildbot/ --strict
==> Linting ./helm-charts/buildbot/
[INFO] Chart.yaml: icon is recommended
[ERROR] templates/: render error in "buildbot/templates/buildbot-worker-deployment.yaml": template: buildbot/templates/buildbot-worker-deployment.yaml:8:22: executing "buildbot/templates/buildbot-worker-deployment.yaml" at <.Values.worker_replicas>: map has no entry for key "worker_replicas"
```

### Check template result

```
helm template ./chart_src/ --debug
```

### Install from a local directory ###

```bash
helm install --create-namespace --namespace testenv my-test-installation ./helm-charts/buildbot/
```

### Upgrade from a local directory ###

Afeter local changes:

```bash
helm upgrade --namespace testenv my-test-installation ./helm-charts/buildbot/
```

### Upgrade with recreate of pods ###

```bash
helm upgrade  --recreate-pods --namespace testenv my-test-installation ./helm-charts/buildbot/
```

Known issue
-----------

### k3s: "Kubernetes cluster unreachable" ###

```bash
[fedora@localhost ~]$ helm install my-postgresql-installation stable/postgresql
WARNING: This chart is deprecated
Error: Kubernetes cluster unreachable
```

Enter this to fix this:
```bash
bash -c 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml && helm install my-postgresql-installation stable/postgresql  '
```

Or better copy /etc/rancher/k3s/k3s.yaml to ~/.kube/config

External links
--------------

* [Helm Chart for Gitea as example](https://hub.helm.sh/charts/k8s-land/gitea)
* [Helm Chart for AWX as example](https://hub.helm.sh/charts/lifen/awx)
* [How to Create Your First Helm Chart](https://docs.bitnami.com/kubernetes/how-to/create-your-first-helm-chart/)
* [Complete list of the official helmet charts](https://github.com/helm/charts/tree/master/stable)