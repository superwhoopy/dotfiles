# safe PowerShell mode
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# download chezmoi and apply, see how it goes
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -- init --apply superwhoopy"
