# Iterating through Playbook
## Stepping
`ansible-playbook playbook.yml --step`

## Resume at specific task
`ansible-playbook playbook.yml --start-at-task="Some task name"`

## skip-step
`when: skip_step is not defined or not skip_step`
then run:
`ansible-playbook playbook.yml -e skip_step=true`

## Check Mode
```
- name: Simulate package install
  apt:
    name: nginx
    state: present
  check_mode: yes
```
`ansible-playbook playbook.yml --check` - Not supported by all modules

## Use debug, register, pause liberally
```
- name: Inspect file
  stat:
    path: /etc/passwd
  register: passwd_stat

- debug:
    var: passwd_stat

- pause:
    prompt: "Continue?"
```

# Variables
- Variables can come from the commandline:

`ansible-playbook bootstrap.yml -e new_user_name=johnv`

- A vars section of the playbook:
```
vars:
  new_user_name: johnv
```

- In group_vars/INVENTORYNAME.yml:

`new_user_name: johnv`

## In Play
- Variables are scoped per play, not per task or block
- Vars are available in:
 - when: conditions
 - templates
 - set_fact
 - debug

## Where are Jinja variables usable?
| Location                       | Supported? | Notes                               |
| ------------------------------ | ---------- | ----------------------------------- |
| `vars`, `defaults`, `set_fact` | ✅ Yes      | Full Jinja2 expressions             |
| `when:` conditions             | ✅ Yes      | Boolean expressions                 |
| `msg`, `command`, `args`       | ✅ Yes      | Inline interpolation                |
| `templates/` files (`.j2`)     | ✅ Yes      | Full templating for file generation |
| `inventory.yml`                | ⚠️ Limited  | Can’t use `lookup`, only vars       |
| `inventory.ini`                | ❌ No       | Static only                         |
| `ansible.cfg`                  | ❌ No       | INI only                            |
| `group_vars/`, `host_vars/`    | ✅ Yes      | Full Jinja supported                |
| File paths, loop items         | ✅ Yes      | Dynamically resolved                |

# Parallel Executions
- sync + poll
- fire_and_forget handlers
- strategy: free

# Verifying Actions
- changed_when: to define what counts as a change.
- failed_when: to set custom failure conditions.
- register: to capture output, and debug: to inspect it.

```
- name: Add user
  user:
    name: "{{ new_user_name }}"
  register: result

- name: Show result
  debug:
    var: result
```

# Failures
 - If a task fails on any host, that host is removed from the play, and Ansible continues on others.
 - Overrides:
      ignore_errors: true
      rescue: (with block)
      any_errors_fatal: true (fail the entire play if any host fails)

# Prompting
- You can prompt before tasks

```
  - name: Wait for confirmation
    pause:
      prompt: "Continue with the next step? (ctrl+c to abort)"
```

# Terminating
- meta: end_play to stop the play entirely.
- meta: end_host to stop processing a specific host.

```
- name: Bail out if user already exists
    when: user_exists
    meta: end_play
```

Or dynamically

```
- name: Exit early if something is missing
    when: result.failed
    meta: end_play
```
# Logging

```ini
[defaults]
stdout_callback = yaml
log_path = ./ansible.log
```

```
ansible-playbook playbook.yml | tee my-ansible-run.log
```

# Branching
- Pause, prompt, and register the output.
- set_fact

```
- name: Ask a branching question
  pause:
    prompt: "Do you want to install Docker? (yes/no)"
  register: docker_prompt

- name: Set variable based on answer
  set_fact:
    install_docker: "{{ docker_prompt.user_input == 'yes' }}"
```
- Then run later

```
- name: Install Docker
  when: install_docker
  include_role:
    name: docker
```
# Debugging
```
- name: Show result variable output
  debug:
    var: result
```

```
  msg: "This is a message"
```
## Using Multiples

### Multiple Messages

```
- name: Show multiple messages
  debug:
    msg:
      - "User: {{ new_user_name }}"
      - "Home dir: {{ home_dir }}"
      - "Shell: {{ shell }}"
```
### Output as Key-Value Dict
```
- name: Debug object
  debug:
    var: my_var
```

