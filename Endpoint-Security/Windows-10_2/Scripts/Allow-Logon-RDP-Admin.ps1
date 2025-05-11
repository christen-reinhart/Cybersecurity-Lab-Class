# File: 2.2.6-AllowLogonRemote.ps1
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\2.2.6-AllowLogonRemote.log"
Start-Transcript -Path $LogFile -Append

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "Administrator privileges required."; Stop-Transcript; exit 1
}

$ntrights = "$env:SystemRoot\System32\ntrights.exe"
if (-not (Test-Path $ntrights)) {
    Write-Warning "ntrights.exe not found. Please install it before running this script."
    Stop-Transcript; exit 1
}

& $ntrights -r SeRemoteInteractiveLogonRight -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeRemoteInteractiveLogonRight
& $ntrights -m \\$env:COMPUTERNAME -u "Remote Desktop Users" +r SeRemoteInteractiveLogonRight

Write-Host "✅ 'Allow log on through Remote Desktop Services' set to Administrators and Remote Desktop Users."
Stop-Transcript

