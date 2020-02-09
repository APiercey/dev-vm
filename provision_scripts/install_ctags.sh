#!/bin/bash

if command -v ctags > /dev/null 2>&1; then return 0; fi

# Setup Ctags
git clone https://github.com/universal-ctags/ctags.git ~/ctags
cd ctags
./autogen.sh
./configure
make
sudo make install
