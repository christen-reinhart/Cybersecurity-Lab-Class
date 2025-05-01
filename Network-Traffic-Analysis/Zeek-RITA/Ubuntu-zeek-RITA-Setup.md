
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
