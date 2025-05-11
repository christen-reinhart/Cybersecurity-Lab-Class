# File: 2.2.26-LoadUnloadDrivers.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.26-LoadUnloadDrivers.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeLoadDriverPrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeLoadDriverPrivilege

Write-Host "✅ 'Load and unload device drivers' privilege set to Administrators."
Stop-Transcript
