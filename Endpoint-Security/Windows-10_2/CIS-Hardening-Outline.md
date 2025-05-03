# 🛡️ Windows-10_2: CIS Hardening Project (CIS Controls v8.1)

This project focuses on hardening a Windows 10 endpoint using the **Center for Internet Security (CIS) Controls v8.1**. The purpose is to increase the system’s resilience against attacks while aligning with best practices for endpoint security.

---

## 📌 Project Goal

To implement and document selected **CIS Critical Security Controls v8.1** on a Windows 10 virtual machine (`Windows-10_2`) for learning and portfolio purposes.

---

## 🧰 Prerequisites

- Windows 10 Virtual Machine (VM)
- Administrative privileges on the VM
- Access to CIS Benchmark documents (free registration at [cisecurity.org](https://www.cisecurity.org))
- PowerShell (Admin mode)
- Group Policy Editor (gpedit.msc)
- Git for version tracking

---

## 🗂️ Folder Structure

```
Endpoint-Security/
├── Windows-10_2/
│   ├── CIS-Controls-v8.1/
│   │   ├── CIS-Project-Outline.md
│   │   └── Hardened-System-Checklist.md
```

---

## 🛠️ CIS Controls to Implement (Phase 1)

| Control No. | Description                                 | Status       |
|-------------|---------------------------------------------|--------------|
| 4           | Secure Configuration of Enterprise Assets   | ✅ Completed |
| 5           | Account Management                          | 🟡 In Progress |
| 6           | Access Control Management                   | 🟡 In Progress |
| 8           | Audit Log Management                        | 🔲 Not Started |
| 10          | Malware Defenses                            | 🔲 Not Started |

---

## 📋 Actions to Take

### 🔐 Secure Configuration
- Disable unnecessary services
- Enforce password complexity
- Set account lockout policies
- Configure local security policies via `secpol.msc`

### 🧑‍💼 Account Management
- Create standard user and admin accounts
- Disable default “Administrator” account

### 🛑 Access Control
- Remove unused local accounts
- Review and restrict NTFS permissions

### 📝 Logging
- Enable and configure Event Log retention
- Enable auditing of login attempts and system events

### 🛡️ Malware Defense
- Install and configure Microsoft Defender
- Set real-time protection policies
- Block PUA (Potentially Unwanted Applications)

---

## 🧪 Validation

Use the following to verify your hardening:

```powershell
# Check password policy
Get-LocalUser | Select-Object Name, Enabled

# Review audit settings
auditpol /get /category:*

# Check Defender status
Get-MpPreference
```

---

## 🧾 References

- [CIS Controls v8.1](https://www.cisecurity.org/controls/v8)
- [CIS Windows 10 Benchmark](https://www.cisecurity.org/benchmark/microsoft_windows_desktop)
- [Microsoft Security Compliance Toolkit](https://learn.microsoft.com/en-us/windows/security/threat-protection/windows-security-baselines)
- [SANS CIS v8 Summary](https://www.sans.org/blog/cis-controls-v8/)

---

## ✅ Status: In Progress

> This system will serve as a hardened endpoint and blueprint for future deployments and documentation in your cybersecurity lab.

