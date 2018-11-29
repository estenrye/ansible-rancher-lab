# frozen_string_literal: true
vagrant_api_version = '2'

machines = {
  openvas: {
    box: 'generic/ubuntu1804',
    cpus: 2,
    mem: 2048,
    vmname: 'open-vas',
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
  acs: {
    box: 'generic/ubuntu1804',
    cpus: 1,
    mem: 2048,
    vmname: 'acs.rz.lab',
    network: 'Private',
    hv_mac: '00:35:10:00:01:00',
    script_path: 'scripts/provision_acs.sh',
  },
  utility: {
    box: 'generic/ubuntu1804',
    cpus: 2,
    mem: 2048,
    vmname: 'utility.rz.lab',
    network: 'Private',
    hv_mac: '00:35:10:00:01:01',
    script_path: 'scripts/provision_target.sh',
  },
  dc: {
    box: 'generic/ubuntu1804',
    cpus: 1,
    mem: 2048,
    vmname: 'dc.rz.lab',
    network: 'Private',
    hv_mac: '00:35:10:00:01:02',
    script_path: 'scripts/provision_target.sh',
  },
}

Vagrant.configure(vagrant_api_version) do |config|
  config.trigger.before :up do |t|
    t.info = 'Initializing environment'
    unless File.exist? 'scripts/id_rsa'
      `%x(ssh-keygen -f scripts/id_rsa -t rsa -b 4096)`
    end
  end

  machines.each do |hostname, info|
    config.vm.define hostname do |machine|
      machine.vm.box = info[:box]
      machine.vm.hostname = hostname
      machine.vm.network 'public_network', bridge: info[:network]
      machine.vm.provision 'file', source: 'group_vars', destination: '/home/vagrant/group_vars' if (hostname.to_s.eql? 'openvas') || (hostname.to_s.eql? 'acs')
      machine.vm.provision 'file', source: 'host_vars', destination: '/home/vagrant/host_vars' if (hostname.to_s.eql? 'openvas') || (hostname.to_s.eql? 'acs')
      machine.vm.provision 'file', source: 'roles', destination: '/home/vagrant/roles' if (hostname.to_s.eql? 'openvas') || (hostname.to_s.eql? 'acs')
      machine.vm.provision 'file', source: 'playbooks', destination: '/home/vagrant/playbooks' if (hostname.to_s.eql? 'openvas') || (hostname.to_s.eql? 'acs')
      machine.vm.provision 'file', source: 'rz_lab_inventory', destination: '/home/vagrant/rz_lab_inventory' if (hostname.to_s.eql? 'acs')
      machine.vm.provision 'file', source: 'ansible.cfg', destination: '/home/vagrant/ansible.cfg' if (hostname.to_s.eql? 'openvas') || (hostname.to_s.eql? 'acs')
      machine.vm.provision 'file', source: 'scripts/id_rsa', destination: '/home/vagrant/.ssh/id_rsa' if (hostname.to_s.eql? 'openvas') || (hostname.to_s.eql? 'acs')
      machine.vm.provision 'file', source: 'scripts/id_rsa.pub', destination: '/home/vagrant/.ssh/id_rsa.pub' if (hostname.to_s.eql? 'openvas') || (hostname.to_s.eql? 'acs')
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
