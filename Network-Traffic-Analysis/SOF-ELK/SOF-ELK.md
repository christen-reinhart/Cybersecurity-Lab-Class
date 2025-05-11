# 🔍 SOF-ELK Setup & Integration Guide

## �� Overview
**SOF-ELK** is a SANS-preconfigured virtual machine built on the ELK stack (Elasticsearch, Logstash, Kibana), tailored for digital forensics, blue team, and incident response investigations.

It supports ingestion of:
- Zeek logs
- Windows Event Logs (e.g., Security.evtx)
- Sysmon
- NetFlow
- and more...

**Official Resources**:
- [SANS SOF-ELK Page](https://www.sans.org/tools/sof-elk/)
- [SOF-ELK GitHub](https://github.com/philhagen/sof-elk)
- [SOF-ELK Wiki](https://github.com/philhagen/sof-elk/wiki)

---

## 🖥️ Part 1: Download and Deploy the SOF-ELK VM

### 1. Download
- Download the OVA image from: [https://www.sans.org/tools/sof-elk/](https://www.sans.org/tools/sof-elk/)

### 2. Import into VirtualBox
- Open VirtualBox → File → Import Appliance
- Select `SOF-ELK.ova`
- Name: `SOF-ELK`
- CPUs: 2+
- RAM: 4096–8192 MB
- Network: Bridged Adapter or Internal Network

---

## 🔁 Part 2: Initial Login and Startup

### Default Credentials:
- Username: `elkuser`
- Password: `elkuser`
- Access Kibana: `http://<SOF-ELK-IP>:5601`

### Verify Services:
```bash
sudo systemctl status logstash
sudo systemctl status kibana
sudo systemctl status elasticsearch
```

Restart services if needed:
```bash
sudo systemctl restart logstash
```

---

## 🌐 Part 3: Configure Log Sources

### Forward Zeek Logs
```bash
sudo apt install filebeat -y
```
Edit `/etc/filebeat/filebeat.yml`:
```yaml
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /path/to/zeek/logs/*.log
output.logstash:
  hosts: ["<SOF-ELK-IP>:5044"]
```
Then:
```bash
sudo systemctl enable filebeat
sudo systemctl start filebeat
```

### Forward Sysmon (Windows + Winlogbeat)
1. Install [Winlogbeat](https://www.elastic.co/beats/winlogbeat)
2. Configure `winlogbeat.yml`:
```yaml
output.logstash:
  hosts: ["<SOF-ELK-IP>:5044"]
```
3. Enable service:
```powershell
Start-Service winlogbeat
```

### Forward Suricata Logs
Ensure JSON logging is enabled. Then configure Filebeat:
```yaml
filebeat.inputs:
- type: log
  paths:
    - /var/log/suricata/eve.json
  json.keys_under_root: true
output.logstash:
  hosts: ["<SOF-ELK-IP>:5044"]
```
```bash
sudo systemctl restart filebeat
```

---

## 📊 Part 4: Access Kibana Dashboards

Navigate to `http://<SOF-ELK-IP>:5601`

Prebuilt dashboards include:
- Zeek Connection & HTTP
- Sysmon Process Trees
- Suricata Alert Visualization
- Event Log Timeline

---

## 📝 Notes
- All logs forward to port `5044`
- Set static IPs or use Internal Networking for consistent integration
- VM clocks should be synced for timeline accuracy

---

## 📚 References
- [SOF-ELK GitHub](https://github.com/philhagen/sof-elk)
- [SOF-ELK Wiki](https://github.com/philhagen/sof-elk/wiki)
- [SANS Tools: SOF-ELK](https://www.sans.org/tools/sof-elk/)

---

**Maintained for use in Cybersecurity Lab Class | Author: Christen Reinhart**
