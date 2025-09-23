#!sh
set -eu

sudo snap install chezmoi --classic
export PATH=/snap/bin:"$PATH"
chezmoi init --apply superwhoopy

