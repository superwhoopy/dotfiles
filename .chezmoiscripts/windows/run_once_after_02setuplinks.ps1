# safe PowerShell mode
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Write-Chezmoi {
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

function Write-Blue {
  param ( $Message )
  $color = "DarkBlue"
  Write-Host $Message -ForegroundColor $color
}

Write-Chezmoi "SSH Keys & Symbolic links"

# refresh Path environment variable, in case a setup script ran before
$env:Path = `
  [System.Environment]::GetEnvironmentVariable("Path","Machine") `
  + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

################################################################################

# TODO: put this in a Python script common to Windows & Linux instead
Write-Blue "SSH keys verification"
$ssh_private_key = Join-Path $env:USERPROFILE ".ssh/id_ecdsa"
if (! (Test-Path $ssh_private_key)) {
  # generate the SSH key with empty passphrase
  Write-Blue "No SSH key found: generate one in $ssh_private_key"
  ssh-keygen -t ecdsa -P ""
}

################################################################################

Write-Blue "Windows Terminal config. file"

# Define the paths
$destconf = Join-Path $(scoop prefix windows-terminal) `
  "..\..\..\persist\windows-terminal\settings\settings.json"
$srcconf = Join-Path $env:USERPROFILE ".config\windows-terminal-settings.json"

if (Test-Path $destconf) {
    # Check if it is a symbolic link
    $linkTarget = Get-Item $destconf | `
      Select-Object -ExpandProperty Target -ErrorAction SilentlyContinue
    if ($linkTarget -eq $srcconf) {
        # If the link already exists, do nothing
    } elseif (-not $linkTarget) {
        Remove-Item $destconf
        New-Item -ItemType SymbolicLink -Path $destconf -Target $srcconf
        Write-Output "File has been replaced with a symbolic link."
    }
} else {
    # If adir/config.json does not exist, create the symbolic link
    New-Item -ItemType SymbolicLink -Path $destconf -Target $srcconf
    Write-Output "Symbolic link created."
}

################################################################################

