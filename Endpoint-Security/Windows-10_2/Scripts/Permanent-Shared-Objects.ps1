# File: 2.2.13-CreatePermanentSharedObjects.ps1
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\2.2.13-CreatePermanentSharedObjects.log"
Start-Transcript -Path $LogFile -Append

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "Administrator rights required."; Stop-Transcript; exit 1
}

$ntrights = "$env:SystemRoot\System32\ntrights.exe"
if (-not (Test-Path $ntrights)) {
    Write-Warning "ntrights.exe not found."; Stop-Transcript; exit 1
}

& $ntrights -r SeCreatePermanentPrivilege -u "Everyone"

Write-Host "✅ 'Create permanent shared objects' set to No One."
Stop-Transcript
