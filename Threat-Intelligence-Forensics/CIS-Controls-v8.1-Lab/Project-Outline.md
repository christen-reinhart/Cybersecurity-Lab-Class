
# 🛡️ CIS Controls v8.1 Lab: Implementing Foundational Cyber Hygiene

## 📘 Overview

This lab is designed to introduce learners to the [CIS Controls v8.1](https://www.cisecurity.org/controls/v8-1), focusing on Implementation Group 1 (IG1), which represents essential cyber hygiene practices. By the end of this lab, participants will have hands-on experience in implementing key security controls on a Windows 10 system.

## 🎯 Objectives

- Understand the structure and purpose of the CIS Controls v8.1.
- Implement selected IG1 controls on a Windows 10 environment.
- Utilize tools like Autopsy for forensic analysis.
- Document and reflect on the implementation process.

## 🧰 Prerequisites

- A Windows 10 system (physical or virtual machine).
- Administrative privileges on the system.
- Internet access to download necessary tools.
- Basic understanding of Windows OS operations.

## 🛠️ Tools and Resources

- [CIS Controls v8.1 Documentation](https://www.cisecurity.org/controls/v8-1)
- [Autopsy](https://www.sleuthkit.org/autopsy/)
- [Windows Sysinternals Suite](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite)
- [Windows Security Baselines](https://www.microsoft.com/en-us/download/details.aspx?id=55319)

## 🧪 Lab Steps

### 1. 📥 Download and Review CIS Controls v8.1

- Navigate to the [CIS Controls v8.1](https://www.cisecurity.org/controls/v8-1) page.
- Download the PDF version of the controls.
- Familiarize yourself with the 18 controls, focusing on those categorized under IG1.

### 2. ��️ Implement Selected IG1 Controls

We'll focus on the following controls for this lab:

#### Control 1: Inventory and Control of Enterprise Assets
- Use Windows PowerShell to list all connected devices.
- Document the inventory in a spreadsheet.

#### Control 2: Inventory and Control of Software Assets
- List all installed software using PowerShell.
- Identify and remove unauthorized or unnecessary software.

#### Control 4: Secure Configuration of Enterprise Assets and Software
- Apply Microsoft's security baselines using the Security Compliance Toolkit.
- Ensure configurations align with recommended settings.

#### Control 5: Account Management
- Review all user accounts on the system.
- Disable or remove inactive or unnecessary accounts.

#### Control 8: Audit Log Management
- Enable auditing for key system events via Local Security Policy.
- Use Event Viewer to monitor and analyze logs.

### 3. 🔍 Utilize Autopsy for Forensic Analysis

- Install Autopsy on your Windows 10 system.
- Create a new case and add your system's disk image or a specific directory for analysis.
- Use Autopsy to analyze logs and verify the implementation of the above controls.

### 4. 📝 Document Your Findings

For each control implemented, document:

- The steps taken.
- Challenges encountered.
- Screenshots or logs as evidence.
- Reflections on the importance of the control.

## 📂 Submission Guidelines

- Create a folder named `CIS_Controls_Lab` in your GitHub repository.
- Include:
  - A markdown file `Lab_Report.md` with your documentation.
  - Any scripts or tools used.
  - Screenshots or logs as evidence.

## 📚 Additional Resources

- [CIS Implementation Groups Explained](https://www.cisecurity.org/controls/implementation-groups)
- [Autopsy Forensics Tutorials (YouTube)](https://www.youtube.com/results?search_query=autopsy+forensics+tutorial)
- [Windows Security Compliance Toolkit](https://www.microsoft.com/en-us/download/details.aspx?id=55319)

---

By completing this lab, you'll gain practical experience in implementing foundational cybersecurity controls, enhancing your understanding and readiness to protect systems against common threats.
