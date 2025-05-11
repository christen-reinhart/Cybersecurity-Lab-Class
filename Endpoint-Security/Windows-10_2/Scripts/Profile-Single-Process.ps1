# File: 2.2.34-ProfileSingleProcess.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.34-ProfileSingleProcess.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeProfileSingleProcessPrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeProfileSingleProcessPrivilege

Write-Host "✅ 'Profile single process' set to Administrators."
Stop-Transcript
