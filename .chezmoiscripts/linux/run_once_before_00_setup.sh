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

_chezmoiprint "Initial setup script"


# install brew if needed
_linuxbrew_dir="/home/linuxbrew/.linuxbrew"
if [ ! -f ${_linuxbrew_dir}/bin/brew ];
then
  _blue "Installing brew"
  /usr/bin/env NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # setup environment variables to run brew commands in this shell
  export HOMEBREW_PREFIX="${_linuxbrew_dir}";
  export HOMEBREW_CELLAR="${_linuxbrew_dir}/Cellar";
  export HOMEBREW_REPOSITORY="${_linuxbrew_dir}/Homebrew";
  export PATH="${_linuxbrew_dir}/bin:${_linuxbrew_dir}/sbin${PATH+:$PATH}";
  export MANPATH="${_linuxbrew_dir}/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="${_linuxbrew_dir}/share/info:${INFOPATH:-}";
fi

# update /etc/hosts if needed
if ! /bin/grep --silent mattermost.ks.int /etc/hosts;
then
  _blue "Editing /etc/hosts file"
  sudo -- sh << EOF
(
  echo "# Internal servers ###################"
  echo "10.191.2.10  intra.ks.int"
  echo "10.191.2.63  mattermost.ks.int"
  echo "10.191.2.24  front.jenkins.ks.int"
  echo "10.191.2.26  license.ks.int"
  echo "10.191.2.28  core.jenkins.ks.int"
  echo "10.191.2.35  dev.ks.int"
  echo "10.191.2.56  polarion.ks.int"
  echo "10.191.2.37  mail.ks.int"
  echo "10.191.2.38  checker.jenkins.ks.int"
  echo "10.191.2.40  designer.jenkins.ks.int"
  echo "10.191.2.22  dal.jenkins.ks.int"
  echo "10.191.2.42  store.ks.int"
  echo "10.191.2.43  doc.ks.int"
  echo "10.191.2.64  haas.ks.int"
  echo "######################################"
) >> /etc/hosts
EOF
fi

# Install package age, to decipher the private key
if ! _command_exists age;
then
  _blue "Install age" && brew install age
fi

# decrypt age private key
_age_private_key="${HOME}/.config/chezmoi/key.txt"
_age_private_key_enc="{{ .chezmoi.sourceDir }}/key.txt.age"
if [ ! -f "${_age_private_key}" ]; then
  _blue "Decrypt age private key from ${_age_private_key_enc}"
  mkdir -p "$(dirname "${_age_private_key}")"
  chezmoi age decrypt --output "${_age_private_key}" --passphrase \
    "${_age_private_key_enc}"
  chmod 600 "${_age_private_key}"
fi
