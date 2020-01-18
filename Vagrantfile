# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Box / OS
VAGRANT_BOX = 'bento/ubuntu-18.04'.freeze

# Memorable name for your
VM_NAME = 'dev-vm'.freeze

# VM User - 'vagrant' by default
VM_USER = 'vagrant'.freeze

# Username on your Mac
MAC_USER = `whoami`.strip

# Host folder to sync
HOST_PATH = "/Users/#{MAC_USER}".freeze

# Where to sync to on Guest - 'vagrant' is the default user name
GUEST_PATH = "/home/#{VM_USER}".freeze

Vagrant.configure(2) do |config|
  config.vm.box = VAGRANT_BOX
  config.vm.hostname = VM_NAME

  config.vm.provider 'virtualbox' do |v|
    v.name = VM_NAME
    v.memory = 4096
    v.cpus = 4

    v.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  end

  config.vm.network 'private_network', type: 'dhcp'

  config.vm.provision 'file', source: '.ssh', destination: '~/.ssh'
  config.vm.provision 'file', source: '~/.gitconfig', destination: '~/.gitconfig'
  config.vm.provision 'file', source: '~/.gitignore', destination: '~/.gitignore'
  config.vm.provision 'file', source: './.custom.zsh', destination: '~/.custom.zsh'

  config.vm.synced_folder "Projects", "#{GUEST_PATH}/Projects"
  config.vm.synced_folder "#{HOST_PATH}/vimwiki", "#{GUEST_PATH}/vimwiki"
  config.vm.synced_folder "#{HOST_PATH}/vimwiki_html", "#{GUEST_PATH}/vimwiki_html"
  config.vm.synced_folder "#{HOST_PATH}/scripts", "#{GUEST_PATH}/scripts"
  config.vm.synced_folder "#{HOST_PATH}/.config/tmuxinator", "#{GUEST_PATH}/.config/tmuxinator"

  # Sync dotfiles
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    git clone --recurse-submodules git@github.com:APiercey/vimfiles.git || ( cd ~/vimfiles ; git pull )
    ~/vimfiles/sync.sh

    git clone --recurse-submodules git@github.com:APiercey/dotfiles.git || ( cd ~/dotfiles ; git pull )
    ~/dotfiles/sync.sh

    # Update/install Prezto Framework
    cd ~/.zgen/sorin-ionescu/prezto-master
    git pull
    git submodule update --init --recursive
    cd ~/

    # Install FZF
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes n | ~/.fzf/install --completion --key-bindings --no-bash --no-fish # "yes n" disables whatever options that are not set
  SHELL

  # Ubuntu installation
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    sudo add-apt-repository ppa:neovim-ppa/unstable -y

    sudo apt-get install -y \
      zsh neovim ranger tmux wget curl jq direnv \
      automake autoconf libreadline-dev \
      libncurses-dev libssl-dev libyaml-dev \
      libxslt-dev libffi-dev libtool unixodbc-dev \
      bzip2 sqlite3 zip unzip
  SHELL

  # Non-ubuntu installations
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    # Add terminfos
    tic ~/dotfiles/terminfos/xterm-256color-italic.terminfo

    # Install vim-plug
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Install Bat
    curl -O -J -L https://github.com/sharkdp/bat/releases/download/v0.10.0/bat-musl_0.10.0_amd64.deb
    sudo dpkg -i bat-musl_0.10.0_amd64.deb
    rm bat-musl_0.10.0_amd64.deb

    curl -0 -J -L https://github.com/concourse/concourse/releases/download/v5.8.0/fly-5.8.0-linux-amd64.tgz


    # Install Ripgrep
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
    sudo dpkg -i ripgrep_11.0.2_amd64.deb
    rm ripgrep_11.0.2_amd64.deb

    # Set shell
    sudo chsh -s $(which zsh) #{VM_USER}
  SHELL

  config.vm.provision 'shell', privileged: true, path: './provision_script.sh'

  # Install ASDF
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    # Source, as this is running in bash
    source $HOME/.asdf/asdf.sh

    # Add plugins
    asdf plugin-add java https://github.com/halcyon/asdf-java.git
    asdf plugin-add python
    asdf plugin-add ruby
    asdf plugin-add elixir
    asdf plugin-add erlang
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

    # NodeJS is special...
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
    asdf install nodejs 13.5.0

    asdf install python 3.7.4
    asdf install python 2.7.17
    asdf install java adopt-openjdk-9+181
    asdf install ruby 2.6.5
    asdf install elixir 1.9.1
    asdf install erlang 22.0.7

    asdf global python 2.7.17 3.7.4
    asdf global java adopt-openjdk-9+181
    asdf global ruby 2.6.5
    asdf global elixir 1.9.1
    asdf global erlang 22.0.7
    asdf global nodejs 13.5.0
  SHELL

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

  # Install docker
  config.vm.provision 'shell', privileged: false, inline: <<-SHELL
    sudo groupadd docker

    sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

    sudo apt-get install docker-ce docker-ce-cli containerd.io
  SHELL

end
