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
    [X] Make sure that .profile file is sourced by MSYS2 - it's not
    [X] Install Windows Terminal?
    [X] MSYS2
        [X] Dirlinks between home directories
        [X] Install and maintain pacman packages list
    [X] Windows Terminal Configuration + Enable native links / use env. variables for MSYS2
        [X] Setup link to windows terminal configuration in `scoop/persist/wt/settings/settings.json`, make sure it works on a fresh install + on updates
    [X] Setup test with Sandbox
    [X] Setup ahk script auto-startup
    [ ] Get and setup OpenVPN configuration from Drive?
    [ ] Install WSL?
[ ] Linux/WSL setup
    [X] Setup /etc/hosts
    [ ] Setup OpenVPN?
    [ ] Maintain list of packages
    [ ] Initial setup: brew, pipx, etc.
    [ ] Install nerdfonts
    [ ] Find a way to test it (Docker?)
[ ] Update this README

The initial setup script may be a good place for the broad installation of all packages, *only if it is re-run on update*. But I don't know if that's true: is a `run_once` *templated* script re-executed on change, considering that the template data may have changed? Or is it only re-executed if the template file itself has changed?

## Initial Setup

### Windows

Run this script:

```ps1
# install chezmoi and everything else
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install chezmoi
chezmoi init --apply superwhoopy
```


### Linux

TODO
