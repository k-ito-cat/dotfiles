$ErrorActionPreference = "Stop"

$scriptRoot = $PSScriptRoot

winget configure -f (Join-Path $scriptRoot "configuration.winget")

& (Join-Path $scriptRoot "apply.ps1")
