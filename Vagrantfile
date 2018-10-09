# frozen_string_literal: true
vagrant_api_version = '2'

hyperv_network = 'Default Switch'

machines = {
  router: {
    box: 'generic/ubuntu1604',
    cpus: 1,
    mem: 1024,
    vmname: 'router',
  },
}

Vagrant.configure(vagrant_api_version) do |config|
  config.vm.define 'acs' do |acs|
    acs.vm.box = 'generic/ubuntu1604'
    acs.vm.hostname = 'acs'
    acs.vm.network 'public_network', bridge: hyperv_network
    acs.vm.provider 'hyperv' do |hv|
      hv.vmname = 'ansible-control-server'
      hv.memory = 2048
      hv.cpus = 2
      hv.mac = '00:35:10:00:00:01'
    end
    acs.vm.provision 'shell', privileged: true, path: 'scripts/provision_acs.sh'
  end

  machines.each do |hostname, info|
    config.vm.define hostname do |machine|
      machine.vm.box = info[:box]
      machine.vm.hostname = hostname
      machine.vm.network 'public_network', bridge: hyperv_network
      machine.vm.provider 'hyperv' do |hv|
        hv.vmname = info[:vmname]
        hv.memory = info[:mem]
        hv.cpus = info[:cpus]
      end
      machine.vm.provision 'shell',
        inline: 'sudo apt-get update && apt-get install python2.7 -y'
    end
  end
end
