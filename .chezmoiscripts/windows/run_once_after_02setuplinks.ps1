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

function Add-UserPath {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Paths
    )
    # Get the current user PATH
    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
    foreach ($path in $Paths) {
        # Skip if the path is already in PATH
        if ($currentPath -notlike "*$path*") {
            # Append the new path
            $newPath = $currentPath + ";" + $path
            [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
            Write-Host "Added '$path' to user Path."
        } else {
            Write-Host "'$path' is already in user Path."
        }
    }
    # Broadcast the environment change to all processes
    $env:PATH = [System.Environment]::GetEnvironmentVariable("Path", "User")
}

################################################################################

Write-Chezmoi "First Setup Script (post)"

# refresh Path environment variable, in case a setup script ran before
$env:Path = `
  [System.Environment]::GetEnvironmentVariable("Path","Machine") `
  + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

################################################################################

# TODO: put this in a Python script common to Windows & Linux instead?
Write-Blue "SSH keys verification"
$ssh_private_key = Join-Path $env:USERPROFILE ".ssh/id_ecdsa"
if (! (Test-Path $ssh_private_key)) {
  # generate the SSH key with empty passphrase - note that ssh-keygen is not in
  # the PATH at this point
  Write-Output "No SSH key found: generate one in $ssh_private_key"
  sh -c "ssh-keygen -t ecdsa -P '' -f `$(cygpath `$USERPROFILE/.ssh/id_ecdsa)"
} else {
  Write-Output "SSH key exists - doing nothing"
}

################################################################################

Write-Blue "Setting global Environment Variables"
$ucrt64_bin = Join-Path $(scoop prefix msys2) "ucrt64/bin"
$local_bin  = Join-Path $env:USERPROFILE ".local/bin"
$scoop      = Resolve-Path (Join-Path $(scoop prefix scoop) "../")
Add-UserPath -Paths @("$local_bin", "$ucrt64_bin")
if (-not $env:SCOOP) {
  Write-Output "Defining SCOOP environment variable to '$scoop'"
  [System.Environment]::SetEnvironmentVariable("SCOOP", $scoop, "User")
} else {
  Write-Output "SCOOP environment variable is already set."
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
        Write-Output "The link already exists - nothing to do."
    } elseif (-not $linkTarget) {
        Remove-Item $destconf
        New-Item -ItemType SymbolicLink -Path $destconf -Target $srcconf
        Write-Output "File has been replaced with a symbolic link."
    } else {}
} else {
    # If adir/config.json does not exist, create the symbolic link
    New-Item -ItemType SymbolicLink -Path $destconf -Target $srcconf
    Write-Output "Symbolic link created."
}

################################################################################

