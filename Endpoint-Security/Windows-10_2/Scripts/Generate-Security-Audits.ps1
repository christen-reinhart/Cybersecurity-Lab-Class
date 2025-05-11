# File: 2.2.23-GenerateSecurityAudits.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.23-GenerateSecurityAudits.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeAuditPrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "LOCAL SERVICE" +r SeAuditPrivilege
& $ntrights -m \\$env:COMPUTERNAME -u "NETWORK SERVICE" +r SeAuditPrivilege

Write-Host "✅ 'Generate security audits' set to LOCAL SERVICE and NETWORK SERVICE."
Stop-Transcript
