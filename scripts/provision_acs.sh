#!/bin/bash
apt-get update -y
apt-get install software-properties-common git -y
apt-add-repository ppa:ansible/ansible -y
apt-get update -y
apt-get install ansible sshpass -y

chmod 600 /home/vagrant/.ssh/id_rsa

mkdir -p /home/vagrant/roles/rz.ssh_keys/files
mkdir -p /home/vagrant/roles/rz.rancher/files

cp /home/vagrant/.ssh/id_rsa.pub /home/vagrant/roles/rz.ssh_keys/files/id_rsa.pub
cp /home/vagrant/.ssh/id_rsa /home/vagrant/roles/rz.rancher/files/id_rsa