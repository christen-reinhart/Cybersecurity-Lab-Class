# File: 2.2.27-LockPagesInMemory.ps1
$LogPath = "$env:SystemDrive\\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\\2.2.27-LockPagesInMemory.log"
Start-Transcript -Path $LogFile -Append

$ntrights = "$env:SystemRoot\\System32\\ntrights.exe"
& $ntrights -r SeLockMemoryPrivilege -u "Everyone"

Write-Host "✅ 'Lock pages in memory' privilege removed from all users (No One)."
Stop-Transcript
