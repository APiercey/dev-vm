#!/bin/bash

if command -v bat > /dev/null 2>&1; then return 0; fi

# Install Bat
curl -O -J -L https://github.com/sharkdp/bat/releases/download/v0.10.0/bat-musl_0.10.0_amd64.deb
sudo dpkg -i bat-musl_0.10.0_amd64.deb
rm bat-musl_0.10.0_amd64.deb

