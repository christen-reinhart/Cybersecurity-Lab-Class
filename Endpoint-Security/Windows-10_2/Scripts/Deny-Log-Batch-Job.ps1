# File: 2.2.17-DenyBatchJobLogon.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.17-DenyBatchJobLogon.log"
Start-Transcript -Path $LogFile -Append

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "Administrator rights required."; Stop-Transcript; exit 1
}

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
if (-not (Test-Path $ntrights)) {
    Write-Warning "ntrights.exe not found."; Stop-Transcript; exit 1
}

& $ntrights -m \\$env:COMPUTERNAME -u "Guests" +r SeDenyBatchLogonRight

Write-Host "✅ 'Deny log on as a batch job' set to Guests."
Stop-Transcript
