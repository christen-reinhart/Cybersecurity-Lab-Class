# Parrot Security OS Installation in VirtualBox

## Overview
Parrot Security OS is a lightweight, Debian-based Linux distribution built for penetration testing, forensics, and privacy.  
This guide explains how to properly download, install, and set up Parrot Security OS in a VirtualBox virtual machine.

Official Website: [ParrotSec](https://parrotsec.org/)

## Step 1: Download Parrot Security ISO
- Visit the official download page: [ParrotSec Downloads](https://parrotsec.org/download/)
- Download the **Parrot Security Edition** ISO for 64-bit systems (example: `Parrot-security-6.2_amd64.iso`).

## Step 2: Create a New Virtual Machine in VirtualBox
- Open VirtualBox
- Click **New**
- Name: `Parrot-Security`
- Type: `Linux`
- Version: `Debian (64-bit)`
- Memory Size: `4096 MB` minimum (`8192 MB` recommended)
- Hard Disk: Create a virtual hard disk now
- Disk File Type: `VDI (VirtualBox Disk Image)`
- Storage: `Dynamically allocated`
- Size: `60 GB` minimum (`80-100 GB` recommended)

## Step 3: Attach the ISO and Start Installation
- Select your Parrot VM → Click **Settings**.
- Go to **Storage**.
- Under **Controller: IDE**, click the empty disk icon.
- Click **Choose a disk file...** and select your downloaded Parrot ISO.
- Click **OK**.
- Start the VM.

## Step 4: Install Parrot Security (Full Install, Not Live Boot)
- At the boot menu, select **Install** or **Graphical Install**.
- Follow the installation wizard:
  - Set Language, Region, Keyboard Layout.
  - Hostname: `parrot`
  - Create user account (e.g., `user` / `Password1234`).
  - Set root password if needed (or leave blank to use sudo).
- Partitioning:
  - Guided - use entire disk.
  - No swap partition is necessary unless preferred.

After installation completes:
- **Shutdown** the VM.
- **Detach** the ISO from the Virtual Drive before restarting.

## Step 5: Update Parrot OS
After logging into the VM, update the system:

```bash
sudo apt update
sudo apt full-upgrade -y
sudo reboot

Step 6: Install VirtualBox Guest Additions (Optional)
To enable better screen resolution and clipboard sharing:

sudo apt install virtualbox-guest-x11 -y
sudo reboot

If VirtualBox Guest Additions installation is missing, you can mount the VirtualBox Guest Additions ISO manually from VirtualBox's Devices menu.

Final Notes
After updates, it is recommended to take a VirtualBox Snapshot for backup.

Parrot Security is now ready for use in penetration testing, digital forensics, threat hunting, or cybersecurity detection engineering labs.

## Additional Resources
- [ParrotSec Official Documentation](https://docs.parrotsec.org/)
- [VirtualBox User Manual](https://www.virtualbox.org/manual/UserManual.html)


