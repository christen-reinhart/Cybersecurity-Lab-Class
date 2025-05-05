# DeepBlueCLI Installation and Usage Guide

## Overview

**DeepBlueCLI** is a PowerShell-based threat hunting tool designed for parsing and analyzing Windows Event Logs, especially useful for detecting signs of compromise in digital forensic investigations. It's ideal for security analysts and DFIR professionals conducting triage on Windows endpoints.

## System Requirements

- Windows 10 (Windows-10_1 VM recommended)
- PowerShell (v5.1 or later)
- Administrator privileges
- Access to Windows Event Logs (.evtx files)

## Installation Instructions

1. **Open PowerShell as Administrator**

2. **Download DeepBlueCLI from GitHub**

```powershell
git clone https://github.com/sans-blue-team/DeepBlueCLI.git
```

3. **Navigate to the DeepBlueCLI Directory**

```powershell
cd DeepBlueCLI
```

4. **Unblock the PowerShell Script Files**

```powershell
Get-ChildItem *.ps1 | Unblock-File
```

## Usage Examples

### 1. Analyze a Local Security Event Log File

```powershell
.\DeepBlue.ps1 -Log "C:\Windows\System32\winevt\Logs\Security.evtx"
```

### 2. Parse All Logs in a Directory

```powershell
Get-ChildItem "C:\Forensics\Logs\" -Recurse -Filter *.evtx | % {
    .\DeepBlue.ps1 -Log $_.FullName
}
```

## Common Use Cases

- Detecting PowerShell downgrade attacks
- Identifying malicious use of `Rundll32`, `WMI`, or `Scheduled Tasks`
- Triage suspicious login attempts and lateral movement techniques

## Additional Resources

- [DeepBlueCLI GitHub Repository](https://github.com/sans-blue-team/DeepBlueCLI)
- [SANS Blue Team Tools](https://www.sans.org/blue-team-tools/)

---

*Maintained for the Windows-10_1 VM as part of the Cybersecurity Lab Class: Digital Forensics Toolkit.*
