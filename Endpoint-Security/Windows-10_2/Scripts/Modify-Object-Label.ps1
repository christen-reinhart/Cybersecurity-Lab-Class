# File: 2.2.31-ModifyObjectLabel.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.31-ModifyObjectLabel.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeRelabelPrivilege -u "Everyone"

Write-Host "✅ 'Modify an object label' privilege removed from all users (No One)."
Stop-Transcript