### Output inline
```
- name: Show many values
  debug:
    msg: |
      User: {{ new_user_name }}
      UID: {{ user_id }}
      Shell: {{ shell }}
```


# Conditionals

```
when: nginx_status.rc != 0
```
In Jinja:

```
{% if nginx_status.rc == 0 %}
Nginx is already installed.
{% else %}
Nginx will be installed.
{% endif %}
```
## When conditionals use Jinja:

```
when: my_var is defined
when: my_var is not defined
when: my_var == "value"
when: item in ['a', 'b', 'c']
when: result.rc != 0
when: result.failed
when: some_dict.key == "val"
when: ansible_facts['os_family'] == "Debian"
```
## Conditionals in When
```
- name: Ping host
  command: ping -c1 127.0.0.1
  register: ping_result
  ignore_errors: true

- name: Only run if ping failed
  debug:
    msg: "Ping failed"
  when: ping_result.rc != 0
```

## with loops
```
with_items:
  - nginx
  - curl
when: item != "curl"
```

# Blocking (try/catch)
```
tasks:
  - block:
      - name: Try something risky
        command: /bin/false

    rescue:
      - name: Handle the failure
        debug:
          msg: "Command failed, running rescue block"

    always:
      - name: Run no matter what
        debug:
          msg: "This runs whether or not it failed"
```
- If the task in block: succeeds → skip rescue:
- If it fails → run rescue:
- always: runs regardless of success/failure
- Useful for fallback, cleanup, or conditionals

# Repl-ish Ansible
`ansible-console -i inventory.ini`

```
> all -m setup
> servers -m command -a "whoami"
```

```> <target_group_or_host> -m <module> -a "<arguments>"```

Run ping on everything:
```all -m ping```

Run a shell command to group:
```> ubuntu-root -m shell -a "whoami"```

Run shell command to specific host:
```> user-host -m debug -a "msg='hello'"```

# Common Modules for Testing
```
ping
command
shell
debug
setup
```
# Common Console Commands
list
cd <group>
var
hostvars
quit

# Loop Example - Install multiple packages
```
- name: Install multiple packages
  apt:
    name: "{{ item }}"
    state: present
  with_items:
    - nginx
    - curl
    - git
```
# Loop Example - Using multiple vars
```
- name: Create users
  user:
    name: "{{ item.name }}"
    shell: "{{ item.shell }}"
  loop:
    - { name: "alice", shell: "/bin/bash" }
    - { name: "bob", shell: "/bin/zsh" }
```
# Variables
Grab all variables
```
- name: Debug Template Loading
  debug:
    var: template_defaults
```
# Blocks
```
  block:
    - set_fact:
        ssh_port: "{{ port | default(template_defaults.default_port | default('2222')) }}"
    - debug:
        msg: "SSH Port: {{ ssh_port }}"
```
```Common Block
- name: Do multiple related things
  block:
    - name: First task
      command: echo "hello"
    - name: Second task  
      command: echo "world"
```

Assign common variables
```
- name: Database setup
  block:
    - name: Create user
      mysql_user: name={{ db_user }}
    - name: Create database  
      mysql_db: name={{ db_name }}
  vars:
    db_user: myapp
    db_name: myapp_db
```
Delegate to common tasks
```
- name: Remote server tasks
  block:
    - command: systemctl restart nginx
    - command: systemctl status nginx
  delegate_to: webserver.example.com
```
Conditions to multiple tasks
```
- name: Windows-only tasks
  block:
    - name: Install IIS
      win_feature: name=IIS
    - name: Start IIS
      win_service: name=W3SVC state=started
  when: ansible_os_family == "Windows"
```
Error Handling
```
- name: Try to do something
  block:
    - name: Risky operation
      command: /might/fail
  rescue:
    - name: Run if block fails
      debug:
        msg: "Something went wrong!"
  always:
    - name: Always runs (cleanup)
      debug:
        msg: "Cleaning up..."
```
