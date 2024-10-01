# dotfiles

## TODO-List

[X] Add Linux config directories with a templated `.chezmoiignore` file
[X] Add missing git files: rofi, terminator, gitconfig.os
[X] Add ahk file somewhere?
[X] Find a way to add project files
[X] Setup zsh shell: oh-my-zsh, zsh-autosuggestions, zsh-autocompletion
    [ ] Test it?
[ ] Windows scripts:
    [X] Install from list of packages in a file
    [X] Handle global update process with `chezmoi update`
    [ ] MSYS2
        [X] Dirlinks between home directories
        [ ] Install and maintain pacman packages list
    [ ] Windows Terminal Configuration
        [ ] Enable native links
    [ ] Get and setup OpenVPN configuration from Drive?
    [X] Make sure that .profile file is sourced by MSYS2 - it's not
    [ ] Install Windows Terminal?
    [ ] Install WSL?
    [ ] Setup test with Sandbox
[ ] Linux/WSL setup
    [ ] Setup /etc/hosts
    [ ] Setup OpenVPN?
    [ ] Maintain list of packages
    [ ] Initial setup: brew, pipx, etc.
    [ ] Find a way to test it (Docker?)


## Initial Setup

### Windows

Run this script:

```ps1
# install chezmoi and everything else
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -- init --apply superwhoopy"
```


### Linux

TODO
