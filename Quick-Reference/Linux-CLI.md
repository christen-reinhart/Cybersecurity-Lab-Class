# 🐧 Linux CLI Cheat Sheet

**Version**: 1.0  
**Purpose**: Practical Linux command-line examples with a preference for safe syntax using `cat file | command` patterns.

---

## 🧠 Philosophy

- Use `cat file | command` instead of `command < file` to avoid accidental overwrites.
- “There is more than one way to do it.” – Larry Wall

---

## �� `awk` Examples

Print line lengths and contents:
```bash
cat /etc/passwd | awk '{print length, $0;}'
```

Print the 2nd field using 'Mozilla/' as delimiter:
```bash
cat /var/log/apache2/access.log | awk -F "Mozilla/" '{print $2}'
```

Print last dot-delimited field:
```bash
cat domains.txt | awk -F "." '{print $(NF)}'
```

---

## 🔒 Checksums

MD5 checksum:
```bash
md5sum /etc/passwd
```

SHA1 checksum (3 ways):
```bash
sha1sum /etc/passwd
shasum /etc/passwd
shasum -a1 /etc/passwd
```

SHA256 and SHA512:
```bash
shasum -a256 /etc/passwd
shasum -a512 /etc/passwd
```

---

## ✂️ `cut` Examples

2nd field by space:
```bash
cat /var/log/dpkg.log | cut -d' ' -f2
```

6th field by colon:
```bash
cat /etc/passwd | cut -d: -f6
```

2nd–3rd fields by comma:
```bash
cat /labs/honeytokens/pilots.csv | cut -d, -f2-3
```

7th field onward:
```bash
cat /var/log/dpkg.log | cut -d' ' -f7-
```

6th field by double quote:
```bash
cat /var/log/apache2/access.log | cut -d" -f6
```

Chars from 11th onward:
```bash
ifconfig | cut -c11-
```

---

## 🧾 `file`

Determine file types:
```bash
file /usr/local/bin/*
```

---

## 🔍 `grep` Usage

Find lines with “bash”:
```bash
grep bash /etc/passwd
```

Case-insensitive:
```bash
grep -i bash /etc/passwd
```

Exclude matches:
```bash
grep -vi bash /etc/passwd
```

Match plus next 5 lines:
```bash
grep -A5 root /etc/passwd
```

---

## 📋 `head`

First 10 lines:
```bash
head -n 10 /etc/passwd
```

---

## ✂️ `sed`

Replace “Mozilla”:
```bash
grep Mozilla /var/log/apache2/access.log | sed "s/Mozilla/MosaicKilla/g"
```

Delete text before “Mozilla”:
```bash
grep Mozilla /var/log/apache2/access.log | sed "s/^.*Mozilla//g"
```

Keep only from “Mozilla” forward:
```bash
grep Mozilla /var/log/apache2/access.log | sed "s/^.*Mozilla/Mozilla/g"
```

---

## 📊 `sort` and `uniq`

Simple alphabetic:
```bash
strings /pcaps/fraudpack.pcap | grep -i user-agent | sort
```

Unique:
```bash
strings /pcaps/fraudpack.pcap | grep -i user-agent | sort -u
```

Count unique lines:
```bash
strings /pcaps/fraudpack.pcap | grep -i user-agent | sort | uniq -c
```

Count and sort:
```bash
... | uniq -c | sort -n
```

Length and reverse sort:
```bash
... | sort -u | awk '{print length, $0}' | sort -rn
```

Sort on 2nd CSV field:
```bash
cat /bonus/alexa/top-1m.csv | sort -t, -k2
```

---

## 📈 `wc`

Count lines:
```bash
wc -l /etc/passwd
```

---

## 🔬 `xxd`

String to hex:
```bash
echo -n "DOS mode" | xxd
echo -n "DOS mode" | xxd -g0
```

Hex to binary:
```bash
echo 444f53206d6f6465 | xxd -r -p
```

Percent-encoded to binary:
```bash
echo "%63%67%69%2D%62%69%6E" | sed "s/\%//g" | xxd -r -p
```

---

**Maintained by: Christen Reinhart**  
**Converted from: LinuxCLI.pdf (Cheat Sheet)**  
