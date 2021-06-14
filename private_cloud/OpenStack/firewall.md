Fire wall / Security groups
===========================

***List security groups***

```bash
$ openstack security group list
```

***List of security group rules***

```bash
$ openstack security group rule list default
```

***Create security group***

```bash
$ openstack security group create SECURITY_GROUP_NAME --description GROUP_DESCRIPTION
```

***Delete security group***

```bash
$ openstack security group delete SECURITY_GROUP_NAME
```

***List security rule***

```bash
$ openstack security group rule list SECURITY_GROUP_NAME
```

***Create security rule***

```bash
$ openstack security group rule create \
  --protocol tcp \
  --dst-port 22:22 \
  --remote-group SOURCE_GROUP_NAME \
  SECURITY_GROUP_NAME
```

***Add a security group to a VM***

```bash
openstack server add security group <server> <group>
```