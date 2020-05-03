#!/bin/bash

if command -v watchman > /dev/null 2>&1; then return 0; fi

git clone https://github.com/facebook/watchman.git
cd watchman/
git checkout v4.9.0

sudo apt-get install -y autoconf automake build-essential

./autogen.sh 
./configure 
make
sudo make install
