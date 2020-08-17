Vault
=====

Encrypting Unencrypted Files
----------------------------

Example:

```bash
ansible-vault encrypt foo.yml bar.yml
```

Encrypt string
--------------

```bash
[radickeo@localhost ansible]$ ansible-vault encrypt_string "iuefiuhefuhwerfuih" --name my_password
New Vault password: 
Confirm New Vault password: 
my_password: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          65313165313736616264356164373434306666656631376364386264653532346662376230633234
          6239653966623937356439303661366663333836373965340a386636346435353566393331303533
          38373338303964643361393461303234316333373963303261376534376663376330396666353833
          3365363030626132330a643237356261626431636531653335653938366132633430326564353964
          34393262333834633330373834326563646161313633653439363231393030373362
Encryption successful
```

Using encrypted playbooks
-------------------------

```bash
ansible-playbook  --ask-vault-pass -i hosts ./setup.yml
```

Or with password in a file

```bash
 ansible-playbook  --vault-password-file my-password-file.txt -i hosts ./setup.yml
```

External documentation
----------------------

* [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html)
