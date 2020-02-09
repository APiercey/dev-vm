#!/bin/bash
source $HOME/.asdf/asdf.sh

LANG_VERSION=13.5.0

if ! asdf plugin list | grep -q 'nodejs'; then
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
fi

if ! asdf where nodejs $LANG_VERSION | grep -q "$LANG_VERSION"; then
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf install nodejs $LANG_VERSION
fi

asdf global nodejs $LANG_VERSION


