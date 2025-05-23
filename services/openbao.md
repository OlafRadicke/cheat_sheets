OpenBao
=======

- [OpenBao](#openbao)
	- [LINKS](#links)
	- [CLI](#cli)
	- [Pre step OpenBao / vault cli](#pre-step-openbao--vault-cli)
		- [/etc/hosts](#etchosts)
		- [Add openbao env variables](#add-openbao-env-variables)
		- [Use vault cli](#use-vault-cli)
			- [health check](#health-check)
			- [health check pki](#health-check-pki)
			- [verify sign](#verify-sign)
			- [list child issuers](#list-child-issuers)


LINKS
-----

- [Git-Repo](https://github.com/openbao)
- [Helm Chart](https://github.com/openbao/openbao-helm/tree/main)
- [PKI wit OpenBao](https://openbao.org/docs/secrets/pki/)
- [OpenBao with OpenTofu](https://opentofu.org/docs/language/state/encryption/#openbao-experimental)
- [OpenBao cli](https://openbao.org/docs/commands/)

CLI
---

OpenBao have no cli package. See [issue](https://github.com/openbao/openbao/issues/162)
Use vault cli

Pre step OpenBao / vault cli
----------------------------


### /etc/hosts

Add OpenBao-Server in line...

```bash
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4 openbao.openbao
```

### Add openbao env variables

Add file `${HOME}/.ssh/openbao.env` with content:

```bash
export VAULT_TOKEN=XXXXXXX
export VAULT_ADDR='http://openbao.openbao:8083'
```

Add this line in file `~/.bashrc`

```bash
source ${HOME}/.ssh/openbao.env
```

### Use vault cli

[Origen docu](https://developer.hashicorp.com/vault/docs/commands/pki)

#### health check

```bash
$ vault status
```


#### health check pki


```bash
$ PKI_PATH=pki_root_ca

$ vault pki health-check $PKI_PATH
```

#### verify sign

```bash
$ vault pki verify-sign pki_root/issuer/root pki_int/issuer/FirstDepartment
```
#### list child issuers

```bash
$ PKI_PATH=pki_root_ca
$ vault pki list-intermediates /${PKI_PATH}/issuer/default
```