# Order of Operations

# Pre-Ansible
1. Standup server
  a. Check Docker
  b. If running, check if ansible server exists

## ansible.cfg
### Load Order: 
  1. current_dir
  2. ANSIBLE_CONFIG envvar
  3. $HOME/ansible.cfg
  4. /etc/ansible/ansible.cfg

## inventory.ini or inventory.yml
### Loads
  1. Groups
  2. Hosts
  3. Vars

## /group_vars

## /host_vars

## Playbook
  1. Play
    A. Selects Host(s)
    B. Connects
    C. Switch to remote_user (become if needed)
    D. gather_facts: (unless false)
  2. Task
    A. when: clause
    B. Run Task
    C. Register vars, evaluate handlers
    D. On failure, run rescue: if defined
    E. Runs handlers (if notified)

## Optional

| File/Tool          | Purpose                            |
| ------------------ | ---------------------------------- |
| `.env`             | Custom variables for Make/direnv   |
| `Makefile`         | Easy targets like `make deploy`    |
| `requirements.yml` | Install roles via `ansible-galaxy` |
| `vault.yml`        | Encrypted secrets                  |


