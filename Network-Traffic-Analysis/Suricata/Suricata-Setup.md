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
Once Ubuntu Server is installed and you’re logged in, open the terminal and run the following commands to install **Suricata**:

```bash
sudo apt update -y
sudo apt install suricata -y
6. Verify Suricata Installation
Start Suricata
bash
Copy
Edit
sudo systemctl start suricata
To check if Suricata is running:

bash
Copy
Edit
sudo systemctl status suricata
You should see something like:

ruby
Copy
Edit
● suricata.service - Suricata IDS/IPS
   Loaded: loaded (/lib/systemd/system/suricata.service; enabled; vendor preset: enabled)
   Active: active (running) since Mon XXXX-XX-XX XX:XX:XX UTC; 1h 30min ago
   ...
Check Suricata Version
bash
Copy
Edit
suricata --version
Expected output:

scss
Copy
Edit
Suricata 6.x.x (Build XXXX)
Verify Suricata is Working
You can check Suricata's logs to verify it is functioning properly:

bash
Copy
Edit
sudo tail -f /var/log/suricata/suricata.log
This will show live logs as Suricata processes network traffic.

7. Verify Suricata's Interface
You can also verify Suricata by checking the interface status:

bash
Copy
Edit
sudo suricata -i eth0 --stats
This will display statistics on the network interface eth0 and Suricata's current operations.

8. Test Suricata with Sample Traffic (Optional)
(Optional but recommended) To test Suricata's IDS/IPS capabilities, generate some sample traffic (using tools like hping3 or Scapy) and check if Suricata logs the events:

Example command to simulate an attack:

bash
Copy
Edit
sudo hping3 --syn -p 80 192.168.1.1
You can then check Suricata’s logs to see if it has detected the traffic:

bash
Copy
Edit
sudo tail -f /var/log/suricata/fast.log
9. Configure Suricata to Start on Boot
bash
Copy
Edit
sudo systemctl enable suricata
10. Install VirtualBox Guest Additions (Optional)
Insert the VirtualBox Guest Additions CD:

In the running VM window, click Devices > Insert Guest Additions CD Image.

Mount and install manually:

bash
Copy
Edit
sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom
cd /media/cdrom
sudo ./VBoxLinuxAdditions.run
Reboot after installation:

bash
Copy
Edit
sudo reboot
11. Take a VirtualBox Snapshot
After completing all setup steps:

In VirtualBox, right-click your Ubuntu Server VM > Take Snapshot.

Name it something like Fresh Ubuntu Server with Suricata.

Final Notes
Ubuntu Server is a powerful and flexible operating system suitable for hosting Suricata as an IDS/IPS for network security analysis. Suricata can be used in combination with other tools like Zeek, SIEM solutions, and even in active defense scenarios.

Suricata provides robust detection capabilities for network security and is compatible with a wide range of other cybersecurity tools.

Use this setup responsibly in controlled lab environments to improve security analysis and detection skills.

Additional Resources
Suricata Official Documentation

Ubuntu Server Documentation

VirtualBox User Manual

Example Maintenance Command

To keep your Suricata installation up-to-date, regularly run:

bash
Copy
Edit
sudo apt update -y
sudo apt upgrade suricata -y