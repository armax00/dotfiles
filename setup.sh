#!/usr/bin/env bash
set -e

install_config () {
  local application_conf="$1"; shift
  local repo_path="$1"; shift
  local dst_path="$1"; shift

  if [[ ! -h "${dst_path:?}/${application_conf:?}" ]]
  then
    echo "Creating ${dst_path:?}/${application_conf:?}"
    rm -fr "${dst_path:?}/${application_conf:?}"
    ln -s "${repo_path:?}/${application_conf:?}" \
        "${dst_path:?}/${application_conf:?}"
  fi
}

install_system_dependency () {
  local package="$1"; shift

  # TODO
}

install_nvim_dependency () {
  local package="$1"; shift
  local repository="$1"; shift

  local pack_dir="${HOME:?}/.local/share/nvim/site/pack"
  local packages_dir="${pack_dir:?}/packages"
  local 

  if [[ -d "$packages_dir/$package" ]]
  then
    echo "$package is already installed."
    return
  fi

  if [[ ! -d "$pack_dir" ]]
  then
    mkdir -p "$pack_dir"
  fi

  if [[ ! -d "$packages_dir" ]]
  then
    mkdir -p "$packages_dir"
    (
      cd "$packages_dir"
      git init
    )
  fi

  (
    cd "$packages_dir"
    git submodule add "$repository" "$package"
  )

  mkdir -p "$pack_dir/$package/start"
  ln -s "$packages_dir/$package" "$pack_dir/$package/start/$package"
}

install_bin_dir () {
  local repo_path="$1"; shift

  if [[ ! -h "${HOME}/bin" ]]
  then
    ln -s "${repo_path}/bin" "${HOME}/bin"
  fi
}

setup_neovim () {
  install_config "nvim" "${repo_path}" "${HOME}/.config"
#  install_nvim_dependency \
#      "fzf-lua" \
#      "https://github.com/ibhagwan/fzf-lua.git"
#  install_nvim_dependency \
#      "lualine" \
#      "https://github.com/nvim-lualine/lualine.nvim.git"
#  install_nvim_dependency \
#      "nightfox" \
#      "https://github.com/EdenEast/nightfox.nvim.git"
#  install_nvim_dependency \
#      "nvim-fzf" \
#      "https://github.com/vijaymarupudi/nvim-fzf.git"
#  install_nvim_dependency \
#      "nvim-lspconfig" \
#      "https://github.com/neovim/nvim-lspconfig.git"
#  install_nvim_dependency \
#      "nvim-tree" \
#      "https://github.com/kyazdani42/nvim-tree.lua.git"
#  install_nvim_dependency \
#      "nvim-web-devicons" \
#      "https://github.com/kyazdani42/nvim-web-devicons.git"
#  install_nvim_dependency \
#      "nvim-plenary" \
#      "https://github.com/nvim-lua/plenary.nvim.git"
#  install_nvim_dependency \
#      "nvim-telescope" \
#      "https://github.com/nvim-telescope/telescope.nvim.git"
}

INSTALL_GIT_CONFIGS=false
INSTALL_NEOVIM_CONFIGS=false
INSTALL_ALACRITTY_CONFIGS=false
INSTALL_SWAY_CONFIGS=false
INSTALL_NEOVIM_CONFIGS=false
INSTALL_BINS=false

parse_args () {
  while [[ $# -gt 0 ]]
  do
    param="$1"; shift

    case "$param" in
      --git)
        INSTALL_GIT_CONFIGS=true
        break
        ;;
      --nvim)
        INSTALL_NEOVIM_CONFIGS=true
        break
        ;;
      --alacritty)
        INSTALL_ALACRITTY_CONFIGS=true
        break
        ;;
      --sway)
        INSTALL_SWAY_CONFIGS=true
        break
        ;;
      --bins)
        INSTALL_BINS=true
        break
        ;;
      --all)
        INSTALL_GIT_CONFIGS=true
        INSTALL_NEOVIM_CONFIGS=true
        INSTALL_ALACRITTY_CONFIGS=true
        INSTALL_SWAY_CONFIGS=true
        INSTALL_NEOVIM_CONFIGS=true
        INSTALL_BINS=true
        break
        ;;
      default)
        echo "ERROR: Unrecognised parameter $param"
        exit 1
    esac
  done
}

main () {
  local script_path
  local repo_path

  script_path=$(realpath "${BASH_SOURCE[0]}")
  repo_path=$(dirname "${script_path}")

  parse_args "$@"

  # Git Configurations.
  if $INSTALL_GIT_CONFIGS
  then
    install_config ".gitconfig" "${repo_path}" "${HOME}"
    # If the local file does not exist, it will be created.
    # It will be poplulated separately with the more
    # sensitive content.
    touch "${HOME:?}/.gitconfig.local"
  fi

  # Alacritty Configurations.
  if $INSTALL_ALACRITTY_CONFIGS
  then
    install_config "alacritty" "${repo_path}" "${HOME:?}/.config"
  fi

  # Sway Configurations.
  if $INSTALL_SWAY_CONFIGS
  then
    install_config "sway" "${repo_path}" "${HOME:?}/.config"
    install_config "waybar" "${repo_path}" "${HOME:?}/.config"
  fi

  # NeoVim Configurations
  if $INSTALL_NEOVIM_CONFIGS
  then
    setup_neovim
  fi

  if $INSTALL_BINS
  then
    install_bin_dir "${repo_path}"
  fi
}


if [[ -n ${BASH_SOURCE[0]} ]]
then
  main "$@"
fi
