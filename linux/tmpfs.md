tmpfs
=====


```bash
[or@augsburg03 ~]$ mount | grep tmpfs
devtmpfs on /dev type devtmpfs (rw,nosuid,seclabel,size=7077068k,nr_inodes=1769267,mode=755)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,seclabel)
tmpfs on /run type tmpfs (rw,nosuid,nodev,seclabel,mode=755)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,seclabel)
tmpfs on /run/user/1001 type tmpfs (rw,nosuid,nodev,relatime,seclabel,size=1426628k,mode=700,uid=1001,gid=1001)
tmpfs on /run/user/1002 type tmpfs (rw,nosuid,nodev,relatime,seclabel,size=1426628k,mode=700,uid=1002,gid=1002)
```

Mount command:

```bash
mount -t tmpfs -o size=1G,nr_inodes=10k,mode=0700 tmpfs /space
```

The size means maximum size. The default size is the half of the RAM size.