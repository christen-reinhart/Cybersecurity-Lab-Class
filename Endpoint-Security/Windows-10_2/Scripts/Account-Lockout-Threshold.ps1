# CIS 1.2.2 - Account Lockout Threshold
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
$LogFile = "$LogPath\1.2.2-AccountLockoutThreshold.log"
Start-Transcript -Path $LogFile -Append
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You must run this script as Administrator."; Stop-Transcript; exit 1
}
secedit /export /cfg $env:TEMP\secpol.cfg
(gc $env:TEMP\secpol.cfg) -replace "^LockoutBadCount = .*", "LockoutBadCount = 5" | Set-Content -Encoding Unicode $env:TEMP\secpol.cfg
secedit /configure /db secedit.sdb /cfg $env:TEMP\secpol.cfg /quiet
Write-Host "Set account lockout threshold to 5."
Stop-Transcript

