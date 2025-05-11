# CIS 1.2.1 - Account Lockout Duration
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -ItemType Directory -Path $LogPath | Out-Null }
$LogFile = "$LogPath\1.2.1-AccountLockoutDuration.log"
Start-Transcript -Path $LogFile -Append
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You must run this script as Administrator."; Stop-Transcript; exit 1
}
secedit /export /cfg $env:TEMP\secpol.cfg
(gc $env:TEMP\secpol.cfg) -replace "^LockoutDuration = .*", "LockoutDuration = 15" | Set-Content -Encoding Unicode $env:TEMP\secpol.cfg
secedit /configure /db $env:SystemRoot\Security\Database\secedit.sdb /cfg $env:TEMP\secpol.cfg /quiet
Write-Host "Set account lockout duration to 15 minutes."
Stop-Transcript

