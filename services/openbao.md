OpenBao
=======

- [OpenBao](#openbao)
	- [LINKS](#links)
	- [CLI](#cli)
	- [Pre step OpenBao / vault cli](#pre-step-openbao--vault-cli)
		- [/etc/hosts](#etchosts)
		- [Add openbao env variables](#add-openbao-env-variables)
		- [Use vault cli](#use-vault-cli)


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
