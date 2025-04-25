OpenStack
=========

OpenStack client install
------------------------

```bash
$ sudo dnf install python-openstackclient
```

OpenStack Client configuration
------------------------------

Download RC  file and enter:


```bash
$ source 9231-openstack-4707c-openrc.sh
$ openstack ec2 credentials create
```


List availability zones
-----------------------

```bash
openstack availability zone list
```

Jason quarry
------------

```bash
$ openstack security group list \
  --format json \
  2> /dev/null \
  | jq '.[]."Name"'
```

Other topics
------------

* [Authentication](authentication.md)
* [Firewall](firewall.md)
* [Floating IP address](floting_ip.md)
* [Key pair](keypair.md)
* [Network](network.md)
* [VMs](vm.md)