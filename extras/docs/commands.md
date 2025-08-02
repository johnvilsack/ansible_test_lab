# Explore
| Module  | Purpose                  | Console Example                         |
| ------- | ------------------------ | --------------------------------------- |
| `ping`  | Validate SSH + Python    | `all -m ping`                           |
| `setup` | Gather facts             | `all -m setup`                          |
| `debug` | Output vars/messages     | `all -m debug -a "msg='hello world'"`   |
| `stat`  | Check if file/dir exists | `servers -m stat -a "path=/etc/passwd"` |

# Tasks
| Module       | Task                            | Console Example                                             |
| ------------ | ------------------------------- | ----------------------------------------------------------- |
| `command`    | Run command (no shell)          | `servers -m command -a "uptime"`                            |
| `shell`      | Run full shell command          | `servers -m shell -a "echo $HOME"`                          |
| `file`       | Manage file permissions         | `servers -m file -a "path=/tmp/foo mode=0644 state=touch"`  |
| `copy`       | Copy local file to remote       | `servers -m copy -a "src=./foo.txt dest=/tmp/foo.txt"`      |
| `fetch`      | Copy remote → local             | (playbook only; not in console easily)                      |
| `lineinfile` | Add line to a file (idempotent) | `servers -m lineinfile -a "path=/etc/motd line='Welcome!'"` |

# User Management
| Module           | Task         | Console Example                                                  |
| ---------------- | ------------ | ---------------------------------------------------------------- |
| `user`           | Create user  | `servers -m user -a "name=testuser state=present"`               |
| `group`          | Create group | `servers -m group -a "name=testgroup state=present"`             |
| `authorized_key` | Add SSH key  | `servers -m authorized_key -a "user=john key='ssh-rsa AAAA...'"` |

# Package Management
| Module    | OS      | Example                                                         |
| --------- | ------- | --------------------------------------------------------------- |
| `apt`     | Debian  | `servers -m apt -a "name=curl state=present update_cache=true"` |
| `yum`     | RHEL    | `servers -m yum -a "name=git state=present"`                    |
| `dnf`     | RHEL 8+ | Same as `yum` but newer systems                                 |
| `package` | Any     | OS-agnostic wrapper (autodetects pkg mgr)                       |

# Service Management
| Module    | Task          | Example                                                         |
| --------- | ------------- | --------------------------------------------------------------- |
| `service` | Start/stop    | `servers -m service -a "name=nginx state=started"`              |
| `systemd` | Systemd tasks | `servers -m systemd -a "name=sshd enabled=yes state=restarted"` |

# Privilege Escalation
| Module   | Task        | Example                                            |
| -------- | ----------- | -------------------------------------------------- |
| `become` | Run as root | Add `--become` to CLI or `become: yes` in playbook |

# Flow Control
| Task                             | Example                                   |
| -------------------------------- | ----------------------------------------- |
| `pause`                          | `pause: prompt="Press enter to continue"` |
| `fail`                           | `fail: msg="Unsupported OS"`              |
| `meta`                           | `meta: end_play` to stop a play early     |
| `include_tasks` / `import_tasks` | Dynamically load task files               |

# Other Handy Controls
| Module             | Purpose                      |
| ------------------ | ---------------------------- |
| `uri`              | Make HTTP requests           |
| `git`              | Clone or update a repo       |
| `unarchive`        | Extract tar/zip              |
| `template`         | Use Jinja2 templated files   |
| `assemble`         | Join multiple files into one |
| `wait_for`         | Wait for port/file/timeout   |
| `firewalld`, `ufw` | Manage firewalls             |

