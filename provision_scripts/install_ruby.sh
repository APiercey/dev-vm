#!/bin/bash
source $HOME/.asdf/asdf.sh

LANG_VERSION=2.6.5

if ! asdf plugin list | grep -q 'ruby'; then
  asdf plugin-add ruby
fi

if ! asdf where ruby $LANG_VERSION | grep -q "$LANG_VERSION"; then
  asdf install ruby $LANG_VERSION
fi

asdf global ruby $LANG_VERSION



