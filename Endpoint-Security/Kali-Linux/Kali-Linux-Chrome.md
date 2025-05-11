# 🧭 Installing Google Chrome on Kali Linux via CLI

This guide walks you through installing the **Google Chrome browser** on Kali Linux using the command line interface (CLI). Ideal for headless systems or quick setup via terminal.

---

## 📥 Step 1: Download Chrome `.deb` Package

Use `wget` to download the latest stable version of Google Chrome for 64-bit systems:

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```

---

## 🛠️ Step 2: Install Chrome via `apt`

Install the downloaded `.deb` package using `apt`:

```bash
sudo apt update
sudo apt install ./google-chrome-stable_current_amd64.deb -y
```

If you encounter dependency issues, run:

```bash
sudo apt --fix-broken install -y
sudo apt install ./google-chrome-stable_current_amd64.deb -y
```

---

## 🚀 Step 3: Launch Google Chrome

After successful installation, launch Chrome using:

```bash
google-chrome
```

If you're in a graphical environment, it should also appear in your **Applications Menu > Internet**.

---

## 🧰 Optional Tips

### Add Chrome to Favorites (GUI)
In desktop environments like XFCE or GNOME, right-click Chrome in the application launcher and choose “Add to Favorites” or “Pin to Taskbar.”

### Run Chrome in Headless Mode (for testing)
```bash
google-chrome --headless --disable-gpu --screenshot https://example.com
```

---

## 📚 References

- [https://www.google.com/chrome/](https://www.google.com/chrome/)
- [Kali Linux Official Site](https://www.kali.org/)

---

**Maintained by: Christen Reinhart**  
**Purpose**: Quick CLI guide for installing Chrome on Kali Linux  
