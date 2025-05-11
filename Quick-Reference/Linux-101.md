# 🐧 Linux CLI 101 – Command Line Cheat Sheet

**Version**: 1.0  
**Purpose**: Fundamental Linux/Unix commands for the command line learner  
**Note**: These commands are usually pre-installed on most Linux/Unix distributions and macOS.

---

## 🧠 Bash Basics

### Tab Completion
Speed up command entry with tab completion:
```bash
$ cat /etc/pas<TAB>  # autocompletes to /etc/passwd
$ cd ~/Do<TAB><TAB>  # shows: Documents/ Downloads/
$ cd ~/Dow<TAB>      # autocompletes to ~/Downloads/
```

---

## 🐱 `cat` – Concatenate and Display Files

Display a file:
```bash
$ cat example.txt
```

Concatenate two files and write to a new one:
```bash
$ cat FileA.txt FileB.txt > FileC.txt
```

---

## 📁 `cd` – Change Directory

Change to `/tmp`:
```bash
$ cd /tmp
```

Change to home directory:
```bash
$ cd
$ cd ~
$ cd /home/student
```

Change to parent directory:
```bash
$ cd ..
```

---

## ��️ `echo` – Print or Write Text

Print text to screen:
```bash
$ echo Cylon
```

Overwrite file content:
```bash
$ echo Cylon > example.txt
```

Append to a file:
```bash
$ echo Cylon >> example.txt
```

---

## 📂 `ls` – List Directory Contents

Basic listing:
```bash
$ ls
```

List all files with long format:
```bash
$ ls -la
```

List all files sorted by time:
```bash
$ ls -lat
```

Reverse time sort:
```bash
$ ls -lart
```

---

## 🌐 Networking Commands

Display network interfaces:
```bash
$ ifconfig
$ ip a
```

Restart networking (Debian-based):
```bash
$ sudo /etc/init.d/networking restart
```

---

## 🔐 `passwd` – Change Password

Change your current user's password:
```bash
$ passwd
```

---

## 📶 `ping` – Check Network Connectivity

Ping indefinitely:
```bash
$ ping 10.5.11.25
```

Ping three times:
```bash
$ ping -c3 10.5.11.25
```

---

## 📌 `pwd` – Print Working Directory

Show current directory:
```bash
$ pwd
```

---

## ⚙️ `sudo` – Run as Superuser

Run command with root privileges:
```bash
$ sudo command
```

Open a root shell:
```bash
$ sudo bash
```

---

**Maintained by: Christen Reinhart**  
**Converted from: Linux CLI 101 PDF Cheat Sheet (v1.0)**  
