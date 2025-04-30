# Installing Ubuntu Server with Suricata in VirtualBox

This guide explains how to install and configure **Ubuntu Server** in **VirtualBox**, and then install and configure **Suricata**, an open-source network IDS/IPS (Intrusion Detection System/Intrusion Prevention System).

## Prerequisites
- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Download Ubuntu Server ISO](https://ubuntu.com/download/server)

## Step-by-Step Installation

### 1. Download Ubuntu Server ISO
- [Visit the Ubuntu Download page](https://ubuntu.com/download/server)
- Download the **Ubuntu Server ISO**.
- (Optional) Verify the checksum for ISO integrity.

### 2. Create a New Virtual Machine
- Open **VirtualBox** and click **New**.
- Name: `Ubuntu-Server`
- Type: `Linux`
- Version: `Ubuntu (64-bit)`
- Memory Size: **2048 MB** (2 GB RAM minimum recommended)
- Hard Disk:
  - Create a virtual hard disk now.
  - VDI (VirtualBox Disk Image).
  - Dynamically allocated.
  - Size: **20 GB** minimum.

### 3. Configure VM Settings
- Select your new VM and go to **Settings**:
  - **System > Processor**: Set **2 CPUs** minimum.
  - **Display > Screen**: Set **128 MB** Video Memory.
  - **Storage**:
    - Click the empty optical drive.
    - Click the **CD icon** and select **Choose a Disk File**.
    - Select your **Ubuntu Server ISO**.
  - **Network**:
    - Adapter 1: Attached to **Bridged Adapter** or **NAT**.

### 4. Install Ubuntu Server
- Start the VM.
- Select **Install Ubuntu Server**.
- Follow the installer prompts:
  - Language: English.
  - Installation Destination:
    - Select your virtual disk.
    - Use **automatic partitioning** (default is fine for labs).
  - User Settings:
    - Create a root password.
    - Create a regular user with administrator privileges.
  - Begin installation.
- After completion, reboot the VM and remove the installation ISO when prompted.

### 5. Install Suricata

```bash
sudo apt update -y
sudo apt install suricata -y
```

### 6. Verify Suricata Installation

Start Suricata:

```bash
sudo systemctl start suricata
```

Check if Suricata is running:

```bash
sudo systemctl status suricata
```

Check Suricata Version:

```bash
suricata --version
```

View logs to verify it's working:

```bash
sudo tail -f /var/log/suricata/suricata.log
```

### 7. Verify Suricata's Interface

```bash
sudo suricata -i eth0 --stats
```

### 8. Test Suricata with Sample Traffic (Optional)

```bash
sudo hping3 --syn -p 80 192.168.1.1
sudo tail -f /var/log/suricata/fast.log
```

### 9. Configure Suricata to Start on Boot

```bash
sudo systemctl enable suricata
```

### 10. Install VirtualBox Guest Additions (Optional)

Insert Guest Additions from VirtualBox menu:

```bash
sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom
cd /media/cdrom
sudo ./VBoxLinuxAdditions.run
```

Reboot:

```bash
sudo reboot
```

### 11. Take a VirtualBox Snapshot

Take a snapshot of your VM from VirtualBox menu and name it something like:

`Fresh Ubuntu Server with Suricata`

## Final Notes

Ubuntu Server is ideal for hosting Suricata as an IDS/IPS. Combine it with tools like Zeek, Splunk, or ELK for a complete network security lab.

Use this environment responsibly in isolated, controlled lab networks.

## Additional Resources
- [Suricata Official Documentation](https://docs.suricata.io/)
- [Ubuntu Server Documentation](https://ubuntu.com/server/docs)
- [VirtualBox User Manual](https://www.virtualbox.org/manual/UserManual.html)

## Example Maintenance Command

```bash
sudo apt update -y
sudo apt upgrade suricata -y
```
