# dotfiles

## TODO-List

* Setup fetching of sensitive files from KeePassXC: require to download the
    database somewhere on disk first, then get stuff from there?
* SSH
    * Version known hosts?
* Windows scripts:
    * Install WSL
    * Set symlink authorization
    * Google Drive App
* Linux/WSL setup
    * Install nerdfonts
    * Try to continue on error in install scripts?
    * Mattermost fails to install with flatpak
* Update this README

## Initial Setup

### Windows

Run this script:

```ps1
# enable PowerShell script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
# download scoop, use it to install chezmoi
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install chezmoi
# bootstrap the rest of the world
chezmoi init --apply superwhoopy
```

### Linux

Run the following script:

```bash
# install chezmoi using snap (available on Ubuntu distros)
sudo snap install chezmoi --classic
# bootstrap the rest of the world
chezmoi init --apply superwhoopy
```

## Test

TODO
