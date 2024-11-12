# dotfiles

## TODO-List

* Setup fetching of sensitive files from KeePassXC: require to download the
    database somewhere on disk first, then get from there:
    * OpenVPN configuration
* SSH
    * Setup creation of SSH keys if they don't exist
    * Version known hosts?
* Windows scripts:
    * Get and setup OpenVPN configuration?
    * Install WSL?
    * Set decent execution policy for PS scripts
    * Set symlink authorization
    * Manifest for cascadiacode cannot be found
    * Google Drive App
    * SSH keygen fails
    * install zoxide
    * AppData nvim symlink
* Linux/WSL setup
    * Setup /etc/hosts
    * Setup OpenVPN?
    * Install nerdfonts
    * Find a way to test it (Docker?)
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

TODO
