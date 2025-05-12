
# Wazuh Installation and Configuration Guide

## Overview

Wazuh is an open-source security platform providing unified XDR and SIEM protection for endpoints and cloud workloads. Wazuh components include:

- **Wazuh Indexer:** Stores and indexes alerts.
- **Wazuh Server:** Analyzes data and manages agents.
- **Wazuh Dashboard:** Web UI for monitoring and management.

---

## System Requirements

### Hardware Requirements (Quickstart - Single Host)

| Agents  | CPU    | RAM    | Storage (90 Days) |
|---------|--------|--------|-------------------|
| 1–25    | 4 vCPU | 8 GiB  | 50 GB             |
| 25–50   | 8 vCPU | 8 GiB  | 100 GB            |
| 50–100  | 8 vCPU | 8 GiB  | 200 GB            |

### Supported OS

- Ubuntu 16.04, 18.04, 20.04, 22.04, 24.04
- CentOS 7, 8
- RHEL 7, 8, 9
- Amazon Linux 2, 2023

---

## Quickstart Installation (All-in-One)

```bash
curl -sO https://packages.wazuh.com/4.12/wazuh-install.sh
sudo bash ./wazuh-install.sh -a
```

**Access Dashboard:** https://<WAZUH_DASHBOARD_IP_ADDRESS>  
**Username:** admin  
**Password:** <ADMIN_PASSWORD>  

### Post-Install

```bash
# To disable Wazuh updates (Recommended):
sed -i "s/^enabled=1/enabled=0/" /etc/yum.repos.d/wazuh.repo
```

### Retrieve Passwords

```bash
sudo tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt
```

---

## Advanced Installation (Distributed - Step by Step)

### 1. Prepare Certificates

```bash
curl -sO https://packages.wazuh.com/4.12/wazuh-certs-tool.sh
curl -sO https://packages.wazuh.com/4.12/config.yml
# Edit config.yml and define your nodes
bash ./wazuh-certs-tool.sh -A
tar -cvf ./wazuh-certificates.tar -C ./wazuh-certificates/ .
```

### 2. Install Wazuh Indexer

```bash
# Import GPG key and add repo
rpm --import https://packages.wazuh.com/key/GPG-KEY-WAZUH
echo -e '[wazuh]
gpgcheck=1
gpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH
enabled=1
name=EL-$releasever - Wazuh
baseurl=https://packages.wazuh.com/4.x/yum/
protect=1' | tee /etc/yum.repos.d/wazuh.repo

# Install and configure
yum -y install wazuh-indexer
# Edit /etc/wazuh-indexer/opensearch.yml accordingly
# Deploy certificates
```

### 3. Initialize Cluster

```bash
/usr/share/wazuh-indexer/bin/indexer-security-init.sh
```

### Verify Installation

```bash
curl -k -u admin:admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200
curl -k -u admin:admin https://<WAZUH_INDEXER_IP_ADDRESS>:9200/_cat/nodes?v
```

---

## Install Wazuh Server

```bash
# Install via assisted method
bash wazuh-install.sh --wazuh-server wazuh-1
```

### Verify Server Status

```bash
systemctl status wazuh-manager
```

---

## Install Wazuh Dashboard

```bash
# Install via assisted method
bash wazuh-install.sh --wazuh-dashboard dashboard
```

### Access Dashboard

https://<WAZUH_DASHBOARD_IP_ADDRESS>

---

## Agent Deployment

Deploy Wazuh agents to endpoints using the Wazuh web interface or the documentation:

- Linux
- Windows
- macOS
- Solaris
- AIX
- HP-UX

---

## References

- [Official Wazuh Installation Guide](https://wazuh.com/install/)
- [Wazuh Documentation](https://documentation.wazuh.com/current/)
- [Wazuh Indexer Guide](https://documentation.wazuh.com/current/installation-guide/wazuh-indexer/index.html)
- [Wazuh Server Guide](https://documentation.wazuh.com/current/installation-guide/wazuh-server/index.html)
- [Wazuh Dashboard Guide](https://documentation.wazuh.com/current/installation-guide/wazuh-dashboard/index.html)

---

*By Christen Reinhart - Cybersecurity Lab Class*
