# Testing Procedures for Dotfiles

This directory holds scripts to test that the initial setup of dotfiles managed
with *chezmoi* works as expected.

* **On Windows**: 
    * run `start sandbox.wsb` to bootstrap dotfiles and scripts in a vanilla
      sandboxed Windows environment;
    * run `pwsh runtest-wsl.ps1` to bootstrap dotfiles and scripts in a vanilla
      Ubuntu WSL environment (creates a WSL Ubuntu distro called
      `UbuntuChezmoiTest`).

* **On Linux**: TODO (coming soon…)
