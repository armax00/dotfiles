#!/usr/bin/env bash
set -xe

install_config () {
  local application_conf="$1"; shift
  local repo_path="$1"; shift
  local dst_path="$1"; shift

  if [[ ! -h "$dst_path/$application_conf" ]]
  then
    echo "Creating $dst_path/$application_conf"
    rm -fr "$dst_path/$application_conf"
    ln -s "$repo_path/$application_conf" \
        "$dst_path/$application_conf"
  fi
}

main () {
  local script_path=$(realpath $BASH_SOURCE)
  local repo_path=$(dirname $script_path)

  # Git Configurations.
  install_config ".gitconfig" "${repo_path}" "${HOME}"
  # If the local file does not exist, it will be created.
  # It will be poplulated separately with the more
  # sensitive content.
  touch ${HOME}/.gitconfig.local

  # Alacritty Configurations.
  install_config "alacritty" "${repo_path}" "${HOME}/.config"

  # WayBar Configurations.
  install_config "waybar" "${repo_path}" "${HOME}/.config"
}

if [[ -n $BASH_SOURCE ]]
then
  main "$@"
fi
