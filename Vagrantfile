Vagrant.configure("2") do |config|
  config.vm.box = "generic/rocky9"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus   = 2
  end

  # Sync dotfiles into the VM
  config.vm.synced_folder ".", "/home/vagrant/dot-files"

  # Install Nix and apply server config
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    cd ~/dot-files
    bash apply.sh --server
  SHELL
end
