# 🧠 Ubuntu + Zeek Installation Guide (Cybersecurity Lab)

This guide walks you through setting up an Ubuntu Virtual Machine and installing **Zeek**, a powerful network traffic analysis tool, for use in your cybersecurity lab environment.

---

## 📥 Prerequisites

- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Download Ubuntu ISO](https://ubuntu.com/download/desktop) (Ubuntu 22.04 LTS or later recommended)

---

## 📦 Step 1: Create Ubuntu VM in VirtualBox

### 1. Open VirtualBox and Click **New**
- **Name**: `UBUNTU_ZEEK`
- **Type**: Linux
- **Version**: Ubuntu (64-bit)

### 2. Configure Resources
- **Memory**: 4096 MB (minimum)
- **Processors**: 2 (minimum)
- **Video Memory**: 128 MB

### 3. Create Virtual Hard Disk
- Type: VDI
- Size: 40 GB (Dynamically allocated)

### 4. Mount Ubuntu ISO
- Go to **Settings > Storage**
- Under the Controller: IDE, select "Empty"
- Click the disk icon and **choose your Ubuntu ISO**

### 5. Start VM and Install Ubuntu
- Follow the on-screen instructions:
  - Choose language, keyboard layout, etc.
  - Install updates and third-party software (recommended)
  - Create your user account
  - Allow installation to complete and reboot

---

## 🔄 Step 2: Update Ubuntu After Installation

Open Terminal and run:

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 🛠️ Step 3: Install Required Dependencies

```bash
sudo apt install cmake make gcc g++ flex bison libpcap-dev libssl-dev \
python3-dev swig zlib1g-dev git curl -y
```

---

## 🌐 Step 4: Download and Build Zeek from Source

```bash
cd ~
git clone --recursive https://github.com/zeek/zeek
cd zeek
./configure
make -j$(nproc)
sudo make install
```

---

## 🧩 Step 5: Add Zeek to PATH

```bash
echo 'export PATH=/usr/local/zeek/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

---

## ✅ Step 6: Confirm Zeek Installation

```bash
zeek --version
```

Example output:

```
zeek version 6.x.x
```

---

## 📁 Step 7: Run Zeek on a PCAP File

If you have a .pcap file, run:

```bash
zeek -r yourfile.pcap
```

This will generate logs such as:

- `conn.log`
- `dns.log`
- `http.log`

View logs with:

```bash
cat conn.log | less
```

---

## 💾 Optional: Create a VirtualBox Snapshot

After setup:

- Right-click your `UBUNTU_ZEEK` VM
- Choose **Take Snapshot**
- Name it: `Fresh Zeek Install`

---

## 📚 Additional Resources

- [Zeek Documentation](https://docs.zeek.org/)
- [Zeek GitHub Repository](https://github.com/zeek/zeek)
- [Zeek Scripting Guide](https://docs.zeek.org/en/current/scripts/index.html)
- [Ubuntu Download](https://ubuntu.com/download)

---

## 🧪 Lab Use Cases

You can now use Zeek to:

- Analyze packet captures (PCAPs)
- Generate network logs for Splunk/RITA ingestion
- Monitor simulated network traffic
- Conduct threat hunting in lab environments

**Author**: Christen Reinhart  
**Project**: Cybersecurity Lab Class Repository
