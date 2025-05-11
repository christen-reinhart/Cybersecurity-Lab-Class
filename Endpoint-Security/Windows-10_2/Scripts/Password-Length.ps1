# File: 1.1.6-RelaxMinPasswordLengthLimit.ps1
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -ItemType Directory -Path $LogPath | Out-Null }
$LogFile = "$LogPath\1.1.6-RelaxMinPasswordLengthLimit.log"
Start-Transcript -Path $LogFile -Append

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "Run as Administrator required."; Stop-Transcript; exit 1
}

# Enable 'Relax minimum password length limits'
New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\SAM" -Name "RelaxMinimumPasswordLengthLimits" -PropertyType DWORD -Value 1 -Force | Out-Null

Write-Host "✅ Relax minimum password length limits set to Enabled (registry key set)."
Stop-Transcript
