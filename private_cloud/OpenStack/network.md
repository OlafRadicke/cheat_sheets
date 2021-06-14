Network
=======


***Create network***

```bash
$ openstack network create net-01
```

***Create an subnet***

```bash
$ openstack subnet create \
  --subnet-pool 10.0.0.0/29 \
  --network net-01 \
  subnet-01
```