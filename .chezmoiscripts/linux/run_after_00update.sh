#!/bin/bash
set -euo pipefail

function _command_exists() {
  command -v "${*}" &> /dev/null
}

_command_exists apt && (
  sudo -- sh -c 'apt update && apt upgrade -y && apt autoclean --yes && apt autoremove --purge --yes'
)
