# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.define "mb"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.hostname = "mb.local"
  config.vm.provision :shell, path: "vagrant-provision.sh", privileged: false
  config.ssh.forward_agent = true
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end
  
end

