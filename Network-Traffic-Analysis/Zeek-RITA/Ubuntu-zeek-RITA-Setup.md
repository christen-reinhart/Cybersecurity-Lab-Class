
# 🧠 Ubuntu + Zeek + RITA v5 Setup Guide (Docker-Based)

This guide outlines the installation of Zeek and RITA v5 on an Ubuntu Desktop VM using Docker, designed to eliminate dependency issues with older versions. This is ideal for use in a cybersecurity lab for network traffic analysis and threat hunting.

---

## 📥 Prerequisites

- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Download Ubuntu Desktop ISO](https://ubuntu.com/download/desktop)
- [Install Docker](https://docs.docker.com/engine/install/ubuntu/)
- [Install Docker Compose (v2+)](https://docs.docker.com/compose/install/)

---

## 💻 Step 1: Create an Ubuntu VM in VirtualBox

1. Open **VirtualBox** → Click **New**.
2. Configure:
   - **Name**: `Ubuntu-Zeek-RITA`
   - **Type**: Linux
   - **Version**: Ubuntu (64-bit)
   - **Memory**: 4096 MB (recommended)
   - **CPU**: 2 Cores minimum
   - **Video Memory**: 128 MB
   - **Disk**: VDI, Dynamically Allocated, 40 GB+

---

## 🔧 Step 2: Install Docker and Docker Compose

```bash
# Update and install required packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y ca-certificates curl gnupg lsb-release

# Add Docker GPG key and repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg]   https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable Docker without sudo (optional)
sudo usermod -aG docker $USER
newgrp docker

# Test Docker
docker --version
docker compose version
```

---

## 📦 Step 3: Setup Zeek and RITA Environment

1. **Create Project Directory**:

```bash
mkdir ~/zeek-rita-lab && cd ~/zeek-rita-lab
```

2. **Create `docker-compose.yml`**:

```yaml
version: '3'
services:
  zeek:
    image: blacktop/zeek
    volumes:
      - ./pcaps:/pcaps
    entrypoint: ["zeek", "-r", "/pcaps/yourfile.pcap"]
    networks:
      - zeeknet

  clickhouse:
    image: clickhouse/clickhouse-server:latest
    ports:
      - "8123:8123"
      - "9000:9000"
    networks:
      - zeeknet

  rita:
    image: activecm/rita:5
    volumes:
      - ./zeek_logs:/zeek_logs
      - ./rita_data:/rita_data
    depends_on:
      - clickhouse
    environment:
      - CLICKHOUSE_HOST=clickhouse
    networks:
      - zeeknet

networks:
  zeeknet:
```

3. **Place PCAP File**:

```bash
mkdir pcaps && cp ~/Downloads/yourfile.pcap ./pcaps/
```

4. **Run Zeek to Parse PCAP**:

```bash
docker compose run zeek
```

5. **Import into RITA**:

```bash
docker compose run rita import /zeek_logs/default ./rita_data
```

6. **Analyze with RITA**:

```bash
docker compose run rita analyze ./rita_data
docker compose run rita show-beacons ./rita_data
```

---

## 🧪 Sample Use Case

1. Download malware PCAPs from [malware-traffic-analysis.net](https://www.malware-traffic-analysis.net/).
2. Run `zeek` over the PCAP.
3. Import results into `rita`.
4. Run `rita analyze` and view beaconing, scan detection, and communication stats.

---

## 📋 Final Notes

- Make sure your PCAP files are placed in the `pcaps` directory.
- You may rebuild RITA/Zeek containers anytime using `docker compose down && docker compose up`.
- Use `docker exec -it <container_id> bash` for manual inspection inside containers.

---

## 📚 References

- [Zeek Network Security Monitor](https://zeek.org/)
- [RITA by Active Countermeasures](https://www.activecountermeasures.com/free-tools/rita/)
- [Docker Installation Guide](https://docs.docker.com/engine/install/ubuntu/)
- [ClickHouse Docs](https://clickhouse.com/docs/en/)
- [VirtualBox Manual](https://www.virtualbox.org/manual/UserManual.html)

---

**Author**: Christen Reinhart  
**Project**: Cybersecurity Lab Class Repository
