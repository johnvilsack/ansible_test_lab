adduser your_user
usermod -aG sudo your_user

# Create the .ssh directory for your new user
mkdir -p /home/your_user/.ssh

# Copy the SSH key you used for the root user
cp /root/.ssh/authorized_keys /home/your_user/.ssh/authorized_keys

# Set the correct ownership and permissions
chown -R your_user:your_user /home/your_user/.ssh
chmod 700 /home/your_user/.ssh
chmod 600 /home/your_user/.ssh/authorized_keys

exit

ssh your_user@your_server_ip


ansible-playbook playbook.yml
