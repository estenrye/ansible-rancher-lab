# frozen_string_literal: true
VAGRANTFILE_API_VERSION = '2'

HYPERV_NETWORK = 'Internet'

machines = {
  haproxy: {
    box: 'generic/ubuntu1604',
    cpus: 2,
    mem: 1024,
    vmname: 'haproxy-load-balancer',
    mac: '00:35:10:00:00:02',
  },
  rancher1: {
    box: 'generic/ubuntu1604',
    cpus: 2,
    mem: 2048,
    vmname: 'rancher-server-1',
    mac: '00:35:10:00:00:03',
  },
  rancher2: {
    box: 'generic/ubuntu1604',
    cpus: 2,
    mem: 2048,
    vmname: 'rancher-server-2',
    mac: '00:35:10:00:00:04',
  },
  rancher3: {
    box: 'generic/ubuntu1604',
    cpus: 2,
    mem: 2048,
    vmname: 'rancher-server-3',
    mac: '00:35:10:00:00:05',
  },
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define 'acs' do |acs|
    acs.vm.box = 'generic/ubuntu1604'
    acs.vm.hostname = 'acs'
    acs.vm.network 'public_network', bridge: HYPERV_NETWORK
    acs.vm.provider 'hyperv' do |hv|
      hv.vmname = 'ansible-control-server'
      hv.memory = 2048
      hv.cpus = 2
      hv.mac = '00:35:10:00:00:01'
    end
    acs.vm.provision 'shell',
      inline: 'sudo apt-get update && apt-get install ansible git sshpass -y && git clone https://github.com/estenrye/ansible-rancher-lab.git && chown -R vagrant ansible-rancher-lab && chgrp -R vagrant ansible-rancher-lab'
  end

  machines.each do |hostname, info|
    config.vm.define hostname do |machine|
      machine.vm.box = info[:box]
      machine.vm.hostname = hostname
      machine.vm.network 'public_network', bridge: HYPERV_NETWORK
      machine.vm.provider 'hyperv' do |hv|
        hv.vmname = info[:vmname]
        hv.memory = info[:mem]
        hv.cpus = info[:cpus]
        hv.mac = info[:mac]
      end
    end
  end
end
