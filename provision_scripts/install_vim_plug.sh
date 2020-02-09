#!/bin/bash
VIM_PLUG_HOME=~/.local/share/nvim/site/autoload/plug.vim

if test -f "$VIM_PLUG_HOME"; then return 0; fi

curl -fLo $VIM_PLUG_HOME --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
