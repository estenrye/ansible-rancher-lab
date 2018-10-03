#!/bin/bash
apt-get update -y
apt-get install software-properties-common git -y
apt-add-repository ppa:ansible/ansible -y
apt-get update -y
apt-get install ansible sshpass -y

if [ ! -d ansible-rancher-lab ]; then
  git clone -c core.symlinks=true https://github.com/estenrye/ansible-rancher-lab.git
else
  cd ansible-rancher-lab
  git pull
  cd ..
fi

if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
  ssh-keygen -f /home/vagrant/.ssh/id_rsa -t rsa -N '' -b 4096
  chown vagrant /home/vagrant/.ssh/id_rsa*
  chgrp vagrant /home/vagrant/.ssh/id_rsa*
fi
mkdir -p /home/vagrant/ansible-rancher-lab/roles/rz.ssh_keys/files
cp /home/vagrant/.ssh/id_rsa.pub /home/vagrant/ansible-rancher-lab/roles/rz.ssh_keys/files/id_rsa.pub
mkdir -p /home/vagrant/ansible-rancher-lab/roles/rz.rancher/files
cp /home/vagrant/.ssh/id_rsa /home/vagrant/ansible-rancher-lab/roles/rz.rancher/files/id_rsa
chown -R vagrant ansible-rancher-lab
chgrp -R vagrant ansible-rancher-lab
