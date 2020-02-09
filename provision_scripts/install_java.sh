#!/bin/bash
source $HOME/.asdf/asdf.sh

LANG_VERSION=adopt-openjdk-9+181

if ! asdf plugin list | grep -q 'java'; then
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
fi

if ! asdf where java $LANG_VERSION | grep -q "$LANG_VERSION"; then
  asdf install java $LANG_VERSION
fi

asdf global java $LANG_VERSION

