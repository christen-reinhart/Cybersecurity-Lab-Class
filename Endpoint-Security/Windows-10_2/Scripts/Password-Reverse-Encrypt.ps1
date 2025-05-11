# File: 1.1.7-ReversibleEncryptionDisabled.ps1
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -ItemType Directory -Path $LogPath | Out-Null }
$LogFile = "$LogPath\1.1.7-ReversibleEncryptionDisabled.log"
Start-Transcript -Path $LogFile -Append

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "Run as Administrator required."; Stop-Transcript; exit 1
}

$cfg = "$env:TEMP\reversible.cfg"
secedit /export /cfg $cfg
(gc $cfg) -replace "^ClearTextPassword = .*", "ClearTextPassword = 0" | Set-Content -Encoding Unicode $cfg
secedit /configure /db secedit.sdb /cfg $cfg /quiet

Write-Host "✅ Storing passwords using reversible encryption is now disabled."
Stop-Transcript
