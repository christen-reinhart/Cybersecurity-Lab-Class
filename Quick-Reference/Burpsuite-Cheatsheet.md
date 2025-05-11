# 🛠️ Burp Suite Cheat Sheet v1.0

By Chris Dale (@chrisadale)  
[SANS Offensive Operations](https://sans.org/offensive-operations)

---

## 🎯 Purpose

This cheat sheet enhances usability and productivity in **Burp Suite**, the go-to tool for web application penetration testing.  
Burp Suite offers features such as Repeater, Intruder, Sequencer, Extender, and an integrated Chromium browser.

---

## 🧭 Global Hotkeys

| Shortcut         | Action                        |
|------------------|-------------------------------|
| `Ctrl-I`         | Send to Intruder              |
| `Ctrl-R`         | Send to Repeater              |
| `Ctrl-S`         | Search in editor              |
| `Ctrl-.`         | Go to next selection          |
| `Ctrl-M`         | Go to previous selection      |
| `Ctrl-A`         | Select all                    |
| `Ctrl-Z`         | Undo                          |
| `Ctrl-Y`         | Redo                          |

---

## 🧰 Navigational Hotkeys

| Shortcut             | Action                      |
|----------------------|-----------------------------|
| `Ctrl-Shift-T`       | Target Tab                  |
| `Ctrl-Shift-P`       | Proxy Tab                   |
| `Ctrl-Shift-R`       | Repeater Tab                |
| `Ctrl-Shift-I`       | Intruder Tab                |
| `Ctrl-Shift-O`       | Project Options Tab         |
| `Ctrl-Shift-D`       | Dashboard Tab               |
| `Ctrl-=`             | Next tab                    |
| `Ctrl--`             | Previous tab                |

---

## 🔣 Encoding / Decoding Hotkeys

| Shortcut             | Action                                      |
|----------------------|---------------------------------------------|
| `Ctrl-B`             | Base64 encode selection                     |
| `Ctrl-Shift-B`       | Base64 decode selection                     |
| `Ctrl-H`             | Encode HTML entities                        |
| `Ctrl-Shift-H`       | Decode HTML entities                        |
| `Ctrl-U`             | URL encode selection                        |
| `Ctrl-Shift-U`       | URL decode selection                        |

---

## 💬 Tool Specific Shortcuts

| Shortcut             | Action                                      |
|----------------------|---------------------------------------------|
| `Ctrl-F`             | Forward Request (Proxy)                     |
| `Ctrl-T`             | Toggle Proxy Intercept On/Off              |
| `Ctrl-Space`         | Send Request (Repeater)                     |
| Double-click tab     | Rename tab                                  |

---

## ✍️ Editor Shortcuts

| Shortcut                   | Action                                |
|----------------------------|---------------------------------------|
| `Ctrl-D`                   | Delete current line                   |
| `Ctrl-Delete`              | Delete word                           |
| `Ctrl-Backspace`          | Delete word backward                  |
| `Ctrl-Home / End`          | Jump to start / end of document       |
| `Ctrl-Shift-Home / End`    | Select to start / end of document     |
| `Ctrl-Left / Right`        | Jump to prev/next word                |
| `Ctrl-Shift-Left / Right`  | Select to prev/next word              |

---

## 📡 Burp Collaborator

Monitor callbacks from vulnerable apps via unique DNS names. Supports:

- DNS
- HTTP/S
- SMTP/SMTPS

Use the **Taborator** extension for easier interaction with Burp Collaborator.

---

## 🧪 Hunting for Vulnerabilities – Useful Extensions

### Recon & Scanning

- **Param Miner**: Find unlinked parameters
- **Backslash Powered Scanner**: Detect unusual transformations
- **Software Vulnerability Scanner**: Match versions with known CVEs
- **HTTP Request Smuggler**: Launch HTTP Request Smuggling attacks
- **Active Scan++**: Detect XML, Host Header, Input transformations
- **Retire.js**: Identify outdated JavaScript & CVEs

### Authorization and Tokens

- **Autorize**: Test role-based access issues
- **JSON Web Tokens**: Decode, verify, attack JWTs
- **SAML Raider**: Inspect, edit, re-sign SAML messages

### Logging and Speed

- **Logger++**: Log scanner/intruder attacks, filter by status
- **Turbo Intruder**: Scriptable, high-speed HTTP attack engine
- **Taborator**: Enhance Collaborator tracking

---

## 🔌 REST API

Enable from User Options (default: `http://127.0.0.1:1337`).

| Task | Example Command |
|------|------------------|
| Headless Mode | `java -jar -Xmx4g -Djava.awt.headless=true /path/to/burp.jar` |
| List Issue Types | `curl http://127.0.0.1:1337/v0.1/knowledge_base/issue_definitions` |
| Scan URLs | `curl -X POST http://127.0.0.1:1337/v0.1/scan -d '{ "urls": ["http://target/"] }'` |
| Check Scan Status | `curl http://127.0.0.1:1337/v0.1/scan/<task_id>` |

---

**Converted by: Christen Reinhart**  
**Original Author: Chris Dale**  
**Source: Burp Suite Cheat Sheet v1.0**
