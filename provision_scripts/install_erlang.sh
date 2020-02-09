#!/bin/bash
source $HOME/.asdf/asdf.sh

LANG_VERSION=22.0.7

if ! asdf plugin list | grep -q 'erlang'; then
  asdf plugin-add erlang
fi

if ! asdf where erlang $LANG_VERSION | grep -q "$LANG_VERSION"; then
  asdf install erlang $LANG_VERSION
fi

asdf global erlang $LANG_VERSION



