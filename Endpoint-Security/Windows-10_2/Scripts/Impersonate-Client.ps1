# File: 2.2.24-ImpersonateClient.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.24-ImpersonateClient.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeImpersonatePrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeImpersonatePrivilege
& $ntrights -m \\$env:COMPUTERNAME -u "LOCAL SERVICE" +r SeImpersonatePrivilege
& $ntrights -m \\$env:COMPUTERNAME -u "NETWORK SERVICE" +r SeImpersonatePrivilege
& $ntrights -m \\$env:COMPUTERNAME -u "SERVICE" +r SeImpersonatePrivilege

Write-Host "✅ 'Impersonate a client after authentication' set to recommended groups."
Stop-Transcript
