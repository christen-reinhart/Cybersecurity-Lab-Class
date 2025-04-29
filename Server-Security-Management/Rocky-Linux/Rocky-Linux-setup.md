# Installing Rocky Linux VM in VirtualBox

This guide explains how to install and configure Rocky Linux in VirtualBox for your Cybersecurity Lab.

## Prerequisites
[Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)  
[Download Rocky Linux ISO](https://rockylinux.org/download/)

## Step-by-Step Installation

### 1. Download Rocky Linux ISO
[Visit the Rocky Linux Download page](https://rockylinux.org/download/)

- Download the **DVD ISO** (not minimal) for a full installation environment.
- (Optional) Verify the checksum for ISO integrity.

### 2. Create a New Virtual Machine
- Open **VirtualBox** and click **New**.
- Name: `Rocky-Linux`
- Type: `Linux`
- Version: `Red Hat (64-bit)`
- Memory Size: **4096 MB** (4 GB RAM minimum recommended)
- Hard Disk:
  - Create a virtual hard disk now.
  - VDI (VirtualBox Disk Image).
  - Dynamically allocated.
  - Size: **50 GB** minimum.

### 3. Configure VM Settings
- Select your new VM and go to **Settings**:
  - **System > Processor**: Set **2 CPUs** minimum.
  - **Display > Screen**: Set **128 MB** Video Memory.
  - **Storage**:
    - Click the empty optical drive.
    - Click the **CD icon** and select **Choose a Disk File**.
    - Select your Rocky Linux ISO.
  - **Network**:
    - Adapter 1: Attached to **Bridged Adapter** or **NAT**.

### 4. Install Rocky Linux
- Start the VM.
- Select **Install Rocky Linux**.
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

### 5. Perform System Update
After installation and reboot:
- Log into Rocky Linux.
- Open Terminal and run:

sudo dnf update -y

(Optional but recommended):

sudo dnf install epel-release -y
sudo dnf groupinstall "Development Tools" -y

### 6. Install Guest Additions (Optional)

#### Insert the VirtualBox Guest Additions CD:

#### In the running VM window, click Devices > Insert Guest Additions CD Image.

#### Mount and install manually if prompted:

sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom
cd /media/cdrom
sudo ./VBoxLinuxAdditions.run

Reboot after installation:

sudo reboot
