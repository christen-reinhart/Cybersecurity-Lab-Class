
# 🧠 Ubuntu + Zeek + RITA v5 Setup Guide (Docker-Based)

This guide outlines the installation of Zeek and RITA v5 on an Ubuntu Desktop VM using Docker, designed to eliminate dependency issues with older versions. This is ideal for use in a cybersecurity lab for network traffic analysis and threat hunting.

---

## 📥 Prerequisites

- [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Download Ubuntu Desktop ISO](https://ubuntu.com/download/desktop)
- [Install Docker](https://docs.docker.com/engine/install/ubuntu/)
- [Install Docker Compose (v2+)](https://docs.docker.com/compose/install/)

---

## 💻 Step 1: Create an Ubuntu VM in VirtualBox

1. Open **VirtualBox** → Click **New**.
2. Configure:
   - **Name**: `Ubuntu-Zeek-RITA`
   - **Type**: Linux
   - **Version**: Ubuntu (64-bit)
   - **Memory**: 4096 MB (recommended)
   - **CPU**: 2 Cores minimum
   - **Video Memory**: 128 MB
   - **Disk**: VDI, Dynamically Allocated, 40 GB+

---

## 🔧 Step 2: Install Docker and Docker Compose

```bash
# Update and install required packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y ca-certificates curl gnupg lsb-release

# Add Docker GPG key and repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg]   https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable Docker without sudo (optional)
sudo usermod -aG docker $USER
newgrp docker

# Test Docker
docker --version
docker compose version
```

---

## 📦 Step 3: Setup Zeek and RITA Environment

1. **Create Project Directory**:

```bash
mkdir ~/zeek-rita-lab && cd ~/zeek-rita-lab
```

2. **Create `docker-compose.yml`**:

```yaml
version: '3'
services:
  zeek:
    image: blacktop/zeek
    volumes:
      - ./pcaps:/pcaps
    entrypoint: ["zeek", "-r", "/pcaps/yourfile.pcap"]
    networks:
      - zeeknet

  clickhouse:
    image: clickhouse/clickhouse-server:latest
    ports:
      - "8123:8123"
      - "9000:9000"
    networks:
      - zeeknet

  rita:
    image: activecm/rita:5
    volumes:
      - ./zeek_logs:/zeek_logs
      - ./rita_data:/rita_data
    depends_on:
      - clickhouse
    environment:
      - CLICKHOUSE_HOST=clickhouse
    networks:
      - zeeknet

networks:
  zeeknet:
```

3. **Place PCAP File**:

```bash
mkdir pcaps && cp ~/Downloads/yourfile.pcap ./pcaps/
```

4. **Run Zeek to Parse PCAP**:

```bash
docker compose run zeek
```

5. **Import into RITA**:

```bash
docker compose run rita import /zeek_logs/default ./rita_data
```

6. **Analyze with RITA**:

```bash
docker compose run rita analyze ./rita_data
docker compose run rita show-beacons ./rita_data
```

---

## 🧪 Sample Use Case

1. Download malware PCAPs from [malware-traffic-analysis.net](https://www.malware-traffic-analysis.net/).
2. Run `zeek` over the PCAP.
3. Import results into `rita`.
4. Run `rita analyze` and view beaconing, scan detection, and communication stats.

---

## 📋 Final Notes

- Make sure your PCAP files are placed in the `pcaps` directory.
- You may rebuild RITA/Zeek containers anytime using `docker compose down && docker compose up`.
- Use `docker exec -it <container_id> bash` for manual inspection inside containers.

---

## 📚 References

- [Zeek Network Security Monitor](https://zeek.org/)
- [RITA by Active Countermeasures](https://www.activecountermeasures.com/free-tools/rita/)
- [Docker Installation Guide](https://docs.docker.com/engine/install/ubuntu/)
- [ClickHouse Docs](https://clickhouse.com/docs/en/)
- [VirtualBox Manual](https://www.virtualbox.org/manual/UserManual.html)

---

**Author**: Christen Reinhart  
**Project**: Cybersecurity Lab Class Repository


# Additional Content from previous installation notes

# Lab Report: Installing RITA v5 and Zeek (Docker) on Ubuntu 24.04 for Threat Hunting

## 1. Setting Up Ubuntu 24.04 on VMware Workstation Pro

To begin, we install Ubuntu 24.04 LTS in a virtual machine using VMware Workstation Pro. This provides a clean 64-bit Linux environment to host RITA and Zeek. Follow these steps to get the base system ready:

Create a New VM: In VMware Workstation Pro, create a new virtual machine and select the Ubuntu 24.04 64-bit ISO as the installation media. Allocate sufficient resources (e.g., 2 CPUs, 4 GB RAM, ~20 GB disk) to accommodate Docker and Zeek usage. Use NAT or Bridged Networking so the VM can access the internet for package downloads.

Install Ubuntu 24.04: Boot the VM from the ISO and go through the Ubuntu installer. Choose a normal or minimal installation (either is fine for a server setup), create a username/password, and complete the OS installation with default settings.

Post-Install Configuration: After the VM reboots into Ubuntu, log in and open a terminal. Update the system to the latest packages:

 bash

sudo apt update && sudo apt upgrade -y

This ensures all repositories and packages (including kernel) are up-to-date. Optionally, install VMware guest additions or open-vm-tools for better VM integration (copy-paste, etc.).

Networking Check: Verify the VM has internet connectivity (e.g., run ping -c4 google.com). Internet access is required to download RITA and Docker components.

At this point, we have a base Ubuntu 24.04 system updated and ready for software installation. Next, we'll install RITA v5.0.0-beta and its dependencies.

## 2. Installing RITA v5.0.0-beta (with Docker Integration)

RITA (Real Intelligence Threat Analytics) version 5 introduces a Dockerized installation to avoid dependency issues across OS versions​. We will use the official installer script to set up RITA 5.0.0-beta, which will also handle installing Zeek (in Docker) and the database backend. The high-level process is:

Download the RITA installer tarball for v5.0.0-beta from Active Countermeasures (either from the official website or GitHub releases).

Extract and run the install script with appropriate parameters.

Handle any prompts or errors during installation (select network interface for Zeek monitoring, provide sudo password, etc.).

Verify that RITA and dependencies (Docker, Zeek) are installed.

Step-by-Step Installation:

Download and Extract RITA: Place the installer tarball (e.g., rita-5.0.0-beta-installer.tar.gz) on the Ubuntu VM. Then extract it:

 bash

tar -xf rita-5.0.0-beta-installer.tar.gz

```bash
cd rita-5.0.0-beta-installer/
```

Run the Installer Script: Execute the installation script with localhost as the target (to install on the local machine):

 bash

sudo ./install_rita.sh localhost

This script will install RITA's components on the local host​. Provide your sudo password when prompted (the script uses elevated privileges to install packages and Docker containers). The script may output progress as it sets up RITA.

Select Zeek Capture Interface: During install, you'll be prompted to choose a network interface for Zeek to monitor traffic​. Use arrow keys to highlight the primary interface (e.g., ens33 on VMware) and press space to select it​, then Enter to confirm. (This configures Zeek for live traffic capture, which we won’t immediately use for PCAP analysis but is part of setup.)

Installation Completes: The installer will take care of installing Docker (if not already present), the RITA binaries, and pulling/setting up required Docker containers (including Zeek and the ClickHouse database for RITA). Once done, it might indicate a successful installation. It may also suggest running zeek start (to begin live packet capture) – do not run this yet, since our focus is processing offline PCAPs.

Handling Installation Issues: RITA’s installer generally automates the setup, but a couple of errors might be encountered:

Docker Socket Permission Error: If, after installation, using RITA or Zeek yields an error like “Got permission denied while trying to connect to the Docker daemon socket”, it means your user cannot access Docker. This is common if the installer added Docker but the current user isn’t in the docker group. The fix is to add your user to the docker group and re-evaluate group membership:

 bash

sudo usermod -aG docker $USER

Then log out and log back in (or run su - $USER) to apply the new group membership​. This allows running Docker (and thus RITA/Zeek which use Docker) without using sudo each time.

Missing Zeek Wrapper Script: RITA v5 uses a wrapper script named zeek to interact with the Zeek Docker container​. The installer should place this script in /usr/local/bin, but if zeek is not found after installation, we can install it manually:

 bash

sudo wget -O /usr/local/bin/zeek https://raw.githubusercontent.com/activecm/docker-zeek/master/zeek

```bash
sudo chmod +x /usr/local/bin/zeek
```

This downloads the official zeek wrapper from Active Countermeasures’ repository and makes it executable​. The wrapper allows us to run Zeek via Docker as if it were a local command.

After addressing any issues, we should have RITA v5 installed on the system. The rita command should be available (try rita --help or rita version), and the zeek command (wrapper) should also be in place. In the next section, we’ll verify that Docker and Zeek are functioning properly.

## 3. Verifying Docker and Zeek (Post-Install Checks)

Before analyzing any traffic, ensure that Docker and the Zeek integration are working as expected:

Verify Docker Installation: Check Docker’s version and run a test container.

 bash

docker --version

```bash
docker run hello-world
```

The first command should output the Docker version, and the second will pull a test image and print “Hello from Docker” if everything is configured correctly. If you see a permission error on the Docker socket, confirm your user is in the docker group (as noted above)​.

Docker Service Status: Docker should be running in the background. You can verify with systemctl status docker (it should show active (running)). The RITA installer typically starts Docker for you; if not, start it manually: sudo systemctl start docker.

Verify the Zeek Wrapper: Test that the zeek command (wrapper) is functional. For example:

 bash

zeek --help

This should display Zeek’s help or usage information, indicating the wrapper script is correctly invoking the Zeek container. If the command is not found or errors, re-download the wrapper as shown above. Once working, you essentially have Zeek “installed” via Docker – none of Zeek’s binaries are on the host, but the wrapper will spin up a Zeek container as needed.

(Optional) Test Zeek Live Capture: If you want to confirm Zeek can run, you can start Zeek in live mode (listening on the interface you selected during install) by running:

 bash

zeek start

This should launch the Docker container named zeek in the background. You can check docker ps to see a container (e.g., activecm/zeek:<version>) running. Zeek will begin logging live traffic to /opt/zeek/logs/<date>/ by default. We will not rely on live capture for this lab, so you may stop it with zeek stop. The key takeaway is that the Zeek deployment in Docker is functioning.

At this stage, we have confirmed that Docker is functional and the Zeek wrapper is set up. We are ready to use Zeek to process captured traffic files (PCAPs). Next, we’ll organize our files and parse the sample APT1 traffic.

## 4. Organizing PCAP and Log Directories

For a clean workflow, it’s helpful to separate packet capture files and the resulting Zeek logs into structured directories. We set up two main directories in our home folder:

PCAP Directory: ~/pcaps/apt1 – this will store the PCAP files related to the APT1 threat scenario.

Zeek Logs Directory: ~/zeek_logs/apt1_24hr – Zeek will output its parsed logs from those PCAPs into this folder.

Use the following commands to create these directories:

bash

mkdir -p ~/pcaps/apt1

mkdir -p ~/zeek_logs/apt1_24hr

The naming here indicates that the PCAPs correspond to an APT1 24-hour traffic capture (APT1 is a known threat actor used in this example). By organizing this way, if we later analyze additional scenarios, we can create separate subfolders for their PCAPs and Zeek logs, keeping data segregated.

Handling Multiple PCAP Files: If the APT1 dataset comes as multiple PCAP files (for example, split by hour or network segment), you have two options:

Place all the PCAP files in ~/pcaps/apt1 and let the Zeek wrapper process them together.

Merge the PCAPs into one file using a tool like mergecap before processing. For instance:

 bash

mergecap -w apt1_full.pcap apt1_part1.pcap apt1_part2.pcap ...

This command combines multiple captures into apt1_full.pcap​. You would then put apt1_full.pcap in ~/pcaps/apt1 for analysis.

With the directory structure ready, we’ll proceed to obtaining the actual APT1 traffic capture files.

## 5. Downloading the APT1 Sample PCAPs

For this lab, we use a dataset of network traffic associated with the APT1 adversary. Active Countermeasures (the creators of RITA) have made sample PCAPs available (for training and testing threat hunting tools). We downloaded the APT1 24-hour PCAP from Active Countermeasures’ resources and placed it into our ~/pcaps/apt1/ directory.

How to get the PCAP: Typically, such PCAPs can be obtained from the Active Countermeasures website or a training portal. In our case, we acquired a file (or set of files) representing 24 hours of traffic involving APT1 intrusion activity. If the PCAP was provided as a zip or archive, extract it into the ~/pcaps/apt1 directory. For example, if you have APT1_24hr.zip:

bash

unzip APT1_24hr.zip -d ~/pcaps/apt1

After this, ensure the PCAP files (e.g., APT1_24hr.pcap or multiple .pcap files) are present in ~/pcaps/apt1. We will use Zeek to parse these files in the next step.

(For the purposes of this report, we assume the PCAP file is named apt1_24hr.pcap inside the ~/pcaps/apt1 directory. Adjust the filenames in commands according to your actual downloaded files.)

## 6. Parsing PCAP Files with Zeek (via Docker Wrapper)

With the PCAP(s) in place, our next task is to generate Zeek logs from the raw traffic. Instead of a native Zeek installation, we use RITA’s Docker-enabled Zeek wrapper script (zeek) to process the PCAP. This approach abstracts away the actual Zeek container – we interact with it through the wrapper, which handles running Zeek inside Docker and writing out logs.

Command Syntax: The wrapper expects two arguments: an input directory (or file) and an output directory. The general syntax is:

bash

```bash
zeek readpcap <pcap_input_path> <zeek_output_path>
```

This is a slight change from traditional Zeek usage. Normally, one would run zeek -r <file.pcap> in the current directory​. In RITA v5’s setup, we specify directories: the wrapper will feed any PCAPs in the input path to Zeek and drop the logs in the output path. As the RITA v5 introduction notes, “with our Zeek wrapper script, the format is slightly different... just a little more typing but you get a bit more flexibility.”​

Parse the APT1 PCAP:

Run Zeek with the following command (if there are multiple PCAP files, we use a wildcard *.pcap to include all of them):

bash

```bash
zeek readpcap ~/pcaps/apt1/*.pcap ~/zeek_logs/apt1_24hr
```

This will launch the Zeek Docker container behind the scenes and have it process all PCAP files in ~/pcaps/apt1​. The logs will be written to ~/zeek_logs/apt1_24hr. Key points about this operation:

The wrapper will create the output directory if it doesn’t exist (we created it already), similar to how the example script on Windows uses mkdir then runs zeek readpcap​.

The readpcap argument is not a standard Zeek option but a feature of the wrapper script, which tells the container to read from pcap instead of live interface​.

All standard Zeek log files are generated. This typically includes conn.log (connections), dns.log, http.log, ssl.log, files.log, etc., depending on the traffic content, as well as summary logs like weird.log or notice.log if any anomalies were detected by Zeek.

The time it takes to complete will depend on the size of the PCAP. For a large 24-hour capture, Zeek may take a few minutes to parse everything. Once the command finishes (returning to the shell prompt), verify that Zeek logs are present in ~/zeek_logs/apt1_24hr. You can list files in that directory to confirm, for example:

bash

```bash
ls -lh ~/zeek_logs/apt1_24hr
```

You should see multiple .log (or .log.gz) files corresponding to different protocol logs. For instance, conn.log, dns.log, http.log, etc., each containing records of network activities captured in the PCAP. Now that we have Zeek’s output, we can move on to importing this data into RITA for analysis.

## 7. Importing Zeek Logs into RITA

RITA is designed to ingest Zeek logs and hunt for signs of command-and-control (C2) traffic. In RITA v5, the import process is also containerized under the hood (using a ClickHouse database for storage), but the user-facing command is straightforward. We will use the rita import command with the --logs and --database flags to import our Zeek log set:

bash

rita import --logs ~/zeek_logs/apt1_24hr --database APT1_24hr

Breaking down this command: the --logs (or -l) option points to the directory of Zeek logs we just produced, and the --database (or -d) option gives a name to this dataset (we chose APT1_24hr for clarity)​. RITA will create a database by that name and begin parsing the logs into it.

What happens during import:

RITA will spin up its necessary containers (if not already running). For example, it will ensure a ClickHouse database container is running to store data, and possibly a rita-syslog-ng container to assist in log parsing (these start automatically on import). You might see messages about containers starting/running in the output.

It reads each Zeek log file in the specified directory. RITA v5 supports Zeek logs in JSON or TSV format; by default, Zeek produces TSV (tab-separated values) logs. The import process will parse these and ingest the records into the database.

Progress information is displayed in the terminal. For instance, RITA may list each log file as it’s processed and indicate when parsing is complete for that file. (In earlier versions, you’d see lines like “Parsing conn.log -> database name...” for each file​. In v5, the output format may be slightly different, but the concept is the same.)

When finished, you should see a summary that the dataset has been imported successfully.

After the import finishes, it’s good practice to verify that the data is in RITA’s database:

Run rita list to see the list of datasets RITA knows about:

 bash

rita list

You should see APT1_24hr listed, with a status indicating it’s not a rolling dataset (since we imported a static 24hr set) and showing the time range of the logs included. For example, RITA might output a table with columns for Name, Rolling (true/false), and Time Range (UTC) for the dataset【29†】. This confirms our data is loaded and ready for analysis.

With the logs imported, we can proceed to use RITA’s analysis capabilities to identify threat patterns in the APT1 traffic.

## 8. Analyzing the APT1 24hr Traffic with RITA

Now comes the threat hunting part: using RITA to find beaconing or other C2 indicators in the APT1 dataset. RITA v5 introduces a new text-based user interface (TUI) built on BubbleTea (a Go library for rich terminal UIs), which consolidates multiple analysis results into one interactive view​​. Even when running via SSH or a local terminal, RITA will present results in an ASCII-art table format for easier reading. We will focus on beacon analysis results, as APT1 is known for establishing persistent C2 channels.

After importing, you can launch RITA’s analysis interface. One way is by running a show command such as:

bash

rita show-beacons APT1_24hr

This command traditionally would list detected beaconing connections for the specified dataset. In RITA v5, it triggers the interactive interface showing all findings, with beacons highlighted (since RITA v5 combines multiple detection categories in one view). Ensure your terminal is large enough, as RITA will draw a table with several columns.

RITA v5 Analysis Interface (Beacon Results): The screenshot above shows an example of RITA’s output interface after analyzing a dataset. Each row represents a potentially suspicious communication. Notably, the columns include Severity, Source, Destination, Beacon Score, Duration, Subdomains, and Threat Intel. RITA assigns a severity level to each finding (Critical, High, Medium, Low) based on how strongly it matches threat criteria​. In our APT1_24hr analysis, RITA immediately flagged a beaconing connection with Critical severity. This was an internal IP repeatedly contacting an external host on a regular schedule throughout the 24-hour period. The Beacon column showed a nearly 100% beacon score (indicating extremely periodic behavior), and the Duration column reflected that this communication persisted for almost the entire capture window (e.g., over 23 hours). Such a high score and long duration are classic signs of beaconing C2 traffic.

Interacting with the interface, if you select a specific row (using arrow keys), a detail pane (on the right side) reveals additional context for that connection. For instance, in the example above, selecting the critical beacon entry displays the source IP (e.g., an internal server), the destination IP or domain it was contacting, Threat Modifiers (none in this case), Prevalence (how many connections, e.g., 17k connections), First Seen time, Connection Count total, Total Bytes exchanged, and the port/protocol (e.g., 123/udp for an NTP example)【23†】. This detail confirms the nature of the traffic. In the APT1 scenario, the suspicious beacon was over HTTP (TCP) to an external Command-and-Control server, with regular beacon intervals. RITA’s analysis pinpointed the source host and the C2 IP, giving us critical information to investigate (e.g., we now know which internal machine is likely compromised and where it was beaconing out to).

RITA v5’s unified interface also integrates other analysis modules. While the focus here was on beaconing, the interface can show long connections (connections that stayed up for a long time), strobes (bursty, frequent connections), DNS tunneling attempts, and any hits on threat intelligence blacklists (flagging known bad IPs or domains) all in one place​. In our 24hr dataset, aside from the primary beacon, RITA noted a few long connections and multiple DNS queries to suspicious domains (APT1 malware often uses DNS for C2). Each of these would be listed with appropriate severity. For example, a steady 24-hour long TLS connection might be listed as High severity if unusual, and DNS exfiltration patterns might appear with indicators under the Subdomains or Threat Intel columns (if domain matched a blacklist).

After reviewing the results in the TUI, you can exit the interface (usually by pressing q or Ctrl+C). RITA also provides commands to output results to the console or files for reporting. For instance, to get a text dump of beacon findings you can run:

bash

rita show-beacons APT1_24hr -H | less -S

The -H flag includes headers in the output, and piping to less -S allows scrolling horizontally if needed​. RITA can even generate an HTML report via rita html-report APT1_24hr for a more shareable format.

Summary of APT1 Findings: In this lab, the RITA analysis of the APT1 24-hour traffic clearly identified malicious beaconing behavior. The top result was a critical severity beacon, with nearly constant periodic outbound connections from an internal host to a suspect external address. The beacon’s characteristics (high frequency, long duration, consistent interval) matched the profile of automated C2 communication. This illustrates the power of RITA + Zeek: by parsing raw traffic with Zeek and analyzing it with RITA’s algorithms, we rapidly uncovered hidden threats in the network data. In a real environment, these results would prompt an immediate investigation into the flagged source machine and the external entity it was communicating with.

## 9. Conclusion and Notes

We have successfully installed and configured a threat hunting environment on Ubuntu 24.04 using RITA v5.0.0-beta and Zeek (via Docker). Starting from a fresh OS on VMware, we installed Docker and used RITA’s installer to deploy all components in containerized form, ensuring portability and avoiding dependency issues across OS versions​. We then demonstrated how to use the new Zeek wrapper script to parse PCAP files (zeek readpcap), a workflow change introduced in RITA v5​​. Organizing PCAPs and logs into directories made it straightforward to import data into RITA with a single command​. Finally, using RITA’s enhanced ASCII interface, we observed the analysis results, notably identifying beaconing communications with critical severity in the APT1 dataset.

This lab showed a complete, repeatable process for setting up a threat hunting lab and analyzing network traffic for threats. By following these steps, one can investigate other PCAP datasets or even live network traffic (by running Zeek in live capture mode) and leverage RITA’s analytics to hunt for signs of compromise.

Sources:

Active Countermeasures RITA GitHub (installation and usage)​​

Active Countermeasures blogs (RITA v5 introduction and usage)​​​​

ActiveCM Docker-Zeek repository (Zeek wrapper script)​

DigitalOcean Docker post-install tips (non-root Docker usage)​