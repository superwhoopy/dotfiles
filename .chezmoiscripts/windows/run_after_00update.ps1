# safe PowerShell mode
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Trace-Chezmoi {
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

Trace-Chezmoi "System packages update script"

Write-Output "Scoop update..."
# scoop update
scoop update --all
scoop cleanup --all
scoop cache rm -a

# pacman full update
Write-Output "MSYS2 update..."
$msys2_prefix = scoop prefix msys2
$sh = Join-Path $msys2_prefix "usr\bin\sh"
& $sh --login --norc -c "pacman -Syu --noconfirm && paccache -r"
