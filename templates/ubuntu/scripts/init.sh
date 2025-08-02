#!/bin/bash
apt-get update
apt-get install -y openssh-server sudo python3
mkdir -p /root/.ssh && chmod 700 /root/.ssh
mkdir -p /var/run/sshd
echo 'root:root' | chpasswd
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
echo "export VISIBLE=now" >> /etc/profile
