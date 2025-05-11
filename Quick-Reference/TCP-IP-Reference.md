# 🌐 TCP/IP Pocket Reference Guide

**Source**: SANS Institute  
**Author**: Dr. Johannes Ullrich  
**Version**: August 2019  
**PDF Source**: [https://www.sans.org/security-resources/tcpip.pdf](https://www.sans.org/security-resources/tcpip.pdf)

---

## 🧰 tcpdump Usage

```bash
tcpdump [-aAenStvxX] [-F filterfile] [-i int] [-c n] [-r file] [-s snaplen] [-w file] [‘bpf filter’]
```

| Option | Description |
|--------|-------------|
| `-A` | Display payload |
| `-c n` | Display first n packets |
| `-D` | List interfaces |
| `-e` | Display data link header |
| `-F` | Read filter from file |
| `-i` | Interface to capture on |
| `-n` | Do not resolve names |
| `-r` | Read from file |
| `-s` | Snap length in bytes |
| `-S` | Display absolute TCP seq. numbers |
| `-t` | Suppress timestamp |
| `-tttt` | Print date/time |
| `-v` | Verbose |
| `-w` | Write packets to file |
| `-x/-xx/-X` | Hex output variations |

---

## 🔠 Acronyms

AH, ARP, BGP, DF, DHCP, DNS, ECN, ESP, FTP, GRE, HTTP, ICMP, IGMP, IMAP, IP, ISAKMP, L2TP, OSPF, POP3, RFC, SMTP, SSH, SSL, TCP, TLS, TFTP, TOS, UDP...

---

## 📡 Protocol Headers

### UDP Header
```
0-1: Source Port | 2-3: Destination Port
4-5: Length      | 6-7: Checksum
```
Common ports: 53 (DNS), 67/68 (DHCP), 123 (NTP), 161/162 (SNMP), 514 (syslog)

### TCP Header
```
0-1: Source Port | 2-3: Dest Port
4-7: Sequence Number
8-11: Ack Number
12: Header Length + Reserved + Flags
13: Flags (CWR ECE URG ACK PSH RST SYN FIN)
14-15: Window Size
16-17: Checksum
18-19: Urgent Pointer
20+: Options
```
Common ports: 22 (SSH), 80 (HTTP), 443 (HTTPS), 445 (SMB), 3389 (RDP)

---

## 🧱 IPv4 Header

```
0: Version (4 bits), IHL (4 bits)
1: ToS / Diff Serv
2-3: Total Length
4-5: ID
6-7: Flags (DF/MF) + Frag Offset
8: TTL
9: Protocol (1: ICMP, 6: TCP, 17: UDP)
10-11: Header Checksum
12-15: Source IP
16-19: Dest IP
20+: Options
```

---

## 🔁 ICMP Types

| Type | Code | Description |
|------|------|-------------|
| 0 | 0 | Echo Reply |
| 3 | x | Destination Unreachable |
| 5 | x | Redirect |
| 8 | 0 | Echo (Ping) |
| 11| x | TTL Exceeded |
| 12| x | Parameter Problem |
| 13| 0 | Timestamp |
| 30| 0 | Traceroute |

---

## 🔄 ARP Packet

```
0: Hardware Type
2: Protocol Type
4: HW Addr Len
5: Prot Addr Len
6-7: Opcode (1 = Request, 2 = Reply)
8-9+: MAC and IP address fields
```

---

## 📛 DNS Packet Layout

```
0-1: Transaction ID
2-3: Flags
4-5: Questions
6-7: Answer RRs
8-9: Authority RRs
10-11: Additional RRs
```

DNS Flags:
- QR (Query/Response)
- Opcode
- AA, TC, RD, RA
- RCODE (0=No Error, 3=NXDOMAIN...)

Record Types: A (1), CNAME (5), NS (2), MX (15), TXT (16), AAAA (28)...

---

## 🌐 Protocol Numbers (ip[9])

- 1: ICMP
- 2: IGMP
- 6: TCP
- 17: UDP
- 50: ESP
- 51: AH
- 47: GRE
- 115: L2TP

---

**Maintained by: Christen Reinhart**  
**Converted from: TCP/IP Cheat Sheet (2021)**  
**Author: Dr. Johannes Ullrich – SANS Institute**  
