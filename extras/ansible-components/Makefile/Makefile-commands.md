make bootstrap → runs playbook as root on ubuntu-root

make deploy → runs playbook as johnv on ubuntu-user

make ping → pings all hosts

make debug → same playbook with verbose logging

make clean → deletes retry files

#Optional to Makefile:
export ANSIBLE_CONFIG = $(PWD)/ansible.cfg

# Or with dotenv or direnv
ANSIBLE_INVENTORY=localhost.ini
ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/DIGITALOCEAN_SSH_KEY

