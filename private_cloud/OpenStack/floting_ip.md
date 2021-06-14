
Floating IP address
===================


***List floating IPs***

```bash
$ openstack floating ip pool list
```

```bash
$ openstack floating ip list
```

***Create floating ip***

```bash
$ openstack floating ip create public
```

***Add a floating ip***

```bash
$ openstack server add floating ip INSTANCE_NAME_OR_ID FLOATING_IP_ADDRESS
```

***Remove a attached floating ip***

```baash
$ openstack server remove floating ip INSTANCE_NAME_OR_ID FLOATING_IP_ADDRESS
```

***Delete a floating ip***
```
$ openstack floating ip delete FLOATING_IP_ADDRESS