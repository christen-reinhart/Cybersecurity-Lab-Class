# 🛡️ Windows Intrusion Discovery Cheat Sheet v3.0

By Ed Skoudis  
**SANS Institute – Pocket Reference Guide**  
[https://www.sans.org/tools/](https://www.sans.org/tools/)

---

## 🎯 Purpose

System Administrators are on the front lines of security. This cheat sheet provides quick steps for discovering signs of compromise or intrusion on Windows systems using built-in tools and free third-party utilities.

---

## 🧭 How to Use

Run these checks periodically (daily, weekly, or each login) to scan for signs of compromise. Use GUI tools or CLI commands where appropriate.

---

## 🔧 Unusual Processes and Services

- Look for processes run by SYSTEM, Administrator, or unknown users.
- GUI: `taskmgr.exe`, `services.msc`
- CLI:
  ```cmd
  tasklist
  tasklist /svc
  wmic process list full
  net start
  sc query
  ```

---

## 📁 Unusual Files and Registry Keys

- Check for abnormal disk usage:
  ```cmd
  dir c:  ```
- Registry keys to inspect:
  - `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
  - `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`
- Tools:
  - GUI: `regedit`
  - CLI: `reg query <reg key>`

---

## 🌐 Unusual Network Usage

- Look for suspicious connections:
  ```cmd
  netstat -na
  netstat -nao 5
  netstat -naob 5
  ```
- Check NetBIOS & SMB activity:
  ```cmd
  net view \127.0.0.1
  net session
  net use
  nbtstat -S
  ```
- Inspect firewall rules:
  ```cmd
  netsh advfirewall firewall show rule name=all
  ```

---

## ⏰ Unusual Scheduled Tasks

- GUI: Task Scheduler (`taskschd.msc`)
- CLI:
  ```cmd
  schtasks
  msconfig.exe (Startup tab)
  wmic startup list full
  ```

---

## 👤 Unusual Accounts

- Check for new/unknown Admin users:
  - GUI: `lusrmgr.msc` → Groups → Administrators
  - CLI:
    ```cmd
    net user
    net localgroup administrators
    ```

---

## 🪵 Unusual Log Entries

- Suspicious events to look for:
  - “Event log service was stopped.”
  - “Windows File Protection is not active.”
  - Failed logon attempts, locked accounts.
- GUI: `eventvwr.msc`

---

## ⚠️ Other Unusual Indicators

- Unusual CPU usage in Task Manager.
- Sudden system crashes or instability.

---

## 🔗 Additional Tools (Free)

### From Microsoft Sysinternals:
- [PsExec](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec)
- [Process Monitor](https://docs.microsoft.com/en-us/sysinternals/downloads/procmon)
- [Sysmon](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon)

### Others:
- [Process Hacker](https://processhacker.sourceforge.net/)
- [Darik’s Boot and Nuke](https://dban.org/)
- [CIS Benchmarks and Tools](https://www.cisecurity.org/)

---

**DO NOT PANIC!**  
If anomalous behavior is detected, report it immediately to your Incident Response team.

---

**Converted to Markdown by: Christen Reinhart**  
**Original Author: Ed Skoudis – SANS Institute**  
**Reference: Windows Intrusion Discovery Cheat Sheet v3.0**
