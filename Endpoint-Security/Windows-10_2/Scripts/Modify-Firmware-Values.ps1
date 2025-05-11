# File: 2.2.32-ModifyFirmwareEnvValues.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.32-ModifyFirmwareEnvValues.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeSystemEnvironmentPrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeSystemEnvironmentPrivilege

Write-Host "✅ 'Modify firmware environment values' set to Administrators."
Stop-Transcript
