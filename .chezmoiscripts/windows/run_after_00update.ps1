# safe PowerShell mode
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Output "Scoop update..."
# scoop update
scoop update --all
scoop cleanup --all
scoop cache rm -a

# pacman full update
Write-Output "MSYS2 update..."
sh --noprofile --norc -c "pacman -Syu --noconfirm"
