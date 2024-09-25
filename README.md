# dotfiles

## TODO-List

[X] Add Linux config directories with a templated `.chezmoiignore` file
[X] Add missing git files: rofi, terminator, gitconfig.os
[X] Add ahk file somewhere?
[X] Find a way to add project files
[ ] Windows scripts:
    [X] Install from list of packages in a file
    [ ] Setup zsh prompt
    [ ] MSYS2
        [ ] Install pacman packages list
        [ ] Enable native links
        [ ] Dirlinks between home directories
    [ ] Windows Terminal Configuration
    [ ] Get OpenVPN configuration from Drive?
[ ] Blank test run in Sandbox
[ ] Linux/WSL setup
    [ ] ...
[ ] Install nvim plugin


## Initial Setup

### Windows

Run this script:

```ps1
# install scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# install git+chezmoi
scoop install git chezmoi

# get the dotfiles repo and install
chezmoi init --apply --progress=true superwhoopy
```


### Linux

TODO



