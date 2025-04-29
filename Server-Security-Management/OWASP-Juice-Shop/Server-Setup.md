# 🖥️ OWASP Juice Shop Lab Setup Guide (Ubuntu Server + VirtualBox)

## Part 1: 📥 Download Ubuntu Server ISO

1. Go to [Ubuntu Server Download](https://releases.ubuntu.com/24.04/).
2. Download the ISO file:
   - **Example file name**: `ubuntu-24.04.1-live-server-amd64.iso`
3. Save it somewhere easily accessible (e.g., `~/Downloads`).

---

## Part 2: 🛠️ Create Ubuntu Server VM in VirtualBox

1. **Open VirtualBox** and click **New**.
2. Set the following:
   - **Name**: `Ubuntu-JuiceShop`
   - **Type**: Linux
   - **Version**: Ubuntu (64-bit)
3. **Memory (RAM)**: Allocate at least **2048 MB (2 GB)**.
4. **Hard Disk**:
   - Create a virtual hard disk now.
   - Size: **20 GB** (minimum), dynamically allocated.
5. **Mount the ISO**:
   - Settings → Storage → Attach your Ubuntu Server ISO.
6. **Network**:
   - Settings → Network → Adapter 1:
     - **Attached to**: *Bridged Adapter* (recommended) or NAT with port forwarding.

---

## Part 3: 🧹 Install Ubuntu Server

1. Boot from the ISO.
2. Select:
   - **Install Ubuntu Server**
   - Choose your **language** and **keyboard layout**.
3. **Network**:
   - Make sure DHCP assigns an IP automatically (or configure it manually).
4. **Storage**:
   - Use the entire disk.
5. **User creation**:
   - Create a username and password (example: `juice / Juice1234`).
6. **Finish installation** and **reboot**.
7. **Eject ISO** after reboot.

---

## Part 4: ⚡ Prepare Ubuntu Server for Juice Shop

```bash
# Update system
sudo apt update && sudo apt upgrade -y
```bash
# Install Git
sudo apt install git -y
```bash
# Install Node.js and npm
sudo apt install nodejs npm -y

```bash
# Confirm installation versions
nodejs --version
npm --version
git --version

Part 5: 🍹 Install and Launch Juice Shop
Clone the Juice Shop repository
```bash
git clone https://github.com/juice-shop/juice-shop.git
cd juice-shop

Install dependencies
```bash
npm install --legacy-peer-deps
Note: If you encounter issues related to libxmljs, you might need to install or rebuild libxmljs2:
```bash
npm uninstall libxmljs
npm install libxmljs2 --legacy-peer-deps
If there are errors related to missing bindings (e.g., xmljs.node), make sure to rebuild the dependencies:
```bash
npm rebuild
Start the application
```bash
npm start
Expected output:

nginx
```bash
Server listening on port 3000
Part 6: 🌐 Access Juice Shop
Open a web browser and navigate to:

```bash
http://<Ubuntu_VM_IP>:3000

Part 7: 🧹 (Optional) Run Juice Shop in the Background
Install screen

sudo apt install screen -y
Create a screen session
```bash
screen -S juice
Start Juice Shop
```bash
npm start

Detach screen (Ctrl + A, then D)
To reattach screen later

screen -r juice

📋 Summary

Step	Action
1	Download Ubuntu Server ISO
2	Create a VM in VirtualBox
3	Install Ubuntu Server
4	Install Git, Node.js, and npm
5	Clone and start Juice Shop
6	Access Juice Shop via browser

📢 Notes
Default port: 3000

Allow port through firewall (if UFW is active):
```bash
sudo ufw allow 3000/tcp

🚀 Lab Ready
Congratulations! You now have OWASP Juice Shop deployed inside your Cybersecurity Lab environment, ready for testing and learning.


