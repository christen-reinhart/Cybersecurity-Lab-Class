# 🛡️ pfSense Installation Guide in VirtualBox

This guide walks you through setting up **pfSense**, an open-source firewall and router software distribution based on FreeBSD, inside a VirtualBox virtual machine for your Cybersecurity Lab.

---

## 📥 Prerequisites

- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Download pfSense ISO](https://www.pfsense.org/download/)

---

## ⚙️ Part 1: Download pfSense ISO

1. Visit the official [pfSense Download Page](https://www.pfsense.org/download/).
2. Choose:
   - **Architecture**: AMD64 (64-bit)
   - **Installer**: CD Image (ISO) Installer
   - **Console**: VGA
   - **Mirror**: Select the closest mirror
3. Download the `.iso` file.

---

## 💻 Part 2: Create pfSense VM in VirtualBox

1. **Open VirtualBox** and click **New**.
2. Set the following:
   - **Name**: `pfSense`
   - **Type**: BSD
   - **Version**: FreeBSD (64-bit)
3. **Memory (RAM)**: Allocate at least **1024 MB**.
4. **Hard Disk**:
   - Create a virtual hard disk now.
   - VDI, dynamically allocated.
   - Size: **20 GB**

---

## 🛠️ Part 3: Configure pfSense VM

1. Go to **Settings > System**:
   - Uncheck Floppy in Boot Order
   - Set Chipset to ICH9 (optional for better hardware support)
2. Go to **Settings > Storage**:
   - Under Controller: IDE, click the empty CD icon
   - Select your downloaded pfSense ISO
3. Go to **Settings > Network**:
   - Adapter 1: Attached to **Bridged Adapter** (for LAN access)
   - Adapter 2: Attached to **NAT** (for WAN access)

---

## 🔧 Part 4: Install pfSense

1. Start the VM and boot from the ISO.
2. Follow the on-screen instructions:
   - Accept keymap and boot loader settings
   - Select **Install pfSense**
   - Choose default kernel
   - Use the entire disk for auto-partitioning
3. Reboot and remove the ISO.

---

## 🌐 Part 5: Configure Networking in pfSense

1. After reboot:
   - Assign WAN and LAN interfaces when prompted:
     - `em0` or `vtnet0`: WAN
     - `em1` or `vtnet1`: LAN
2. pfSense will assign:
   - LAN IP (usually 192.168.1.1)
   - WAN IP via DHCP (NAT)

---

## 🌍 Part 6: Access pfSense Web GUI

1. From another VM (e.g., Kali, Windows):
   - Set its network adapter to **Internal Network** or **Bridged**, same as pfSense LAN
2. Open a browser and go to:

```
https://192.168.1.1
```

3. Login:
   - Username: `admin`
   - Password: `pfsense`

4. Complete the setup wizard.

---

## 📦 Optional Tools and Packages

Within pfSense, go to **System > Package Manager** and install:

- `pfBlockerNG`: IP/domain blocking
- `Snort`: IDS/IPS engine
- `Suricata`: Alternative IDS/IPS
- `Squid`: Proxy caching
- `Darkstat` or `BandwidthD`: Traffic analysis

---

## 💾 Snapshot Recommendation

Once setup is complete:

- In VirtualBox, right-click your `pfSense` VM
- Select **Take Snapshot**
- Name it something like `Clean pfSense Install`

---

## 📚 References

- [pfSense Official Website](https://www.pfsense.org/)
- [pfSense Documentation](https://docs.netgate.com/pfsense/en/latest/)
- [VirtualBox User Manual](https://www.virtualbox.org/manual/UserManual.html)

---

## ✅ Lab Ready

You now have pfSense installed in VirtualBox as a powerful firewall/router ready for use in your home or cybersecurity lab environments.

