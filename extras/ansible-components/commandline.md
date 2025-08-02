# Standard command
ansible-playbook -i inventory.ini playbook.yml

# Without -i, Ansible defaults to /etc/ansible/hosts or ~/.ansible/hosts
# hosts file is same as an inventory file

# Test inventory 
ansible ubuntu -i inventory.ini -m ping

# Test playbook
ansible-playbook -i inventory.ini playbook.yml

# Echo test
ansible all -i inventory.ini -m shell -a 'echo "Test connection to $(hostname)"'

# Include variables
ansible-playbook bootstrap.yml -e new_user_name=johnv

# Indirect logging of playbook
ansible-playbook playbook.yml | tee my-ansible-run.log

- Also check notes for ini setting

 
