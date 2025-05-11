# 🛰️ Nmap Cheat Sheet

**Version**: 1.1  
**Author**: SANS Institute  
[https://www.sans.org](https://www.sans.org)

---

## 🎯 Target Specification

| Description | Example |
|-------------|---------|
| IPv4 address | `192.168.1.1` |
| IPv6 address | `AABB:CCDD::FF%eth0` |
| Host name | `www.target.tgt` |
| IP range | `192.168.0-255.0-255` |
| CIDR | `192.168.0.0/16` |
| Target list from file | `-iL targets.txt` |

---

## 🔐 Target Ports

| Option | Description |
|--------|-------------|
| *none* | Scans 1,000 most common ports |
| `-F` | Scan top 100 ports |
| `-p <range>` | e.g., `-p 22-443` |
| `-p <list>` | e.g., `-p 22,80,443` |
| `-pU:53,U:110,T:20-445` | Mixed UDP/TCP |
| `-r` | Linear scan |
| `--top-ports <n>` | Top N ports |
| `-p-65535` | Scan from port 1 |
| `-p0-` | Scan to port 65535 |
| `-p-` | Scan all ports |

---

## 🧪 Scan Types

| Option | Description |
|--------|-------------|
| `-sn` | Ping only |
| `-sS` | SYN scan |
| `-sT` | TCP connect scan |
| `-sU` | UDP scan |
| `-sV` | Version detection |
| `-O` | OS detection |
| `--scanflags` | Custom TCP flags (URG, ACK, PSH, etc.) |

---

## 📡 Probing Options

| Option | Description |
|--------|-------------|
| `-Pn` | Skip host discovery |
| `-PB` | Default probe (TCP 80, 445, ICMP) |
| `-PS<ports>` | TCP SYN ping |
| `-PE` | ICMP Echo |
| `-PP` | ICMP Timestamp |
| `-PM` | ICMP Netmask |

---

## ⏱️ Timing Options

### Aggregate
| Option | Behavior |
|--------|----------|
| `-T0` | Paranoid (IDS evasion) |
| `-T1` | Sneaky |
| `-T2` | Polite |
| `-T3` | Normal (default) |
| `-T4` | Aggressive |
| `-T5` | Insane |

### Fine-Grained
- `--min-hostgroup/max-hostgroup <size>`
- `--min-parallelism/max-parallelism <probes>`
- `--min-rtt-timeout/max-rtt-timeout <time>`
- `--max-retries <tries>`
- `--host-timeout <time>`
- `--scan-delay/--max-scan-delay <time>`
- `--min-rate` / `--max-rate` `<packets/sec>`

---

## 🧰 Output Options

| Option | Description |
|--------|-------------|
| `-oN` | Normal |
| `-oG` | Greppable |
| `-oX` | XML |
| `-oA <base>` | All formats |

---

## 🎛️ Misc Options

- `-n` – No DNS resolution  
- `-6` – Use IPv6  
- `-A` – Enable OS/version detection, script scan, and traceroute  
- `--reason` – Display reasons for port states

---

## 🧠 Nmap Scripting Engine (NSE)

| Option | Description |
|--------|-------------|
| `-sC` | Default scripts |
| `--script <script|category>` | Run specified scripts |
| `--script-args key=value,...` | Set arguments |
| `--script-updatedb` | Update NSE DB |

### Example:
```bash
nmap --script dns-zone-transfer --script-args 'dns-zone-transfer.domain=example.com' -p53 <host>
nmap --script http-robots.txt <host>
nmap --script smb-brute -p445 <host>
nmap --script smb-psexec --script-args 'smbuser=user,smbpass=pass' -p445 <host>
```

---

## 🔎 NSE Script Categories

- `auth` – Credential use/bypass  
- `broadcast` – Discover on local network  
- `brute` – Guess credentials  
- `default` – Default scripts  
- `discovery` – Gather info  
- `dos` – Denial-of-service  
- `exploit` – Exploitation  
- `external` – Third-party interaction  
- `fuzzer` – Send invalid inputs  
- `intrusive` – High-risk/impact  
- `malware` – Malware detection  
- `safe` – Low-risk  
- `version` – Version detection  
- `vuln` – Vulnerability testing

---

## 🧩 Base Syntax

```bash
nmap [ScanType] [Options] {targets}
```

---

**Converted by: Christen Reinhart**  
**Source: Nmap Cheat Sheet v1.1 – SANS Institute**
