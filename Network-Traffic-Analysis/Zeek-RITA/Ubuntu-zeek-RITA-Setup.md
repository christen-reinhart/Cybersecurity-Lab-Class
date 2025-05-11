
# 🧠 RITA v5 + Zeek Network Threat Hunting Lab (Ubuntu VM + Docker)

## 📋 Overview

This guide walks you through installing [Zeek](https://zeek.org/) and [RITA v5](https://www.activecountermeasures.com/free-tools/rita/) on an Ubuntu virtual machine using Docker. RITA (Real Intelligence Threat Analytics) ingests Zeek logs to detect command and control (C2) behavior, beaconing, long-lived connections, DNS tunneling, and more. The latest RITA version (v5+) uses ClickHouse for better performance and features a powerful terminal-based UI.

---

## 📦 Prerequisites

- Ubuntu 22.04 or 24.04 VM with internet access
- Docker and Docker Compose installed
- PCAP file for analysis (we use Zeus 24hr beaconing traffic)
- Basic familiarity with terminal commands

---

## 🐳 Step 1: Install Docker and Docker Compose Plugin

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
```

Then log out and log back in, or run:

```bash
newgrp docker
```

Now install the Compose plugin:

```bash
sudo apt install -y docker-compose-plugin
```

Verify:

```bash
docker --version
docker compose version
```

---

## 🧱 Step 2: Install Zeek (Docker version)

Download and install the Zeek runner script:

```bash
sudo wget -O /usr/local/bin/zeek https://raw.githubusercontent.com/activecm/docker-zeek/master/zeek
sudo chmod +x /usr/local/bin/zeek
```

---

## 🧠 Step 3: Install RITA v5 (Ansible Installer)

### Download and Extract:

```bash
cd ~
wget https://github.com/activecm/rita/releases/download/v5.0.0-beta/rita-v5.0.0-beta.tar.gz
tar -xzvf rita-v5.0.0-beta.tar.gz
cd rita-v5.0.0-beta-installer
```

### Run the Installer:

```bash
./install_rita.sh localhost
```

📝 You’ll be prompted for your sudo password during installation.

If you encounter Docker GPG key errors, make sure the keyring and repository entries do not conflict:
```bash
sudo rm /etc/apt/sources.list.d/docker.list
sudo apt update
```

---

## 📂 Step 4: Prepare PCAP + Convert to Zeek Logs

Create working directory and move your PCAP:

```bash
cd ~
mkdir ~/pcap-analysis
mv ~/Downloads/'delay_var_d30_j25_24h (1).pcap' ~/pcap-analysis/zeus_24hr.pcap
cd ~/pcap-analysis
```

Run Zeek to generate logs:

```bash
zeek -r zeus_24hr.pcap
```

---

## 🧪 Step 5: Import Logs into RITA and Analyze

Import Zeek logs into RITA:

```bash
rita import --logs . --database zeus_analysis
```

Once the import completes, launch the RITA interface:

```bash
rita view zeus_analysis
```

Use `/` to search and arrow keys to scroll. Look for high-severity beacons or long-lived connections.

---

## 🔍 Example Output

```text
Severity | Source        | Destination               | Beacon   | Duration
---------|---------------|---------------------------|----------|----------
Critical | 192.168.2.19  | connectivity-check.ubuntu | 100.00%  | 11m18s
Critical | 192.168.2.19  | 185.125.190.58             | 100.00%  | 3s
Critical | 192.168.2.84  | 52.226.139.180             | 100.00%  | 2m53s
```

---

## 🔁 Optional: Clean Up or Delete Datasets

```bash
rita list                 # View datasets
rita delete zeus_analysis # Delete a dataset
```

---

## 📚 References

- [Zeek Documentation](https://docs.zeek.org)
- [RITA GitHub Repo](https://github.com/activecm/rita)
- [RITA Official Download + Blog](https://www.activecountermeasures.com/free-tools/rita/)
- [Zeek Docker GitHub](https://github.com/activecm/docker-zeek)
- [Malware of the Day PCAPs](https://www.activecountermeasures.com/malware-of-the-day-understanding-c2-beacons-part-2-of-2/)
- [Docker Docs](https://docs.docker.com/engine/install/ubuntu/)
- [Ansible for RITA](https://github.com/activecm/rita/blob/master/docs/v5/install-rita.md)

---

## 🎉 Conclusion

You’ve now built a powerful threat hunting lab using Zeek and RITA v5! You can import more PCAPs, automate log ingestion, or integrate RITA with SIEM tools like Splunk for even deeper visibility.

# Version 2.0

# Installing and Using RITA v5.0.4 with Zeek on Ubuntu 24.04

**Last Updated:** May 11, 2025

This guide walks through the complete, verified process of installing and running RITA v5.0.4 using Docker and Zeek on a clean Ubuntu 24.04 system.

---

## ✅ Prerequisites

- Ubuntu 24.04 (fresh install)
- Internet access
- Administrative (sudo) privileges

---

## 🔧 Step 1: Update the System

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl wget git -y
```

---

## 🐳 Step 2: Install Docker

```bash
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg]   https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable docker
sudo systemctl start docker
```

---

## 📦 Step 3: Download and Install RITA v5.0.4

```bash
cd ~
wget https://github.com/activecm/rita/releases/download/v5.0.4/rita-v5.0.4.tar.gz
tar -xvzf rita-v5.0.4.tar.gz
cd rita-v5.0.4-installer
./install_rita.sh localhost
```

---

## 📥 Step 4: Install Zeek Docker Script

```bash
sudo wget -O /usr/local/bin/zeek https://raw.githubusercontent.com/activecm/docker-zeek/master/zeek
sudo chmod +x /usr/local/bin/zeek
```

---

## 🧪 Step 5: Analyze a PCAP File

```bash
# Create log directory
mkdir -p ~/zeek-logs/zeus24

# Parse the PCAP
zeek readpcap ~/Downloads/zeus_24hr.pcap ~/zeek-logs/zeus24
```

---

## 🧠 Step 6: Import Logs into RITA

```bash
rita import --logs ~/zeek-logs/zeus24 --database zeus24
```

---

## 📊 Step 7: Export Results or View in Terminal

### Option 1: Export to CSV

```bash
rita view zeus24 --stdout > zeus24_analysis.csv
```

### Option 2: Use the Built-In TUI

```bash
rita view zeus24
```

Then press `/` to begin searching inside the TUI.

---

## 🧹 Optional Cleanup

```bash
docker container stop rita-clickhouse rita-syslog-ng
docker container rm rita-clickhouse rita-syslog-ng
```

---

## 🔄 Notes

- You do **not** need to use the `latest` tag — use verified release versions like `v5.0.4`
- The helper script `zeek` is essential for working with PCAPs in Docker
- The RITA CLI automatically launches containers when needed

---

**Maintained by:** Christen Reinhart  
**Tested On:** Ubuntu 24.04 + Docker 24.0  
