################################################################################
# CAUTION: this script is not meant to be executed directly, but within and
# Sandboxed Windows environment.
################################################################################

# safe PowerShell mode
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# download scoop, chezmoi and apply, see how it goes
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install chezmoi
chezmoi init --apply superwhoopy
