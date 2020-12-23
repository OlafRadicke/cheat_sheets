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

Disable finger print check
--------------------------

```bash
export ANSIBLE_HOST_KEY_CHECKING=False && \
ansible-playbook ./site.yml
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

Uses a specific YAML file as an inventory source
------------------------------------------------

Example:

```yaml
all: # keys must be unique, i.e. only one 'hosts' per group
    hosts:
        test1:
        test2:
            host_var: value
    vars:
        group_all_var: value
    children:   # key order does not matter, indentation does
        other_group:
            children:
                group_x:
                    hosts:
                        test5   # Note that one machine will work without a colon
                #group_x:
                #    hosts:
                #        test5  # But this won't
                #        test7  #
                group_y:
                    hosts:
                        test6:  # So always use a colon
            vars:
                g2_var2: value3
            hosts:
                test4:
                    ansible_host: 127.0.0.1
        last_group:
            hosts:
                test1 # same host as above, additional group membership
            vars:
                group_last_var: value

```

Loop over an block
------------------


```yaml
# playbook.yml
---
- hosts: localhost
  connection: local
  vars:
    ip_addresses:
      - 10.0.0.10
      - 10.0.0.11
  tasks:
    - name: deploy files with network address in them
      include_tasks: network_files.yml
      loop: "{{ ip_addresses }}"
```

```yaml
# network_files.yml
---
- name: Copy using inline content to first file
  copy:
    content: |
      ip_address={{ item }}
    dest: /etc/some_config_file.conf

- name: Copy using inline content to second file
  copy:
    content: |
      ip_address={{ item }}
    dest: /etc/some_other_config_file.conf
```


Catch errors and return debug info
----------------------------------

```yaml
- name:           Get date
  shell:          date
  ignore_errors:  yes
  register:       shell_result

- block:
  - name:          DEBUG Output return value
    fail:
      msg:         "{{ shell_result }}"
    when:          shell_result.rc != 0
  when:            shell_result.rc is defined
```

or

```yaml
- block:
  - name:       View the content of private key
    shell:      cat /ml/hello_world.txt
    register:   shell_result

  rescue:

  - name:       Output return value
    debug:
      msg:      "{{ shell_result }}"
```

Other ansible tools:
--------------------

* [Ansible Bender (ansible in container)](https://github.com/ansible-community/ansible-bender)