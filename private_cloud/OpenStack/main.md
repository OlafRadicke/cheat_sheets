OpenStack
=========

OpenStack client install
------------------------

```bash
$ sudo dnf install python-openstackclient
```

Authentication
--------------

Create file like this...

```bash
$ export OS_IDENTITY_API_VERSION=3
$ export OS_AUTH_URL=http://localhost:5000/v3
$ export OS_DEFAULT_DOMAIN=default
$ export OS_USERNAME=admin
$ export OS_PASSWORD=secret
$ export OS_PROJECT_NAME=admin
```

And used like this:

```bash
$ source ~/.openstack/public-cloud.sh

```


List VM types
-------------

```bash
$ openstack flavor list
```

List images
-----------

```bash
openstack image list
```

List availability zones
-----------------------

```bash
openstack availability zone list
```
