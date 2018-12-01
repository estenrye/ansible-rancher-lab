#!/bin/sh
set -e

test -z ${sssd_from_sources} && echo "Missing environment variable: sssd_from_sources" && exit 1
(test "${sssd_from_sources}" = "True" && test -z ${sssd_version}) && echo "Missing environment variable: sssd_version" && exit 1

printf "[defaults]\nroles_path=/etc/ansible/roles\n" > /ansible/ansible.cfg

if [ ! -f /etc/ansible/lint.zip ]; then
  wget https://github.com/ansible/galaxy-lint-rules/archive/master.zip -O \
  /etc/ansible/lint.zip
  unzip /etc/ansible/lint.zip -d /etc/ansible/lint
fi

ansible-lint -c /etc/ansible/roles/${ansible_role}/.ansible-lint -r \
  /etc/ansible/lint/galaxy-lint-rules-master/rules \
  /etc/ansible/roles/${ansible_role}
ansible-lint -c /etc/ansible/roles/${ansible_role}/.ansible-lint -r \
  /etc/ansible/lint/galaxy-lint-rules-master/rules \
  /ansible/test.yml

ansible-playbook /ansible/test.yml \
  -i /ansible/inventory \
  --syntax-check \
  -e "{ sssd_from_sources: ${sssd_from_sources} }" \
  -e "{ sssd_version: ${sssd_version} }"

ansible-playbook /ansible/test.yml \
  -i /ansible/inventory \
  --connection=local \
  --become \
  -e "{ sssd_from_sources: ${sssd_from_sources} }" \
  -e "{ sssd_version: ${sssd_version} }" \
  $(test -z ${travis} && echo "-vvvv")

ansible-playbook /ansible/test.yml \
  -i /ansible/inventory \
  --connection=local \
  --become \
  -e "{ sssd_from_sources: ${sssd_from_sources} }" \
  -e "{ sssd_version: ${sssd_version} }" | \
  grep -q "changed=0.*failed=0" && \
  (echo "Idempotence test: pass" && exit 0) || \
  (echo "Idempotence test: fail" && exit 1)

if [ "True" = "${sssd_from_sources}" ] ; then
  real_sssd_version=$(sssd --version 2>&1)
  test "${real_sssd_version}" = "${sssd_version}" && \
    (echo "SSSD version test: pass" && exit 0) || \
    (echo "SSSD version test: fail" && exit 1)
fi
