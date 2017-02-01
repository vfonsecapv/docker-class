# -*- mode: ruby -*-
# vi: set ft=ruby :

# Rancher Workshop Demo
#

# Allows setting of hostname in rancheros box, some helpers for setting IP addr
require_relative 'vagrant_ros_guest_plugin.rb'

# Config variables
$number_of_nodes = 2
$private_ip_prefix = '172.30.0'
$expose_rancher_ui = 8080
$vb_gui = false
$vb_memory = 1024
$vb_cpus = 1
$rsync_folder_disabled = true

# Config for n-number of host nodes
def config_node(node, hostname, node_ip, server_ip)
  node.vm.box = "ubuntu/trusty64"
  node.vm.hostname = hostname
  node.vm.network 'private_network', ip: node_ip

  # Have vagrant install docker for convenience
  node.vm.provision "docker" do |d|
  end

end

Vagrant.configure("2") do |config|

  # Define VM specs
  config.vm.provider 'virtualbox' do |vb|
    vb.gui = $vb_gui
    vb.memory = $vb_memory
    vb.cpus = $vb_cpus
  end

  # Create our Rancher Server
  server_ip = "#{$private_ip_prefix}.100"
  config.vm.define "server" do |server|
    server.vm.box = 'rancherio/rancheros'
    server.vm.hostname = "rancher-server.box"
    server.vm.network :private_network, ip: "#{server_ip}"
    server.vm.network 'forwarded_port', guest: $expose_rancher_ui, host: $expose_rancher_ui, auto_correct: true
    server.vm.provision "docker" do |d|
      d.run "rancher/server:latest",
      args: "--name=rancher-server -l io.rancher.container.system=rancher-agent --restart=always -d -p 8080:8080"
    end
  end

  # Create host nodes
  (1..$number_of_nodes).each do |i|
    hostname_node = 'rancher-host-%02d' % i
    node_ip = "#{$private_ip_prefix}.#{100+i}"
    config.vm.define hostname_node do |node|
      config_node(node, hostname_node, node_ip, server_ip)
    end
  end

  # Disabling compression because OS X has an ancient version of rsync installed.
  # Add -z or remove rsync__args below if you have a newer version of rsync on your machine.
  config.vm.synced_folder '.', '/opt/rancher', type: 'rsync',
      rsync__exclude: '.git/', rsync__args: ['--verbose', '--archive', '--delete', '--copy-links'],
      disabled: $rsync_folder_disabled
end
