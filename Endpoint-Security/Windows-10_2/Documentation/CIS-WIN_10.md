
# CIS Windows 10 Enterprise v3.0.0 - PowerShell Hardening Scripts

## Overview

This repository provides **PowerShell scripts that automate specific CIS Microsoft Windows 10 Enterprise Benchmark v3.0.0 hardening tasks**.

All scripts are modular, named by CIS control section, and provide individual logging.

> ✅ All scripts are designed for **standalone workstation hardening**, though they may serve as reference for **domain environments (with adjustments for GPOs or PSOs where applicable)**.

## 📂 Directory Structure

```
Cybersecurity-Lab-Class/
└── Endpoint-Security/
    └── Windows-10_2/
        ├── Scripts/           # All individual PowerShell hardening scripts
        └── Documentation/     # This README and additional documentation
```

## 🛠 Usage

1. Open PowerShell **as Administrator**.
2. Navigate to the Scripts directory:
   ```powershell
   cd "C:\Path\To\Scripts"
   ```
3. Run any script:
   ```powershell
   .\1.1.1-EnforcePasswordHistory.ps1
   ```

---

## 🔐 Script Reference Table

| Script Name                                      | CIS Section    | Description                                      | Applies To |
|---------------------------------------------------|----------------|--------------------------------------------------|------------|
| 1.1.1-EnforcePasswordHistory.ps1                 | 1.1.1           | Enforce password history to remember 24          | Local/Domain |
| 1.1.2-MaximumPasswordAge.ps1                     | 1.1.2           | Set max password age to 365 days or less         | Local/Domain |
| 1.1.5-PasswordComplexity.ps1                     | 1.1.5           | Require password complexity                      | Local/Domain |
| 2.2.5-AllowLogonLocally.ps1                      | 2.2.5           | Allow logon locally to Administrators, Users     | Local       |
| 2.2.6-AllowLogonRDP.ps1                          | 2.2.6           | Allow RDP logon to Administrators, RDP Users     | Local       |
| 2.2.7-BackupFilesDirs.ps1                        | 2.2.7           | Restrict backup rights to Administrators         | Local       |
| 2.2.8-ChangeSystemTime.ps1                       | 2.2.8           | Allow system time changes to Admin, LOCAL SERVICE | Local     |
| 2.2.11-CreateTokenObject.ps1                     | 2.2.11          | Restrict Create a token object to No One         | Local       |
| 2.2.12-CreateGlobalObjects.ps1                   | 2.2.12          | Allow create global objects to Admin, LOCAL SERVICE, NETWORK SERVICE, SERVICE | Local |
| 2.2.13-CreatePermSharedObjects.ps1               | 2.2.13          | Restrict create permanent shared objects to No One | Local    |
| 2.2.14-CreateSymbolicLinks.ps1                   | 2.2.14          | Allow create symbolic links to Admin, NT VIRTUAL MACHINE\Virtual Machines | Local |
| 2.2.15-DebugPrograms.ps1                         | 2.2.15          | Allow debug programs to Administrators only      | Local       |
| 2.2.16-DenyAccessFromNetwork.ps1                 | 2.2.16          | Deny network access to Guests, Local Account     | Local       |
| 2.2.17-DenyBatchJob.ps1                          | 2.2.17          | Deny batch job logon to Guests                   | Local       |
| 2.2.18-DenyServiceLogon.ps1                      | 2.2.18          | Deny service logon to Guests                     | Local       |
| 2.2.23-GenerateSecurityAudits.ps1                | 2.2.23          | Allow generate security audits to LOCAL SERVICE, NETWORK SERVICE | Local |
| 2.2.24-ImpersonateAfterAuth.ps1                  | 2.2.24          | Allow impersonate client after auth to Admin, LOCAL SERVICE, NETWORK SERVICE, SERVICE | Local |
| 2.2.25-IncreaseSchedulingPriority.ps1            | 2.2.25          | Restrict increase scheduling priority to Admin, Window Manager Group | Local |
| 2.2.26-LoadUnloadDrivers.ps1                     | 2.2.26          | Restrict load/unload device drivers to Admin     | Local       |
| 2.2.27-LockPagesInMemory.ps1                     | 2.2.27          | Lock pages in memory set to No One               | Local       |
| 2.2.30-ManageSecurityLog.ps1                     | 2.2.30          | Restrict manage auditing/security log to Admin   | Local       |
| 2.2.31-ModifyObjectLabel.ps1                     | 2.2.31          | Restrict modify object label to No One           | Local       |
| 2.2.32-ModifyFirmwareEnv.ps1                     | 2.2.32          | Restrict modify firmware env values to Admin     | Local       |
| 2.2.33-VolumeMaintenance.ps1                     | 2.2.33          | Restrict volume maintenance to Administrators    | Local       |
| 2.2.34-ProfileSingleProcess.ps1                  | 2.2.34          | Restrict profile single process to Admin         | Local       |
| 2.2.35-ProfileSystemPerformance.ps1              | 2.2.35          | Restrict system performance profile to Admin, WdiServiceHost | Local |

> **All scripts enforce administrator privileges, logging to `C:\CIS-Hardening-Logs`, and use `secedit` or `ntrights` where applicable.**

---

## 🧩 Notes

- ⚡ Scripts must be executed individually for targeted hardening.
- 🔗 Some settings (like password policies) should be managed centrally using **Domain GPOs** or **PSOs**.
- 💡 Recommended to run scripts on a **test system first** before applying in production.

---

## 📚 References

- [CIS Benchmark: Windows 10 Enterprise v3.0.0](https://www.cisecurity.org/benchmark/microsoft_windows_10_enterprise)
- [Microsoft Security Policy Settings](https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/)
- [Secedit Tool Usage](https://learn.microsoft.com/en-us/windows/security/threat-protection/secedit/secedit-overview)

---

**Author:** Christen Reinhart  
**Project:** Cybersecurity-Lab-Class  
**Path:** Endpoint-Security/Windows-10_2/Documentation




