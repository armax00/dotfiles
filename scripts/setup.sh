#!/bin/bash
set -e
set -o xtrace
#
# TODO(armax00): fix up a script to auto-setup the environment.

REPOSITORY_NAME="dotfiles"
DOTFILES_PATH=

if [ $(echo -n "${PWD}" | grep -c "${REPOSITORY_NAME}") -eq 1 ]; then
  DOTFILES_PATH=$(echo -n "${PWD}" | sed -e 's/\(.*\/dotfiles\).*/\1/g')
else
  echo "Unable to determine the location of repository: '${REPOSITORY_NAME}'"
  exit 1
fi

if [ -d ~/.config/awesome ]; then
  mv ~/.config/awesome ~/.config/awesome."$(date "+%Y%m%d%H%M%S")".bk
fi
mkdir -p ~/.config/awesome

git clone https://github.com/deficient/battery-widget.git \
    ~/.config/awesome/battery-widget
cp "${DOTFILES_PATH}/configs/awesome/rc.lua" ~/.config/awesome/
