# CIS 1.2.4 - Reset Account Lockout Counter
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
$LogFile = "$LogPath\1.2.4-ResetAccountLockoutCounter.log"
Start-Transcript -Path $LogFile -Append
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You must run this script as Administrator."; Stop-Transcript; exit 1
}
secedit /export /cfg $env:TEMP\secpol.cfg
(gc $env:TEMP\secpol.cfg) -replace "^ResetLockoutCount = .*", "ResetLockoutCount = 15" | Set-Content -Encoding Unicode $env:TEMP\secpol.cfg
secedit /configure /db secedit.sdb /cfg $env:TEMP\secpol.cfg /quiet
Write-Host "Set reset lockout counter to 15 minutes."
Stop-Transcript

