# -*- mode: ruby -*-
# vim: filetype=ruby tabstop=2 shiftwidth=2
#

Vagrant.configure("2") do |config|
  begin
    cores = Integer(`if [ \`uname\` = 'Darwin' ]; then sysctl -n hw.ncpu; else nproc; fi`)
  rescue Exception
      raise Vagrant::Errors::VagrantError.new,
        "#{__FILE__}:#{__LINE__}: Unable to detect number of cores on host machine."
  end

  config.vm.provider "virtualbox" do |vm, override|
    override.vm.box = "bento/ubuntu-16.04"
    vm.cpus = cores

    # Fix time sync issue after laptop sleep
    vm.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", "1000"]

    # Speed up disk by using less reliable writes
    vm.customize ["storagectl", :id, "--name", "SATA Controller", "--hostiocache", "on"]

    # Use VirtIO network card as more reliable one than the default e1000 with full emulation
    vm.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/bootstrap.yaml"
    #ansible.raw_arguments = ["--check"]
    #ansible.raw_arguments = ["-vvv"]
  end

  config.ssh.forward_agent = true
end
