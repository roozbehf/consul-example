# Creates a Consul example setup on Linode

DATACENTER = 'newark'

MACHINES = {
  'consul-01' => '1024'
}

Vagrant.configure(2) do |config|

  # SSH configuration
  config.ssh.username = 'devops'
  config.ssh.private_key_path = "~/.ssh/linode_rsa"

  # Global Configuration
  config.vm.provider :linode do |provider, override|
    override.vm.box = 'linode'
    override.vm.box_url = "https://github.com/displague/vagrant-linode/raw/master/box/linode.box"

    provider.token = ENV['linode_api_key']
    provider.distribution = 'Ubuntu 14.04 LTS'
    provider.datacenter = DATACENTER
    provider.private_networking = true
  end

  # Synced Folders
  config.vm.synced_folder '.', '/vagrant', disabled: true

  MACHINES.each do |hostname, plan|
    config.vm.define hostname do |a|
      a.vm.hostname = hostname
      a.vm.provider :linode do |provider, override|
        provider.label = hostname
        provider.plan = plan
      end
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.sudo = true
    ansible.groups = {
      "consul-server" => ["consul-01"]
    }
  end

end
