#!/bin/bash
command -v fzf >/dev/null 2>&1 || return

# Install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes n | ~/.fzf/install --completion --key-bindings # "yes n" disables whatever options that are not set
