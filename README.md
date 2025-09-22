# dotfiles

## TODO-List

* Replace pipx with uv tool entirely
* Correct setup of Python LSP server, with extensions
* Setup fetching of sensitive files from KeePassXC: require to download the
    database somewhere on disk first, then get from there:
* SSH
    * Version known hosts?
* Windows scripts:
    * Install WSL
    * Set symlink authorization
    * Google Drive App
    * Environment & PATH manipulation:
        * Append `/ucrt64/bin` to PATH to have a working gcc
        * Append `$env:USERPROFILE\.local\bin` to PATH for uv
        * Setup `SCOOP` environment variable
    * Find a way to prevent msys2 scoop update (auto-freeze?): fucks up everything
* Linux/WSL setup
    * FIND A WAY TO TEST IT (DOCKER?)
    * Setup /etc/hosts
    * Setup OpenVPN?
    * Install nerdfonts
    * Must be `sudo` to install *brew*: force INTERACTIVE
    * brew dir not in PATH after install, fails everything
    * Try to continue on error in install scripts?
    * Mattermost fails to install with flatpak
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
