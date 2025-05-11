# File: 2.2.25-IncreaseSchedulingPriority.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.25-IncreaseSchedulingPriority.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeIncreaseBasePriorityPrivilege -u "Everyone"
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeIncreaseBasePriorityPrivilege
& $ntrights -m \\$env:COMPUTERNAME -u "Window Manager\\Window Manager Group" +r SeIncreaseBasePriorityPrivilege

Write-Host "✅ 'Increase scheduling priority' set to Administrators and Window Manager group."
Stop-Transcript
