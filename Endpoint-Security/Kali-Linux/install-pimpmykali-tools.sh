#!/bin/bash

# PimpMyKali Individual Tool Installer
# Author: Christen Reinhart
# Usage: Run this script with sudo privileges

set -e

echo "[*] Updating system..."
apt update -y && apt upgrade -y

echo "[*] Installing password and hash cracking tools..."
apt install -y hashcat hydra john cewl crunch

echo "[*] Installing network enumeration and scanning tools..."
apt install -y nmap masscan netdiscover arp-scan tcpdump wireshark bettercap

echo "[*] Installing exploitation and post-exploitation tools..."
apt install -y metasploit-framework exploitdb smbclient
git clone https://github.com/ropnop/impacket /opt/impacket && cd /opt/impacket && pip3 install .
apt install -y crackmapexec
git clone https://github.com/Pennyw0rth/NetExec /opt/netexec && ln -s /opt/netexec/netexec.py /usr/local/bin/netexec

echo "[*] Installing file transfer and web server tools..."
apt install -y apache2 nginx
pip3 install pyftpdlib

echo "[*] Installing Active Directory and Kerberos tooling..."
apt install -y bloodhound
git clone https://github.com/PlumHound/PlumHound /opt/PlumHound
ln -s /opt/PlumHound/PlumHound.py /usr/local/bin/PlumHound.py
ln -s /opt/PlumHound/plumhound /usr/local/bin/plumhound
apt install -y responder kerbrute

echo "[*] Installing red team tools..."
apt install -y socat
git clone https://github.com/jpillora/chisel /opt/chisel
wget -O /usr/local/bin/evil-winrm https://github.com/Hackplayers/evil-winrm/releases/latest/download/evil-winrm.rb
chmod +x /usr/local/bin/evil-winrm

echo "[*] Installing web and API testing tools..."
apt install -y sqlmap ffuf gobuster dirsearch wfuzz nuclei nikto

echo "[*] Installing wordlists and OSINT tools..."
apt install -y seclists
wget -q https://github.com/hisxo/waybackpack/releases/latest/download/waybackrust -O /usr/bin/waybackrust
chmod +x /usr/bin/waybackrust
apt install -y theharvester recon-ng

echo "[*] Installing helper utilities..."
apt install -y python3-pip python-is-python3 python2 python2-dev golang pipx jq curl git unzip wget

echo "[*] Installing pip2..."
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py -O /tmp/get-pip.py
python2 /tmp/get-pip.py

echo "[*] Setting up pipx..."
pipx ensurepath

echo "[*] Installing pyftpdlib (again if needed)..."
pip3 install pyftpdlib

# echo "[*] Verifying VirtualBox additions..."
# apt install -y linux-headers-$(uname -r) virtualbox-guest-x11

echo "[*] Installing VMware Guest Additions..."
apt install -y open-vm-tools open-vm-tools-desktop linux-headers-$(uname -r)

echo "[+] All tools have been installed."
