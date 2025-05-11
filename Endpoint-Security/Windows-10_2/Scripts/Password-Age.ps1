# =============================
# File: 1.1.2-MaximumPasswordAge.ps1
# Description: Ensure 'Maximum password age' is set to '365 or fewer days, but not 0'
# Level 1 - Domain or Standalone Environment
# =============================

# Define log path
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) {
    New-Item -ItemType Directory -Path $LogPath | Out-Null
}
$LogFile = "$LogPath\1.1.2-MaximumPasswordAge.log"
Start-Transcript -Path $LogFile -Append

# Check for administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script! Please run as Administrator."
    Stop-Transcript
    exit 1
}

# Export current security configuration
$SecCfg = "$env:TEMP\password_policy.cfg"
secedit /export /cfg $SecCfg

# Apply the maximum password age setting (365 days)
(gc $SecCfg) -replace "^MaximumPasswordAge = .*", "MaximumPasswordAge = 365" | Set-Content -Encoding Unicode $SecCfg

# Configure the new policy
secedit /configure /db secedit.sdb /cfg $SecCfg /quiet

Write-Host "✅ Maximum password age set to 365 days."
Stop-Transcript
