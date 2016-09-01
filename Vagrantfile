# -*- mode: ruby -*-
# vim: filetype=ruby tabstop=2 shiftwidth=2
#

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |vm|
    # Fix time sync issue after laptop sleep
    vm.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", "1000"]
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/bootstrap.yaml"
    #ansible.raw_arguments = ["--check"]
    #ansible.raw_arguments = ["-vvv"]
  end

  config.ssh.forward_agent = true
end
