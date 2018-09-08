#!/bin/bash
apt-get update -y
apt-get install software-properties-common git -y
apt-add-repository ppa:ansible/ansible -y
apt-get update -y
apt-get install ansible sshpass -y

git clone https://github.com/estenrye/ansible-rancher-lab.git 

ssh-keygen -f /home/vagrant/.ssh/id_rsa -t rsa -N '' -b 4096
chown vagrant /home/vagrant/.ssh/id_rsa*
chgrp vagrant /home/vagrant/.ssh/id_rsa*
mkdir -p /home/vagrant/ansible-rancher-lab/test/roles/rz.ssh_keys/files
cp /home/vagrant/.ssh/id_rsa.pub /home/vagrant/ansible-rancher-lab/test/roles/rz.ssh_keys/files/id_rsa.pub
chown -R vagrant ansible-rancher-lab
chgrp -R vagrant ansible-rancher-lab
