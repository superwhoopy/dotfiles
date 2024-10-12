#!/usr/bin/env bash
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

_chezmoiprint "System packages update script"

if _command_exists apt;
then
  sudo -- sh -c 'apt update && apt upgrade -y && apt autoclean --yes && apt autoremove --purge --yes'
elif _command_exists pamac
then
  pamac upgrade --aur --no-confirm
fi
