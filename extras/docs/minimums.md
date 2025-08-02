# ansible.cfg
```
[defaults]
inventory = ./inventory.yml
host_key_checking = false
retry_files_enabled = false
stdout_callback = yaml
timeout = 10
deprecation_warnings = false
```

# inventory.ini/yml

```
all:
  children:
    ubuntu-root:
      hosts:
        root-host:
          ansible_user: root
          ansible_connection: ssh
    ubuntu-user:
      hosts:
        user-host:
          ansible_user: johnv
          ansible_connection: ssh
  vars:
    ansible_host: 127.0.0.1
    ansible_port: 2222
    ansible_ssh_private_key_file: ~/.ssh/DIGITALOCEAN_SSH_KEY
    ansible_python_interpreter: /usr/bin/python3
```
# group_vars: ubuntu_user.yml
```
new_user_name: johnv
ssh_key_path: ~/.ssh/id_rsa.pub
```
# playbook.yml
```
- name: Bootstrap server as root
  hosts: ubuntu-root
  gather_facts: no
  tasks:
    - name: Create non-root user
      user:
        name: "{{ new_user_name }}"
        groups: sudo
        create_home: yes
        shell: /bin/bash

    - name: Set up SSH key
      authorized_key:
        user: "{{ new_user_name }}"
        key: "{{ lookup('file', ssh_key_path) }}"

- name: Configure as user
  hosts: ubuntu-user
  become: yes
  roles:
    - docker
    - hardening
    - apps
```

# roles/
```
roles/
├── docker/
│   └── tasks/
│       └── main.yml
├── hardening/
│   └── tasks/
│       └── main.yml
└── apps/
    └── tasks/
        └── main.yml
```

# templates/
```
templates/
  nginx.conf.j2
```

# files/
```
files/
  motd.txt
```

# Testing
```
ansible-playbook playbook.yml --check --diff  # dry-run
ansible-playbook playbook.yml --step          # step-through
ansible-playbook playbook.yml --start-at-task="XYZ"
```


