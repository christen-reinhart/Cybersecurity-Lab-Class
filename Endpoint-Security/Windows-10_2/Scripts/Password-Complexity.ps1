# File: 1.1.5-PasswordComplexity.ps1
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -ItemType Directory -Path $LogPath | Out-Null }
$LogFile = "$LogPath\1.1.5-PasswordComplexity.log"
Start-Transcript -Path $LogFile -Append

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "Run as Administrator required."; Stop-Transcript; exit 1
}

$cfg = "$env:TEMP\pass_complexity.cfg"
secedit /export /cfg $cfg
(gc $cfg) -replace "^PasswordComplexity = .*", "PasswordComplexity = 1" | Set-Content -Encoding Unicode $cfg
secedit /configure /db secedit.sdb /cfg $cfg /quiet

Write-Host "✅ Password complexity requirement is now enabled."
Stop-Transcript
