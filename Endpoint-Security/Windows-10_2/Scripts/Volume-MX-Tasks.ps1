# File: 2.2.33-PerformVolumeMaintenance.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.33-PerformVolumeMaintenance.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeManageVolumePrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeManageVolumePrivilege

Write-Host "✅ 'Perform volume maintenance tasks' set to Administrators."
Stop-Transcript
