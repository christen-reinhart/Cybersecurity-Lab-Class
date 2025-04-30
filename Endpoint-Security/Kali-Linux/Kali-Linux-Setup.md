
# 🛡️ Kali Linux Installation & Lab Setup Guide (VirtualBox)
## 📥 Part 1: Download Required Files

- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Download Kali Linux ISO](https://www.kali.org/get-kali/#kali-platforms)
  - Choose the **Installer** ISO for VirtualBox (e.g., `kali-linux-2024.1-installer-amd64.iso`)

---

## 🛠️ Part 2: Create Kali VM in VirtualBox

1. **Open VirtualBox** → Click **New**
2. Set:
   - **Name**: `Kali-Linux`
   - **Type**: Linux
   - **Version**: Debian (64-bit)
3. Set:
   - **Memory**: `4096 MB` (Minimum)
   - **Processors**: 2 (Minimum)
   - **Video Memory**: 128 MB
4. **Hard Disk**:
   - Create new VDI disk
   - Dynamically allocated
   - Size: 40–60 GB
5. **Mount ISO**:
   - Settings → Storage → Controller: IDE → Choose your Kali ISO
6. **Network**:
   - Adapter 1: Attached to **Bridged Adapter** (preferred for lab use)

---

## 💿 Part 3: Install Kali Linux

1. Start VM and select **Graphical Install**
2. Follow on-screen instructions:
   - Language: English
   - Keyboard: US
   - Disk Partition: Use entire disk (automatic partitioning)
   - User Account: Set non-root user and password
3. Complete installation and reboot
4. Remove ISO when prompted

---

## 🔄 Part 4: Update Kali Linux

After first boot, open terminal and run:

```bash
sudo apt update && sudo apt full-upgrade -y
```

(Optional but recommended):

```bash
sudo apt install -y kali-linux-default
```

This ensures full toolset is installed.

---

## ⚙️ Part 5: Install VirtualBox Guest Additions (Optional)

1. Insert Guest Additions CD (Devices > Insert Guest Additions CD Image)
2. Run in terminal:

```bash
sudo apt install -y build-essential dkms linux-headers-$(uname -r)
sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom
cd /media/cdrom
sudo ./VBoxLinuxAdditions.run
sudo reboot
```

---

## 🧰 Part 6: Essential Security Tools for Testing

These tools are often pre-installed on Kali, but you can reinstall/update as needed:

```bash
sudo apt install -y metasploit-framework burpsuite zaproxy nmap wireshark hydra sqlmap john nikto net-tools gobuster seclists hashcat bettercap dnsenum smbclient enum4linux remmina screenfetch
```

Verify installation:

```bash
msfconsole --version
nmap --version
```

---

## 🧪 Optional: Take a Snapshot

After completing your installation and tool setup, take a VirtualBox snapshot:

- Right-click VM → **Take Snapshot**
- Name it something like: `Fresh Kali Install with Tools`

---

## 📚 References

- [Kali Linux Documentation](https://www.kali.org/docs/)
- [Kali Downloads](https://www.kali.org/get-kali/)
- [Metasploit Docs](https://docs.metasploit.com/)
- [VirtualBox Manual](https://www.virtualbox.org/manual/UserManual.html)
- [OWASP ZAP](https://www.zaproxy.org/)
- [Burp Suite Community Edition](https://portswigger.net/burp/communitydownload)

---

## ✅ Summary

| Step | Action                          |
|------|---------------------------------|
| 1    | Download Kali ISO & VirtualBox  |
| 2    | Create and configure VM         |
| 3    | Install Kali Linux              |
| 4    | Update and upgrade system       |
| 5    | Install Guest Additions         |
| 6    | Install essential tools         |
| 7    | Take VirtualBox Snapshot        |

---

## 🚀 Lab Ready

Kali Linux is now installed and configured with core tools for penetration testing, network scanning, web vulnerability analysis, password cracking, and more.
