# dotfiles

## TODO-List

[X] Add Linux config directories with a templated `.chezmoiignore` file
[X] Add missing git files: rofi, terminator, gitconfig.os
[X] Add ahk file somewhere?
[X] Find a way to add project files
[X] Setup zsh shell: oh-my-zsh, zsh-autosuggestions, zsh-autocompletion
    [X] Test it?
[ ] Setup fetching of sensitive files from KeePassXC: require to download the
    database somewhere on disk first, then get from there:
    [ ] SSH pub & private keys
    [ ] OpenVPN configuration
[ ] Windows scripts:
    [ ] Get and setup OpenVPN configuration?
    [ ] Install WSL?
[ ] Linux/WSL setup
    [X] Setup /etc/hosts
    [ ] Setup OpenVPN?
    [ ] Install nerdfonts
    [ ] Find a way to test it (Docker?)
[ ] Update this README

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
