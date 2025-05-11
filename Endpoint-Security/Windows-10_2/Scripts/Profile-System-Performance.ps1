# File: 2.2.35-ProfileSystemPerformance.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.35-ProfileSystemPerformance.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeSystemProfilePrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeSystemProfilePrivilege
& $ntrights -m \\$env:COMPUTERNAME -u "NT SERVICE\\WdiServiceHost" +r SeSystemProfilePrivilege

Write-Host "✅ 'Profile system performance' set to Administrators and WdiServiceHost."
Stop-Transcript
