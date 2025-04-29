Parrot Security OS Installation in VirtualBox
Overview
Parrot Security OS is a lightweight, Debian-based Linux distribution built for penetration testing, forensics, reverse engineering, and privacy.
This guide explains how to properly download, install, and set up Parrot Security in a VirtualBox virtual machine.

Official Website: ParrotSec

Step 1: Download Parrot Security ISO
Visit the official download page: ParrotSec Downloads

Download the Parrot Security Edition ISO for 64-bit systems (Parrot-security-<version>_amd64.iso).

Step 2: Create a New Virtual Machine in VirtualBox
Open VirtualBox

Click New

Name: Parrot-Security

Type: Linux

Version: Debian (64-bit)

Memory Size: 4096 MB (minimum), 8192 MB (recommended for performance)

Hard Disk: Create a virtual hard disk now

Disk File Type: VDI (VirtualBox Disk Image)

Storage: Dynamically allocated

Size: At least 60 GB (recommended 80–100 GB for labs)

Step 3: Attach the Parrot ISO and Start Installation
Select your Parrot VM > Click Settings

Go to Storage

Under Controller: IDE, click the empty disk icon

Click Choose a disk file... and select your downloaded Parrot ISO

Click OK

Start the VM

Step 4: Perform Full Installation (Not Live Boot)
At the boot menu, DO NOT select "Try Parrot".

Choose "Install" or "Graphical Install".

Follow the Debian Installer Wizard:

Language, Region, Keyboard Layout

Hostname: parrot

Set user account (example: user / Password1234)

Set root password (or leave blank if using sudo)

Disk Partitioning:

Guided - use entire disk

Erase and install (since it's a new VM)

No swap partition is necessary unless desired.

Finish installation and reboot.

⚡️ After reboot, make sure you eject the ISO from the Virtual Drive:

Go to Devices → Optical Drives → Uncheck the mounted ISO.

Step 5: Update the Parrot System
Once logged in:

sudo apt update
sudo apt full-upgrade -y
sudo reboot

✅ This brings your system fully up to date with the latest Parrot security patches and software.

Step 6: Optional - Install VirtualBox Guest Additions
To improve VM performance (clipboard sharing, screen resizing, etc.):

sudo apt install -y virtualbox-guest-x11
sudo reboot

If that package is missing, you may need to mount Guest Additions manually from VirtualBox menu.

Final Notes
After updates, it’s recommended to take a VirtualBox Snapshot for rollback safety.

Parrot is now ready for penetration testing, digital forensics, red teaming, or detection engineering labs.

Use tools like Burp Suite, Wireshark, Metasploit, Zeek, and others already pre-installed.

