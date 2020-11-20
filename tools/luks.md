LUKS
====

Create LUKS formatted partition

```bash
cryptsetup luksFormat  /dev/sdb1
```

Open a LUKS

```bash
cryptsetup luksOpen /dev/sdb1 pki_ca
```

Find mapper path

```bash
$ ls -lah /dev/mapper/ | grep pki_ca
lrwxrwxrwx  1 root root       7 Nov  6 11:41 pki_ca -> ../dm-3
```

Formating mapper

```bash
mkfs.xfs /dev/mapper/pki_ca
```

Mount mapper

```bash
mount /dev/mapper/pki_ca /srv/pki
```

Close a LUKS

```bash
cryptsetup luksClose pki_ca
```

Check state

```bash
cryptsetup status /dev/mapper/pki_ca
```
