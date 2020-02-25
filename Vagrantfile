# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Box / OS
VAGRANT_BOX = 'bento/ubuntu-18.04'

# Memorable name for your
VM_NAME = 'dev-vm'

# VM User - 'vagrant' by default
VM_USER = 'vagrant'

# Username on your Mac
MAC_USER = `whoami`.strip.freeze

# Host folder to sync
HOST_PATH = "/Users/#{MAC_USER}"

# Where to sync to on Guest - 'vagrant' is the default user name
GUEST_PATH = "/home/#{VM_USER}"

Vagrant.configure(2) do |config|
  config.vm.box = VAGRANT_BOX
  config.vm.hostname = VM_NAME

  config.vm.provider 'virtualbox' do |v|
    v.name = VM_NAME
    v.memory = 4096
    v.cpus = 3

    v.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end

  config.vm.network 'private_network', type: 'dhcp'
  config.vm.network :forwarded_port, guest: 80, host: 8080

  config.vm.provision 'file', source: 'vm_files/.ssh', destination: '~/.ssh'
  config.vm.provision 'file', source: 'vm_files/.gitconfig', destination: '~/.gitconfig'
  config.vm.provision 'file', source: 'vm_files/.gitignore', destination: '~/.gitignore'
  config.vm.provision 'file', source: 'vm_files/.custom.zsh', destination: '~/.custom.zsh'

  # Setup Folders
  config.vm.synced_folder 'vm_files/Projects', "#{GUEST_PATH}/Projects"
  config.vm.synced_folder 'vm_files/vimwiki', "#{GUEST_PATH}/vimwiki"
  config.vm.synced_folder 'vm_files/scripts', "#{GUEST_PATH}/scripts"
  config.vm.synced_folder 'vm_files/bin', "#{GUEST_PATH}/bin"
  config.vm.synced_folder 'vm_files/tmuxinator', "#{GUEST_PATH}/.config/tmuxinator"

  # Hack to open webpages
  config.vm.synced_folder 'urls', "#{GUEST_PATH}/urls" #, type: "nfs"

  # Set owner as non-root
  config.vm.provision 'shell', privileged: true, inline: "chown -R #{VM_USER}:#{VM_USER} /home/vagrant/.config"

  # Sync dotfiles
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_dotfiles.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_fzf.sh'

  # Ubuntu installation
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    sudo add-apt-repository ppa:neovim-ppa/unstable -y

    sudo apt-get install -y \
      zsh neovim ranger tmux wget curl jq direnv \
      automake autoconf libreadline-dev \
      libncurses-dev libssl-dev libyaml-dev \
      libxslt-dev libffi-dev libtool unixodbc-dev \
      bzip2 sqlite3 zip unzip libsqlite3-dev
  SHELL

  # Set Shell
  config.vm.provision 'shell', privileged: true, inline: "sudo chsh -s $(which zsh) #{VM_USER}"

  # Install Tools
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_ripgrep.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_vim_plug.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_bat.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_docker.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_docker_compose.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_ctags.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_script.sh'

  # Install languages
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_java.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_ruby.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_python.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_nodejs.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_erlang.sh'
  config.vm.provision 'shell', privileged: false, path: './provision_scripts/install_elixir.sh'

  # Plugins
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    source $HOME/.asdf/asdf.sh

    gem install bundler tmuxinator solargraph neovim

    pip install neovim
    pip3 install neovim

    npm install -g neovim
  SHELL

  # Setup nvim
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    nvim +'PlugInstall --sync' +'PlugUpdate' +qa
    nvim +'CocInstall' +qa
  SHELL
end
