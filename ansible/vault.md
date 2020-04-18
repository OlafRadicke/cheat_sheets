Vault
=====

Encrypting Unencrypted Files
----------------------------

Example:

```bash
ansible-vault encrypt foo.yml bar.yml
```

Using encrypted playbooks
-------------------------

```bash
ansible-playbook  --ask-vault-pass -i hosts ./setup.yml
```

External documentation
----------------------

* [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)