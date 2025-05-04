# 🛡️ Velociraptor + CAPE Integration for DFIR

## 📘 Project Overview

This project demonstrates how to integrate Velociraptor and CAPE (Capture and Analysis Platform for Executables) in a digital forensics and incident response (DFIR) workflow. Velociraptor will be used to collect forensic artifacts from endpoints, and CAPE will be used to analyze suspected malicious binaries.

---

## 🏗️ Lab Environment

| Component        | Details                                       |
|------------------|-----------------------------------------------|
| Host OS          | Windows 10 / Ubuntu 22.04                     |
| Analysis Server  | CAPE (Docker or native install)               |
| Collection Agent | Velociraptor                                  |
| Network Setup    | Host-only or NAT with IP visibility            |
| Other Tools      | Burp Suite, Wireshark, FoxyProxy, Zeek, etc. |

---

## ⚙️ Step-by-Step Setup

### 🔸 1. Install Velociraptor
Follow official [Velociraptor documentation](https://docs.velociraptor.app/) to deploy a standalone server and client.

```bash
wget https://github.com/Velocidex/velociraptor/releases/latest/download/velociraptor-vX.X.X-linux-amd64
chmod +x velociraptor-vX.X.X-linux-amd64
sudo ./velociraptor-vX.X.X-linux-amd64 gui
```

Configure:
- Collector Agent (Windows binary) on Windows-10_2
- Standalone Velociraptor server on Ubuntu

### 🔸 2. Deploy CAPE Sandbox
Use Docker Compose or a VM image. Official repo: [CAPE Sandbox GitHub](https://github.com/ctxis/CAPE)

#### Docker Example:
```bash
git clone https://github.com/ctxis/CAPE.git
cd CAPE
sudo ./install.sh
```

### 🔸 3. Collect Suspicious Artifact with Velociraptor
- Use Velociraptor GUI to create a hunt
- Target suspicious executables (`.exe`, `.dll`)
- Export samples to shared folder

### 🔸 4. Submit Artifact to CAPE
- Upload manually or automate using API
- Example script using Python to POST files to CAPE

---

## 📁 Directory Structure (GitHub)

```
Cybersecurity-Lab-Class/
└── Threat-Intelligence-Forensics/
    └── Velociraptor-CAPE-Lab/
        ├── README.md
        ├── Screenshots/
        ├── CAPE-Scripts/
        ├── Velociraptor-Configs/
        └── Sample-Reports/
```

---

## 📸 Screenshots & Evidence

- Velociraptor hunt config screenshot
- CAPE task submission and analysis result
- Extracted IoCs

---

## ✅ Learning Objectives

- Understand endpoint forensic collection with Velociraptor
- Perform malware analysis using CAPE
- Automate submission of artifacts
- Document forensic chain-of-custody

---

## 🔗 References

- [Velociraptor Documentation](https://docs.velociraptor.app/)
- [CAPE GitHub Repository](https://github.com/ctxis/CAPE)
- [MITRE ATT&CK](https://attack.mitre.org/)
- [DFIR Report](https://thedfirreport.com/)

---

_© 2025 Christen Reinhart — Cybersecurity-Lab-Class_
