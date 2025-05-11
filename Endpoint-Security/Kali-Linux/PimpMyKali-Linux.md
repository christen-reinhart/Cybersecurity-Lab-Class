# 🚀 PimpMyKali (PMK) v2.0 – Kali Linux Setup Automation

**Release Date**: December 4, 2024  
**Author**: TCMS Staff  
**GitHub Repo**: [https://github.com/Dewalt-arch/pimpmykali](https://github.com/Dewalt-arch/pimpmykali)

---

## 🔧 What is PimpMyKali?

**PimpMyKali (PMK)** is a post-installation automation script for Kali Linux. It installs essential penetration testing tools, configures system settings, and simplifies setup and maintenance.

---

## 🆕 PMK v2.0 – What's New?

### 🎯 General Enhancements

- **Menu option verification** before execution
- **On-screen notification** for selected options
- Defaults to **python3 and pip for python3**
- Uses `apt-cache` for faster package lookup
- **Speedrun variable** for automated installs
  - `--auto`: enables root login
  - `--autonoroot`: skips root login
- **Exit status checks** on functions

---

## 🧪 New Features

- `--help` switch: View CLI switches like `--auto`, `--netexec`, `--plumhound`, etc.
- **waybackrust** installed via `--wayback`
- **PlumHound** installed to `/opt/PlumHound` and symlinked
- `--binfmt` sets up mount service for `/proc/sys/fs/binfmt_misc`

---

## 📦 New Functions

- `is_installed`, `is_installed_remove`, `is_installed_reinstall`
- `install_pip2`, `install_pip3`, `install_pipx`
- `install_pip2_modules`, `install_pip3_modules`
- `check_dmidecode`

---

## 🔁 Updated Functions

- `make_rootgreatagain`: invoked early if `--auto` used
- `nuke_impacket`: installs both old and new versions
- `fix_cme`: installs CrackMapExec from repo
- `fix_netexec`: installs from GitHub
- `fix_seclists`, `fix_smb`, `fix_gowitness`, `fix_pyftpdlib`
- `check_vm`, `fix_virtualbox`: install Guest Additions
- `install_golang` replaces `fix_golang`

---

## ��️ Deprecated and Replaced

- Removed deprecated menu items
- CLI switches replace many options
- `python_pip_curl` replaced with `install_pip2`
- `fix_pipxlrd`, `fix_python_requests` replaced with `install_pip2_modules`

---

## 🧩 Updated Menu

- **Option N**: New VM setup
- **Option 5**: Installs Impacket from Kali repo
- Removed `apt upgrade` from VM setup

---

## 📦 Course Setup Tools

- Practical Bug Bounty
- C# 101 for Hackers
- PEH WebLabs
- Hacking IoT
- Hacking API

---

## 🛠️ How to Install or Upgrade

```bash
# Remove existing folder (if needed)
rm -rf pimpmykali/

# Clone the repo
git clone https://github.com/Dewalt-arch/pimpmykali
cd pimpmykali

# Run the script
sudo ./pimpmykali.sh
```

### Optional CLI Switches:

```bash
sudo ./pimpmykali.sh --auto         # Auto install with root login
sudo ./pimpmykali.sh --autonoroot  # Auto install without root login
```

---

## 🧠 Feedback and Suggestions

Contribute or request features by opening an issue at:  
👉 [https://github.com/Dewalt-arch/pimpmykali/issues](https://github.com/Dewalt-arch/pimpmykali/issues)

---

## 🧩 About TCM Security

- Veteran-owned cybersecurity company based in Charlotte, NC
- Services: Penetration testing, red teaming, and compliance
- Education: Self-paced and instructor-led courses
- Certifications: Hands-on, practical cert exams

📞 (877) 771-8911  
📧 info@tcm-sec.com  
🌐 [https://tcm-sec.com](https://tcm-sec.com)

Follow: **Blog** | **LinkedIn** | **YouTube** | **Twitter** | **Facebook** | **Instagram**

---

**Maintained by: Christen Reinhart**  
**Summary based on: PMK v2.0 Release Notes – TCM Security Blog**


---

## 🧰 Tools Installed by PimpMyKali v2.0

PMK v2.0 installs and configures a wide range of security tools and dependencies used in penetration testing, red teaming, and network analysis. Below is a categorized breakdown of the tooling and associated command functions:

### 🔐 Password & Hash Cracking
- `hashcat`
- `hydra`
- `john`
- `cewl`
- `crunch`

### 📡 Network Enumeration & Scanning
- `nmap`
- `masscan`
- `netdiscover`
- `arp-scan`
- `tcpdump`
- `wireshark`
- `bettercap`

### 🎯 Exploitation & Post-Exploitation
- `metasploit-framework`
- `exploitdb`
- `crackmapexec` — via `fix_cme`
- `netexec` — via `fix_netexec`
- `impacket` — via `nuke_impacket`
- `smbclient`, `enum4linux`
- `linpeas`, `winpeas`, `pspy`

### 📁 File Transfer & Web Servers
- `apache2`, `nginx` (user customizable)
- `pyftpdlib` — via `fix_pyftpdlib`
- `webdav` utilities

### 🛠️ Active Directory & Kerberos Tooling
- `BloodHound`
- `PlumHound` — via `--plumhound`
- `Kerbrute`
- `Responder`
- `Impacket Toolkit` — includes `secretsdump.py`, `GetNPUsers.py`, etc.

### 🧰 Red Teaming Tools
- `Evil-WinRM`
- `socat`
- `chisel`
- `nishang`
- `PowerSploit`

### 🌐 Web & API Testing Tools
- `sqlmap`
- `ffuf`
- `gobuster`
- `dirsearch`
- `wfuzz`
- `nuclei`
- `nikto`

### 📄 Wordlists & OSINT
- `SecLists` — via `fix_seclists`
- `waybackrust` — via `--wayback`
- `theHarvester`
- `recon-ng`

### 🔧 Environment Utilities & Support
- `pip2`, `pip3`, `pipx` — via `install_pip2`, `install_pip3`, `install_pipx`
- `Go` — via `install_golang`
- `curl`, `git`, `jq`, `unzip`, `wget`
- `VirtualBox Guest Additions` — via `fix_virtualbox`
- `binfmt_misc` service — via `--binfmt`

To see all supported options, run:

```bash
sudo ./pimpmykali.sh --help
```

---

