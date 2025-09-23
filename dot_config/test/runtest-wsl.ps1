# safe PowerShell mode
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$wslname = "UbuntuChezmoiTest"
Write-Output "Creating a WSL distro '$wslname'..."
wsl --install Ubuntu --name $wslname --no-launch
Write-Output "Creating new (sudoer) user manu..."
wsl -d $wslname -u root -- useradd -m -s /usr/bin/bash -G sudo manu
wsl -d $wslname -u root -- passwd --delete manu
Write-Output "Bootstraping chezmoi"
wsl -d $wslname -u manu -- . ./runtest-ubuntu.sh
