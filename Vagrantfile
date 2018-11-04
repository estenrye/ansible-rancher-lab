# frozen_string_literal: true
vagrant_api_version = '2'

hyperv_network = 'Default Switch'

machines = {
  acs: {
    box: 'generic/ubuntu1604',
    cpus: 2,
    mem: 2048,
    vmname: 'ansible-control-server',
    network: 'Default Switch',
    hv_mac: '00:35:10:00:00:01',
    script_path: 'scripts/provision_acs.sh',
  },
  router: {
    box: 'generic/ubuntu1804',
    cpus: 1,
    mem: 1024,
    vmname: 'router',
    network: 'Default Switch',
    script_path: 'scripts/provision_target.sh',
  },
  acsInternal: {
    box: 'generic/ubuntu1604',
    cpus: 2,
    mem: 2048,
    vmname: 'acs.rz.lab',
    network: 'Private',
    hv_mac: '00:35:10:00:01:00',
    script_path: 'scripts/provision_acs.sh',
  },
  utilityServer: {
    box: 'generic/ubuntu1604',
    cpus: 2,
    mem: 2048,
    vmname: 'utility.rz.lab',
    network: 'Private',
    hv_mac: '00:35:10:00:01:01',
    script_path: 'scripts/provision_target.sh',
  },
}

Vagrant.configure(vagrant_api_version) do |config|
  machines.each do |hostname, info|
    config.vm.define hostname do |machine|
      machine.vm.box = info[:box]
      machine.vm.hostname = hostname
      machine.vm.network 'public_network', bridge: info[:network]
      machine.vm.provision 'shell', privileged: true, path: info[:script_path]
      machine.vm.provider 'hyperv' do |hv|
        hv.vmname = info[:vmname]
        hv.memory = info[:mem]
        hv.cpus = info[:cpus]
        hv.mac = info[:hv_mac] if info[:hv_mac]
      end
    end
  end
end
