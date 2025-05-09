OpenTofu
========

INSTALL
-------

```bash
$ sudo dnf -y install opentofu
```

USE
---

```bash
$ tofu init
```


```bash
$ tofu plan -var "vault_token=${VAULT_TOKEN}"
```


```bash
$ tofu apply -var "vault_token=${VAULT_TOKEN}"
```