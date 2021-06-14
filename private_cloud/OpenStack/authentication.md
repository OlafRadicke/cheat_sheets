Authentication
==============

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