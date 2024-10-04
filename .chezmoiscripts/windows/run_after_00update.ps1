# safe PowerShell mode
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function ChezMoi-Echo {
  param (
    $Message
  )
  $color = "DarkBlue"
  Write-Output ""
  Write-Host "************************************************" -ForegroundColor $color
  Write-Host " CHEZMOI - $Message" -ForegroundColor $color
  Write-Host "************************************************" -ForegroundColor $color
  Write-Output ""
}

################################################################################

ChezMoi-Echo "System packages update script"

Write-Output "Scoop update..."
# scoop update
scoop update --all
scoop cleanup --all
scoop cache rm -a

# pacman full update
Write-Output "MSYS2 update..."
sh --noprofile --norc -c "pacman -Syu --noconfirm"
