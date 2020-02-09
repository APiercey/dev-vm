#!/bin/bash
git clone --recurse-submodules git@github.com:APiercey/vimfiles.git || ( cd ~/vimfiles ; git pull )
~/vimfiles/sync.sh

git clone --recurse-submodules git@github.com:APiercey/dotfiles.git || ( cd ~/dotfiles ; git pull )
~/dotfiles/sync.sh

# Update/install Prezto Framework
cd ~/.zgen/sorin-ionescu/prezto-master
git pull
git submodule update --init --recursive
cd ~/

# Add terminfos
tic ~/dotfiles/terminfos/xterm-256color-italic.terminfo
