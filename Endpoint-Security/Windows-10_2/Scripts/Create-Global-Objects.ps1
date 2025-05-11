# File: 2.2.12-CreateGlobalObjects.ps1
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\2.2.12-CreateGlobalObjects.log"
Start-Transcript -Path $LogFile -Append

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "Administrator rights required."; Stop-Transcript; exit 1
}

$ntrights = "$env:SystemRoot\System32\ntrights.exe"
if (-not (Test-Path $ntrights)) {
    Write-Warning "ntrights.exe not found."; Stop-Transcript; exit 1
}

& $ntrights -r SeCreateGlobalPrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeCreateGlobalPrivilege
& $ntrights -m \\$env:COMPUTERNAME -u "LOCAL SERVICE" +r SeCreateGlobalPrivilege
& $ntrights -m \\$env:COMPUTERNAME -u "NETWORK SERVICE" +r SeCreateGlobalPrivilege
& $ntrights -m \\$env:COMPUTERNAME -u "SERVICE" +r SeCreateGlobalPrivilege

Write-Host "✅ 'Create global objects' set to Administrators, LOCAL SERVICE, NETWORK SERVICE, and SERVICE."
Stop-Transcript
