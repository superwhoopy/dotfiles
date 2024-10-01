# safe PowerShell mode
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# scoop update
scoop update --all
scoop cleanup --all
scoop cache rm -a

# pacman full update
ucrt64 -shell bash -c "pacman -Syu --noconfirm" --norc --noprofile
