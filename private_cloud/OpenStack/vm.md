Virtual server
==============

***List VM types***

```bash
$ openstack flavor list
```

***List images***

```bash
openstack image list
```

***Create VM from an image***

```bash
$ openstack server create \
  --flavor FLAVOR_ID \
  --image IMAGE_ID \
  --key-name KEY_NAME \
  --user-data USER_DATA_FILE \
  --security-group SEC_GROUP_NAME \
  --property KEY=VALUE \
  INSTANCE_NAME
```

***List VMs***

```bash
$ openstack server list
```

***View console log of a VM***


```bash
$ openstack console log show MyFirstInstance
```

***Pause, suspend, stop, rescue, resize, rebuild, reboot an instance***


```bash
$ openstack server pause NAME
```
