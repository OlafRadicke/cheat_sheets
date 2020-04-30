Concourse ci
============

Installation
------------

``bash
$ kubectl create namespace testenv
$ helm repo add stable https://kubernetes-charts.storage.googleapis.com/
$ helm repo add concourse github.com/concourse/concourse-chart
```
Edit config file.

```bash
$ helm show values concourse/concourse-chart > config.yaml
$ helm install -f config.yaml -n testenv my-concourse  concourse/concourse-chart
```

Install flay from https://github.com/concourse/concourse/releases/tag/v6.0.0

```bash
wget https://github.com/concourse/concourse/releases/download/v6.0.0/concourse-6.0.0-linux-amd64.tgz

tar -xvzf concourse-6.0.0-linux-amd64.tgz

sudo mv /home/or/Downloads/fly-6.0.0-linux-amd64/fly ~/bin/fly
```

Create file with content. For example (task_hello_world.yml):

```yaml
---
platform: linux

image_resource:
  type: docker-image
  source: {repository: busybox}

run:
  path: echo
  args: [hello world]
```

Enter:

```bash
~/bin/fly --target tutorial login --concourse-url http://127.0.0.1:8080 -u test -p test
~/bin/fly --target status
~/bin/fly -t tutorial execute -c  /tmp/task_hello_world.yml

```










Links
-----

* [Projekt page](https://concourse-ci.org/)
* [Helm chart](github.com/concourse/concourse-chart)
* [Tutorial](https://concoursetutorial.com/basics/task-hello-world/)