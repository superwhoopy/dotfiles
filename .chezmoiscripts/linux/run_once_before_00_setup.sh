#!/bin/bash
set -euo pipefail

function _command_exists() {
  command -v "${*}" &> /dev/null
}

function _blue() {
  printf "\e[34m%s\033[0m\n" "${*}"
}

function _chezmoiprint() {
  _blue "###############################################################################"
  _blue "CHEZMOI - ${*}"
  _blue "###############################################################################"
}

################################################################################

_chezmoiprint "Initial setup script"

# install brew if needed
if [ ! -f /home/linuxbrew/.linuxbrew/bin/brew ];
then
  _blue "Installing brew"
  NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
fi
