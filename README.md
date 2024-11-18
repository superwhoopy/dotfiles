# dotfiles

## TODO-List

* Setup fetching of sensitive files from KeePassXC: require to download the
    database somewhere on disk first, then get from there:
    * OpenVPN configuration
* SSH
    * ✅ Setup creation of SSH keys if they don't exist
    * Version known hosts?
* Windows scripts:
    * Get and setup OpenVPN configuration?
    * Install WSL
    * Set symlink authorization
    * Google Drive App
    * Setup `SCOOP` environment variable
    * Append `/ucrt64/bin` to PATH to have a working gcc
    * Append `$env:USERPROFILE\.local\bin` to PATH for pipx
    * Find a way to prevent msys2 scopp update: fucks up everything
* Linux/WSL setup
    * FIND A WAY TO TEST IT (DOCKER?)
    * Setup /etc/hosts
    * Setup OpenVPN?
    * Install nerdfonts
    * Must be `sudo` to install *brew*: force INTERACTIVE
    * brew dir not in PATH after install, fails everything
    * distinction between WSL and actual Linux machine (no firefox, spotify and other stuff)
    * Try to continue on error in install scripts?
    * Miss: starship, eza, zoxide
    * Mattermost fails to install with snap
* Update this README

## Initial Setup

### Windows

Run this script:

```ps1
# enable PowerShell script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
# TODO: set SCOOP environment variable to $env:USERPROFILE\scoop
# download scoop, use it to install chezmoi
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install chezmoi
# bootstrap the rest of the world
chezmoi init --apply superwhoopy
```

### Linux

TODO
