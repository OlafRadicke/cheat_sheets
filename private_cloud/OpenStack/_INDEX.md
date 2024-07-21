OpenStack
=========

OpenStack client install
------------------------

```bash
$ sudo dnf install python-openstackclient
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