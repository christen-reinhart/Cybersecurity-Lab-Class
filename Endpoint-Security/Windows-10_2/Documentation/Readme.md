
# CIS Windows 10 Enterprise v3.0.0 - PowerShell Hardening Scripts

## Overview

This documentation supports the **PowerShell scripts provided in the `/Scripts` folder**, which automate key hardening steps as per **CIS Microsoft Windows 10 Enterprise Benchmark v3.0.0**.

These scripts implement **recommended settings for standalone systems** and can also serve as a reference for **enterprise environments with local policy configuration**.

## 📂 Scripts Directory

All scripts are located at:

```
Cybersecurity-Lab-Class/Endpoint-Security/Windows-10_2/Scripts
```

Each script is named to reflect its corresponding CIS Benchmark section for easy reference and modular execution.

## ✔ Script Execution Example

1. Open **PowerShell as Administrator**.
2. Navigate to the script directory:
   ```powershell
   cd "C:\Path\To\Scripts"
   ```
3. Run the desired script:
   ```powershell
   .\1.1.1-EnforcePasswordHistory.ps1
   ```

## 📝 Logging and Auditability

- All scripts **start a transcript** automatically and log output to:
  ```
  C:\CIS-Hardening-Logs\
  ```
- **Admin check** is enforced at the start of every script.
- **secedit** is used where applicable for secure application of settings.
- Log files are timestamped and named per CIS control (example: `1.1.1-EnforcePasswordHistory.log`).

## 🗂 Script Summary

(Summary table omitted for brevity — same as previously shown)

## ⚠ Important Notes

- Scripts target **local machine policies only**.
- In **Active Directory environments**, these settings must be applied via **GPO** at the **Domain Controllers level** for user accounts or using **Password Settings Objects (PSOs)**.
- Test scripts on **non-production systems** first.

## 📚 References

- [CIS Benchmark: Windows 10 Enterprise v3.0.0](https://www.cisecurity.org/benchmark/microsoft_windows_10_enterprise)
- [Microsoft Security Policy Settings](https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/)
- [Secedit Tool Usage](https://learn.microsoft.com/en-us/windows/security/threat-protection/secedit/secedit-overview)

---

**Author:** Christen Reinhart  
**Project:** Cybersecurity-Lab-Class  
**Path:** Endpoint-Security/Windows-10_2


