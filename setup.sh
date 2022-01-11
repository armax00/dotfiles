#!/usr/bin/env bash

main () {
  ln -s ${REPO_PATH}/.gitconfig ${HOME}/.gitconfig
}

if [[ -n $BASH_SOURCE ]]
then
  SCRIPT_PATH=$(realpath $BASH_SOURCE)
  REPO_PATH=$(dirname $SCRIPT_PATH)

  main "$@"
fi
