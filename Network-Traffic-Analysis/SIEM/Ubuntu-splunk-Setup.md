# 🧠 Ubuntu Desktop VM + Splunk Setup (Localhost Deployment)

This guide walks you through setting up an Ubuntu Desktop VM, installing Splunk Enterprise, configuring local web GUI access, and deploying Splunk Universal Forwarder agents to endpoints for centralized log collection.

---

## 📥 Prerequisites

- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Download Ubuntu Desktop ISO](https://ubuntu.com/download/desktop)
- [Download Splunk Enterprise (Linux .deb)](https://www.splunk.com/en_us/download/splunk-enterprise.html)

---

## 🖥️ Part 1: Create Ubuntu VM in VirtualBox

### 1. VirtualBox Settings

- Name: `Ubuntu-Splunk`
- Type: Linux
- Version: Ubuntu (64-bit)
- RAM: **4096 MB** minimum
- CPUs: 2
- Disk: 40+ GB (VDI, Dynamically Allocated)

### 2. Mount ISO and Install Ubuntu

- Attach the Ubuntu ISO under **Settings > Storage > Controller: IDE**.
- Follow installation steps (username/password setup, default options).
- Once complete, remove the ISO and reboot.

---

## ⚙️ Part 2: Install Splunk Enterprise

1. Move the downloaded `.deb` file to your Ubuntu VM.

```bash
cd ~/Downloads
sudo dpkg -i splunk*.deb
```

2. Start and enable Splunk:

```bash
sudo /opt/splunk/bin/splunk start --accept-license
```

3. Create an admin username and password during the initial prompt.

---

## 🌐 Part 3: Access Splunk Web GUI (Localhost)

Once Splunk is running, open your Ubuntu browser and go to:

```
http://127.0.0.1:8000
```

- Log in with the credentials you created.

---

## 📦 Part 4: Install Splunk Universal Forwarder on Endpoints

1. [Download Splunk Universal Forwarder](https://www.splunk.com/en_us/download/universal-forwarder.html) (choose OS appropriately).

2. On each endpoint (Windows/Linux), install the Forwarder.

### Example (Ubuntu endpoint):

```bash
sudo dpkg -i splunkforwarder-<version>.deb
sudo /opt/splunkforwarder/bin/splunk start --accept-license
```

3. Configure forwarding to your Splunk server (use IP or DNS name):

```bash
sudo /opt/splunkforwarder/bin/splunk add forward-server 192.168.1.10:9997
```

4. Add inputs (e.g., monitor `/var/log`):

```bash
sudo /opt/splunkforwarder/bin/splunk add monitor /var/log
```

5. Enable Splunk Forwarder to start on boot:

```bash
sudo /opt/splunkforwarder/bin/splunk enable boot-start
```

---

## 📊 Part 5: Set Up Data Inputs in Splunk GUI

1. Log in at `http://127.0.0.1:8000`
2. Go to **Settings > Data Inputs**
3. Add TCP input for port `9997`
4. Review forwarded logs under **Search & Reporting**

---

## 📋 Summary

| Step | Task |
|------|------|
| 1    | Set up Ubuntu Desktop VM |
| 2    | Install Splunk Enterprise |
| 3    | Access via `127.0.0.1:8000` |
| 4    | Install Forwarders on endpoints |
| 5    | Configure Data Inputs |

---

## 🔐 Notes

- Ensure firewall on Ubuntu allows port 9997 (TCP).
- Use static IP for Splunk server if using on a local network.
- Forwarder installation requires admin/sudo privileges.

---

## 📚 References

- [Splunk Enterprise Documentation](https://docs.splunk.com/Documentation/Splunk)
- [Splunk Universal Forwarder Docs](https://docs.splunk.com/Documentation/Forwarder)
- [Ubuntu Desktop Download](https://ubuntu.com/download/desktop)
- [VirtualBox Manual](https://www.virtualbox.org/manual/UserManual.html)

