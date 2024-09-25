# dotfiles

## TODO-List

[X] Add Linux config directories with a templated `.chezmoiignore` file
[X] Add missing git files: rofi, terminator, gitconfig.os
[X] Add ahk file somewhere?
[X] Find a way to add project files
[ ] Windows scripts:
    [ ] Install from list of packages in a file
    [ ] Setup zsh prompt
    [ ] Enable native links in MSYS
    [ ] Get OpenVPN configuration from Drive?
[ ] Blank test run in Sandbox
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
chezmoi init --apply --verbose superwhoopy
```


### Linux

TODO



