# Installing Kali Linux VM in VirtualBox

This guide explains how to install and configure Kali Linux in VirtualBox for your Cybersecurity Lab.

## Prerequisites
- Oracle VirtualBox installed: [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- Kali Linux ISO downloaded: [Download Kali Linux](https://www.kali.org/get-kali/)

## Step-by-Step Installation

### 1. Download Kali Linux ISO
- Go to the official [Kali Downloads Page](https://www.kali.org/get-kali/).
- Download the latest **Kali Linux Installer (ISO)**.
- Verify the SHA256 checksum if you want to validate the ISO integrity.

### 2. Create a New Virtual Machine
- Open **VirtualBox** and click **New**.
- Name: `Kali-Linux`
- Type: `Linux`
- Version: `Debian (64-bit)`
- Memory: **4 GB RAM** (4096 MB) minimum recommended
- Hard Disk: Create a virtual hard disk now
  - File Type: VDI (VirtualBox Disk Image)
  - Storage: Dynamically allocated
  - Size: At least **50 GB**

### 3. Configure VM Settings
- Select your new VM > **Settings**:
  - **System > Processor**: Set to at least **2 CPUs**.
  - **Display > Video Memory**: Increase to **128 MB**.
  - **Storage**:
    - Click the empty optical drive.
    - Click the **CD icon** and **Choose a disk file**.
    - Select your **Kali Linux ISO** file.
  - **Network**:
    - Attached to: **Bridged Adapter** or **NAT** depending on your setup.

### 4. Install Kali Linux
- Start the VM.
- Select **Graphical Install**.
- Language: English
- Location: United States (or your region)
- Keyboard: American English
- Hostname: `kali`
- Domain name: Leave empty (unless you have one).
- Set up a username and password for the system.
- Disk Partitioning:
  - Use entire disk
  - Choose default partitions
- Continue with installation until complete.
- **When prompted to install GRUB bootloader**, select **Yes** and choose your main drive (`/dev/sda`).

### 5. Initial Configuration
- After installation completes, log in.
- Open Terminal and update the system:

- bash
sudo apt update && sudo apt full-upgrade -y

## Install VirtualBox Guest Additions (optional but recommended for better integration):

sudo apt install -y virtualbox-guest-x11
sudo reboot

## 6. Take a VirtualBox Snapshot
#### 1. Once everything is configured and updated:

#### 2. Right-click your Kali VM > Take Snapshot.

#### 3. Name it something like Fresh Kali Install.

## Final Notes

#### 1. Kali Linux is intended for penetration testing, digital forensics, and cybersecurity training.

#### 2. Always use Kali Linux responsibly and legally.

#### 3. Never use Kali Linux tools on unauthorized systems.


