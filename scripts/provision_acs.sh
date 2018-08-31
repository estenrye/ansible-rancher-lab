#!/bin/bash
apt-get update -y
apt-get install software-properties-common git -y
apt-add-repository ppa:ansible/ansible -y
apt-get update -y
apt-get install ansible sshpass -y

git clone https://github.com/estenrye/ansible-rancher-lab.git
chown -R vagrant ansible-rancher-lab
chgrp -R vagrant ansible-rancher-lab