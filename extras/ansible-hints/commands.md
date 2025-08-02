# Test inventory 
ansible ubuntu -i inventory.ini -m ping

# Test playbook
ansible-playbook -i inventory.ini playbook.yml

# Echo test
ansible all -i inventory.ini -m shell -a 'echo "Test connection to $(hostname)"'

