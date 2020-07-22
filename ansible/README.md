About Ansible
=============

* [Vault](vault.md)


Ansible linter
--------------

Enter:

```bash
ansible-lint my_playbook.yml
```

### Ignore linter warnings

Add a command like this:

```yaml
- name: Do thinks # noqa 301 noqa 303
  shell: pwd
  register: pwd_result
```

The errors of 301 and 303 ist ignore now.


WebHooks and REST-APIs
----------------------

### Send a message to MS Teams

```yaml
- name: Create a simple Connector Card
  office_365_connector_card:
    webhook: "{{ teams_webhook }}"
    text: "This message comes from the host {{ ansible_host }}."
  when: not ansible_check_mode
```

### Sand a attachment to Confluence

```yaml
- name: Add an attachment to the documentation # noqa 301 noqa 303
  shell: |
    curl -v -S \
    -u "{{ confluence_user }}:{{ confluence_password }}" \
    -X POST \
    -H "X-Atlassian-Token: no-check" \
    -F "file=@{{ kubeconfig_dir }}/config_{{ kubeconfig_version }}.gpg" \
    -F "comment=upload kubeconfig" \
    "https://www.fondsfinanz.de/confluence/rest/api/content/87894421/child/attachment/"
  register: curl_result
  ignore_errors: no
```
