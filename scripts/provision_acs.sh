#!/bin/bash
apt-get update
apt-get install software-properties-common git sshpass
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible

git clone https://github.com/estenrye/ansible-rancher-lab.git
chown -R vagrant ansible-rancher-lab
chgrp -R vagrant ansible-rancher-lab