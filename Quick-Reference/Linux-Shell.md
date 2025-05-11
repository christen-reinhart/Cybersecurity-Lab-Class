# 🐧 Linux Shell Survival Guide v2.3 (Pocket Reference)

By Phil Hagen – SANS FOR572  
[http://computer-forensics.sans.org](http://computer-forensics.sans.org) | [http://lewestech.com](http://lewestech.com)

---

## 📖 Purpose

This guide highlights essential Linux shell primitives and utilities for forensics and incident response. Whether over a laggy SSH connection or in a constrained environment, these tools offer robust solutions for automation and data extraction.

---

## 🔍 grep – Print Matching Lines

```bash
grep pattern input.txt
```

### Options:
- `-i` Case-insensitive
- `-v` Invert match
- `-c` Count matches
- `-l` Show filenames with matches
- `-h` Suppress filenames in output

---

## 🔡 sort – Sort Lines

```bash
sort input.txt
```

### Options:
- `-n` Numeric sort
- `-r` Reverse
- `-k` Sort by field
- `-t` Field delimiter

---

## 🔁 uniq – De-duplicate Lines

```bash
grep pattern input.txt | sort | uniq
```

### Options:
- `-c` Prefix lines by the number of occurrences

---

## 🔗 Working with Pipes

Chain commands using the pipe `|` operator:
```bash
grep pattern input.txt | sort | uniq -c
```

---

## 📝 Redirecting Output

```bash
>   # Overwrite file
>>  # Append to file
```

```bash
grep pattern input.txt > results.txt
grep other input.txt >> results.txt
```

---

## 🧠 Shell Efficiency Tips

### Tab Completion
- Use `<TAB>` to auto-complete commands, paths, variables.

### Common Variables
- `~` or `$HOME` – Home directory
- `$PATH` – Search path
- `$PWD` – Current directory
- `$?` – Last command’s exit value

### Command History
- Use `↑` and `↓` to browse
- `history` – List previous commands
- `Ctrl-R` – Reverse search

---

## 📡 tcpdump – Packet Capture

```bash
sudo tcpdump -n -s 0 -i eth0 '<filter>'
tcpdump -n -r input.pcap -w output.pcap '<filter>'
```

### Key Flags:
- `-n` No DNS/port lookup
- `-r` Read from file
- `-w` Write to file
- `-D` List interfaces
- `-i` Interface
- `-s` Snaplen
- `-C` File size rotation (MB)
- `-G` Time-based rotation
- `-W` Rotate file limit
- `-x` Hex output

---

## 🐬 tshark – Terminal Wireshark

```bash
tshark -n -r in.pcap -Y '<display filter>'
```

### Key Flags:
- `-T` Output type
- `-e` Fields for output
- `-z` Stats mode

---

## 🧾 awk – Pattern Scanning

```bash
awk -F ',' '{ print $1, $6, $3 }' in.txt
```

With field separator:
```bash
awk '{ FS = ","; OFS = "\t"; print $2, $4 }' in.txt
```

---

## 🌐 nfdump – Analyze NetFlow

```bash
nfdump -R ./ -O tstart -o extended
```

### Flags:
- `-R` Directory
- `-r` File
- `-t` Time window
- `-s` Top N stats
- `-o` Format: line, long, extended, or fmt string

---

## 🌍 passivedns – DNS Artifact Logging

```bash
passivedns -r input.pcap -l pdnslog.txt -L pdns_nxdomain.txt
```

- `-i` Live sniffing

---

## 🧱 nfpcapd – Convert PCAP to NetFlow

```bash
nfpcapd -r in.pcap -l ./netflow/ -S 1 -z
```

- `-S` Directory format
- `-z` Compress output

---

## 📚 Learn More

- Use `man <command>` or `--help` for command help
- Keyword search: `man -k keyword`
- Visit: [http://www.grymoire.com/Unix/](http://www.grymoire.com/Unix/)

---

**Maintained by: Christen Reinhart**  
**Converted from: Linux Shell Survival Guide v2.3 – SANS FOR572**  
