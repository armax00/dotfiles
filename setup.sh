#!/usr/bin/env bash
set -e

main () {
  # Git Configurations.
  if [[ ! -h ${HOME}/.gitconfig ]]
  then
    rm -r ${HOME}/.gitconfig
    ln -s ${REPO_PATH}/.gitconfig ${HOME}/.gitconfig
    # If the local file does not exist, it will be created.
    # It will be poplulated separately with the more
    # sensitive content.
    touch ${HOME}/.gitconfig.local
  fi

  # Alacritty Configurations.
  if [[ ! -h ${HOME}/.config/alacritty ]]
  then
    rm -r ${HOME}/.config/alacritty
    ln -s ${REPO_PATH}/alacritty ${HOME}/.config/alacritty
  fi
}

if [[ -n $BASH_SOURCE ]]
then
  SCRIPT_PATH=$(realpath $BASH_SOURCE)
  REPO_PATH=$(dirname $SCRIPT_PATH)

  main "$@"
fi
