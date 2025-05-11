# 🧰 Eric Zimmerman Tools Cheat Sheet v1.0

By SANS DFIR  
[https://ericzimmerman.github.io/](https://ericzimmerman.github.io/)

---

## 🛠️ Tools Covered

- LECmd (LNK files)
- PECmd (Prefetch files)
- JLECmd (Jump Lists)
- bstrings (String searching)
- AppCompatCacheParser (Shimcache)
- AmcacheParser (Amcache.hve)

---

## 📌 Common Usage

- Export formats supported: CSV, JSON, HTML
- Use `--mp` for higher precision timestamps
- Most tools support exporting multiple formats simultaneously
- Chocolatey package available: `EricZimmermanTools`

---

## 📂 LNK Files with LECmd

### Basic Usage:
```bash
LECmd.exe -f <file>
LECmd.exe -d <directory>
```

### Key Data:
- Target timestamps
- Volume & Target ID info
- Absolute path

### Advanced:
```bash
LECmd.exe --all
```

---

## 📦 Prefetch Files with PECmd

### Basic Usage:
```bash
PECmd.exe -f <file>
PECmd.exe -d <directory>
```

### Export to CSV/HTML:
```bash
PECmd.exe -d <directory> --csv c:\temp --html c:\temp\html
```

### Key Data:
- Execution timestamps
- Total runs
- Referenced files/directories

### Precision Timestamps:
```bash
PECmd.exe --mp
```

---

## 📋 Jump Lists with JLECmd

### Basic Usage:
```bash
JLECmd.exe -f <file>
JLECmd.exe -d <directory>
```

### Key Data:
- App ID
- DestList data
- Embedded LNKs

### Advanced:
```bash
JLECmd.exe --ld --fd --appIDs <app_ids>
JLECmd.exe --withDir
JLECmd.exe --dumpTo <outdir>
```

---

## 🔍 String Searching with bstrings

### Basic Usage:
```bash
bstrings -f <file>
```

### Search Specific String:
```bash
bstrings -f <file> --ls "keyword"
```

### Use Regular Expressions:
```bash
bstrings -f <file> --lr email
```

### Useful Switches:
- `--off` : show offsets
- `-x` : max string length
- `-m` : min string length
- `--cp` : select code page
- `-p` : list built-in regex patterns
- `--fr` / `--fs` : multiple regex or strings

---

## 🧠 Shimcache with AppCompatCacheParser

### Basic Usage:
```bash
AppCompatCacheParser.exe -f <path_to_SYSTEM> --csv c:\temp
```

### Memory Loaded Registry:
```bash
AppCompatCacheParser.exe --csv c:\temp
```

### Key Data:
- Full path to executable
- Execution flag

### Advanced:
```bash
AppCompatCacheParser.exe -d
```

---

## 🗂️ Amcache.hve with AmcacheParser

### Basic Usage:
```bash
AmcacheParser.exe -f <Amcache.hve> --csv c:\temp
```

### Key Data:
- FullPath
- SHA-1
- FileIDLastWriteTimestamp
- MFTEntryNumber / SequenceNumber

### Advanced:
```bash
AmcacheParser.exe -b <blacklist> -w <whitelist> -i
```

---

## 🔗 References

- [Eric Zimmerman's Tools GitHub](https://ericzimmerman.github.io/)
- Chocolatey: `choco install ericzimmermantools`
- Can be used with [Timeline Explorer](https://ericzimmerman.github.io/)

---

**Maintained by: Christen Reinhart**  
**Source: Eric Zimmerman Tools Cheat Sheet v1.0**
