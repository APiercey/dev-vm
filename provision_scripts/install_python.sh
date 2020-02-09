#!/bin/bash
source $HOME/.asdf/asdf.sh

PY_2_LANG_VERSION=2.7.17
PY_3_LANG_VERSION=3.7.4

if ! asdf plugin list | grep -q 'python'; then
  asdf plugin-add python
fi

if ! asdf where python $PY_3_LANG_VERSION | grep -q "$PY_3_LANG_VERSION"; then
  asdf install python $PY_3_LANG_VERSION
fi

if ! asdf where python $PY_2_LANG_VERSION | grep -q "$PY_2_LANG_VERSION"; then
  asdf install python $PY_2_LANG_VERSION
fi

asdf global python $PY_2_LANG_VERSION  $PY_3_LANG_VERSION


