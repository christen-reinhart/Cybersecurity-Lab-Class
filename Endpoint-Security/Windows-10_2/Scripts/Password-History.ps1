# =============================
# File: 1.1.1-EnforcePasswordHistory.ps1
# Description: Ensure 'Enforce password history' is set to '24 or more password(s)'
# Level 1 - Domain Environment
# =============================

# Define log path
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) {
    New-Item -ItemType Directory -Path $LogPath | Out-Null
}
$LogFile = "$LogPath\1.1.1-EnforcePasswordHistory.log"
Start-Transcript -Path $LogFile -Append

# Check if run as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script! Please run as Administrator."
    Stop-Transcript
    exit 1
}

# Export current security settings to a config file
$SecCfg = "$env:TEMP\password_policy.cfg"
secedit /export /cfg $SecCfg

# Apply setting
(gc $SecCfg) -replace "^PasswordHistorySize = .*", "PasswordHistorySize = 24" | Set-Content -Encoding Unicode $SecCfg
secedit /configure /db secedit.sdb /cfg $SecCfg /quiet

Write-Host "✅ Password history policy set to remember 24 passwords."
Stop-Transcript

