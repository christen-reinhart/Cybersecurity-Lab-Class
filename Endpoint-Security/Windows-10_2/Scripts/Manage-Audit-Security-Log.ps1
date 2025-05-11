# File: 2.2.30-ManageAuditingSecurityLog.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.30-ManageAuditingSecurityLog.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeSecurityPrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeSecurityPrivilege

Write-Host "✅ 'Manage auditing and security log' set to Administrators."
Stop-Transcript
