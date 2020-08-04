About Ansible
=============

* [Vault](vault.md)


Multiline debug output
----------------------

```yaml
- name: "run hugo"
  shell: "hugo --environment production "
  args:
    chdir: ../
  delegate_to: localhost
  register: hugo_result

- debug:
    msg: "{{ hugo_result.stdout.split('\n')[:-1] }}"
```


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

run an Ansible playbook locally
-------------------------------

Inventory:

```bash
[local_task]
localhost  ansible_connection=local
```

Task file:

```yaml
- name: Helm chart install # noqa 301 noqa 305
  delegate_to: localhost
  become: false
  shell: date
  register: return_value
  ignore_errors: yes

- debug:
    msg: "{{ return_value.stdout.split('\n') }}"
  when: not ansible_check_mode

- debug:
    msg: "{{ return_value.stderr.split('\n') }}"
  when: not ansible_check_mode
```

Debugging inventory
-------------------

```bash
ansible -i ./hosts all -m debug -a "var=hostvars[inventory_hostname]"
```

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
