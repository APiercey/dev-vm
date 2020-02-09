#!/bin/bash
source $HOME/.asdf/asdf.sh

LANG_VERSION=1.9.1

if ! asdf plugin list | grep -q 'elixir'; then
  asdf plugin-add elixir
fi

if ! asdf where elixir $LANG_VERSION | grep -q "$LANG_VERSION"; then
  asdf install elixir $LANG_VERSION
fi

asdf global elixir $LANG_VERSION




