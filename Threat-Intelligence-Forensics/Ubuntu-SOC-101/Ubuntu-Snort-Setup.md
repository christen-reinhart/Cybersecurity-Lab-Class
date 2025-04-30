# 🛠️ Ubuntu Cybersecurity Lab Setup in VirtualBox

This guide documents how to set up a Ubuntu-based cybersecurity lab in VirtualBox, install key dependencies, and configure tools used in penetration testing, traffic analysis, and blue/red team exercises.

---

## 📥 Prerequisites

- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Download Ubuntu Desktop ISO](https://ubuntu.com/download/desktop)
  - Recommended Version: Ubuntu 22.04 LTS or later

---

## 💻 Step 1: Create Ubuntu Virtual Machine

1. Open **VirtualBox** > Click **New**
2. Name: `Ubuntu-CyberLab`
3. Type: `Linux`
4. Version: `Ubuntu (64-bit)`
5. Memory: **4096 MB** or more
6. Create a virtual hard disk (VDI, dynamically allocated, 40+ GB)
7. Attach the downloaded Ubuntu ISO to the optical drive under **Settings > Storage**

---

## 🧱 Step 2: Install Ubuntu OS

1. Boot the VM and follow the Ubuntu installation prompts
2. Create a user account with admin privileges
3. Choose **Normal Installation** and enable third-party drivers
4. Reboot when finished and remove ISO

---

## 🔁 Step 3: System Update

Open Terminal and run:

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 📦 Step 4: Install Dependencies

Install core build and development packages required for Snort, Zeek, and other tools:

```bash
sudo apt install -y build-essential libpcap-dev libpcre3-dev libdumbnet-dev \
bison flex zlib1g-dev liblzma-dev openssl libssl-dev libnghttp2-dev \
libhwloc-dev cmake ethtool libnetfilter-queue-dev libmnl-dev \
libunwind-dev libnss3-tools libevent-dev
```

---

## 🕵️ Step 5: Install Security Tools

### 🔐 Snort IDS

```bash
sudo apt install -y snort
snort -V
```

### 🛡️ Zeek NIDS (Built from Source)

Visit: [https://zeek.org/get-zeek](https://zeek.org/get-zeek)  
Follow build instructions or use prebuilt binaries from trusted sources.

---

## 🌐 Web Proxy & Enumeration Tools (Browser Extensions)

These tools are recommended to be installed on **Google Chrome** within the VM:

- ✅ [FoxyProxy](https://chrome.google.com/webstore/detail/foxyproxy-standard/gcknhkkoolaabfmlnjonogaaifnjlfnp)
- ✅ [Wappalyzer](https://chrome.google.com/webstore/detail/wappalyzer-technology-pro/gppongmhjkpfnbhagpmjfkannfbllamg)
- ✅ [HackTools](https://chrome.google.com/webstore/detail/hacktools/cmbndhnoonmghfofefkcccljbkdpamhi)
- ✅ [User-Agent Switcher](https://chrome.google.com/webstore/detail/user-agent-switcher/jfnlifkkjoboaoekbmgdmecpmcehceel)

---

## 🧪 Interception Tools

### 💥 Burp Suite (Community or Pro)

1. [Download Burp Suite](https://portswigger.net/burp/releases)
2. Give the `.sh` file execute permissions and run it:
```bash
cd ~/Downloads
chmod +x burpsuite_community_linux_v*.sh
./burpsuite_community_linux_v*.sh
```

### 🔍 OWASP ZAP Proxy

```bash
sudo snap install zaproxy --classic
```

---

## 📁 Organize Tools (Optional)

You may want to organize your tools in a dedicated folder:

```bash
mkdir ~/CyberTools
mv ~/Downloads/burpsuite_pro* ~/CyberTools/
```

Create a `.desktop` launcher (if desired):

```bash
nano ~/.local/share/applications/burp.desktop
```

Paste the following:
```ini
[Desktop Entry]
Name=Burp Suite Pro
Exec=java -jar /home/yourusername/CyberTools/burpsuite_pro.jar
Type=Application
Icon=utilities-terminal
Terminal=false
```

Then:
```bash
chmod +x ~/.local/share/applications/burp.desktop
```

---

## 🧰 (Optional) Install Additional Toolkits

You can install additional security toolkits and wordlists:

```bash
# Install common recon wordlists
sudo snap install seclists
```

---

## 🧪 Testing Tools

- ✅ **Snort**: `snort -V`
- ✅ **Zeek**: `zeek -r example.pcap`
- ✅ **Burp Suite**: Launch from Applications or command line
- ✅ **ZAP**: `zaproxy`

---

## 📝 Final Notes

This Ubuntu-based cybersecurity VM provides a solid foundation for:

- Network traffic analysis with **Zeek** and **Snort**
- Penetration testing with **Burp** and **ZAP**
- Web recon with browser-based tools
- Realistic lab environments like **OWASP Juice Shop**

Use these tools responsibly and only in legal lab environments.

---

## 📚 Additional Resources

- [Ubuntu Documentation](https://help.ubuntu.com/)
- [Snort User Guide](https://docs.snort.org/)
- [Zeek Documentation](https://docs.zeek.org/)
- [Burp Suite Docs](https://portswigger.net/burp/documentation)
- [ZAP Docs](https://www.zaproxy.org/docs/)
- [FoxyProxy](https://getfoxyproxy.org/)


