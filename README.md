You can quickly create development environment for your project by adding the
following files to the project root:
```
├── Vagrantfile
└── provisioning
    ├── roles
    │   └── vagrant
    └── site.yaml
```

Where:
* ``provisioning/roles/vagrant`` is this repository
* ``provisioning/roles/site.yaml`` is:
```yaml
- hosts: all
  roles:
  - vagrant
```
* ``Vagrantfile`` is a symlink to ``provisioning/roles/vagrant/Vagrantfile`` or
  something like this:
```ruby
# -*- mode: ruby -*-
# vim: filetype=ruby tabstop=2 shiftwidth=2

load "provisioning/roles/vagrant/Vagrantfile"

Vagrant.configure("2") do |config|
  config.vm.hostname = "my-lovely-project"
end
```

If ``$VAGRANT_USER_PREP_SCRIPT`` environment variable is set, the script which
it points to will be executed on VM at the end of the provisioning process.

The development environment is created by 
```sh
$ vagrant up
```

Connect to the VM:
```sh
$ vagrant ssh
```

But it's better to add the following alias to your ``~/.bashrc`` which takes care of your sessions and SSH Agent forwarding issues:
```sh
alias vagrant-ssh='vagrant ssh -- -t ". ~/.bashrc.d/vagrant-user.sh; tmux has-session 2>/dev/null || { unset SSH_AUTH_SOCK && tmux new-session -d; } && exec tmux attach-session"'

```
and use it instead of ``vargrant ssh``.

If you create the development environment for Python projects, consider to add https://github.com/KonishchevDmitry/ansible-devel-virtualenv to your Ansible roles and use the following alias instead of ``vagrant-ssh``:
```sh
alias vagrant-ssh-virtualenv='vagrant ssh -- -t ". ~/.bashrc.d/vagrant-user.sh; tmux has-session 2>/dev/null || { unset SSH_AUTH_SOCK && tmux new-session -d && tmux send-keys \"workon vagrant\" Enter; } && exec tmux attach-session"'
```
