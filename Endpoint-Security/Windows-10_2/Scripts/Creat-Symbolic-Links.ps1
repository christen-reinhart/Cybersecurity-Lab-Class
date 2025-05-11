# File: 2.2.14-CreateSymbolicLinks.ps1
$LogPath = "$env:SystemDrive\CIS-Hardening-Logs"
if (-not (Test-Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory | Out-Null }
$LogFile = "$LogPath\2.2.14-CreateSymbolicLinks.log"
Start-Transcript -Path $LogFile -Append

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Write-Warning "Administrator rights required."; Stop-Transcript; exit 1
}

$ntrights = "$env:SystemRoot\System32\ntrights.exe"
if (-not (Test-Path $ntrights)) {
    Write-Warning "ntrights.exe not found."; Stop-Transcript; exit 1
}

# Clean up any existing assignments
& $ntrights -r SeCreateSymbolicLinkPrivilege -u "Everyone"

# Apply to Administrators
& $ntrights -m \\$env:COMPUTERNAME -u "Administrators" +r SeCreateSymbolicLinkPrivilege

# Optional: Add Virtual Machines group (for Hyper-V environments)
try {
    & $ntrights -m \\$env:COMPUTERNAME -u "NT VIRTUAL MACHINE\\Virtual Machines" +r SeCreateSymbolicLinkPrivilege
} catch {
    Write-Warning "NT VIRTUAL MACHINE\\Virtual Machines group not found. Skipping optional assignment."
}

Write-Host "✅ 'Create symbolic links' set to Administrators (and optionally Virtual Machines group)."
Stop-Transcript
