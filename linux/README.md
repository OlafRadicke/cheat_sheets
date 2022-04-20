
Linux
=====

* [tmpfs](linux/tmpfs.md)


Workarout for Docker under Fedora
---------------------------------

See https://fedoramagazine.org/docker-and-fedora-32/

Systend
-------

Seting services:

```bash
systemctl edit <service>
systemctl daemon-reload
journalctl -xe
```


Let run a job in background by systemd:

```bash
$ sudo systemd-run --uid=backupuser  -r --description=started_by_hand bash  -x  /opt/scripts/backup.sh

Running as unit: run-rce046e99531b47869abdcdda7bd19a56.service

$ sudo journalctl -u run-rce046e99531b47869abdcdda7bd19a56.service
```

See: [systemd-run](https://www.freedesktop.org/software/systemd/man/systemd-run.html)