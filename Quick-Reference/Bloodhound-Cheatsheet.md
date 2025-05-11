# 🐺 BloodHound + SharpHound Cheat Sheet

**Author**: Michiel Lemmens (@mchllmmns)  
**Reference**: SANS SEC560 – Network Penetration Testing and Ethical Hacking

---

## 📦 SharpHound Options (Data Collection)

### General Output

- `--OutputDirectory <directory>` – Directory to store JSON files  
- `--OutputPrefix <prefix>` – Prefix for output files  
- `--PrettyJson` – Pretty-print JSON (larger size)  
- `--NoZip` – Skip zipping the JSON  
- `--ZipFileName <name>` – Name of zip file  
- `--EncryptZip` – Adds a random password to the zip  

---

### Collection Methods

| Flag | Description |
|------|-------------|
| `--CollectionMethod` | Group, LocalAdmin, RDP, Trusts, ComputerOnly, DcOnly, All |
| `--d <domain>` | Specify domain |
| `--ExcludeDomainControllers` | Exclude DCs from scan |
| `--ComputerFile <file>` | List of computer names or IPs |
| `--LDAPFilter <filter>` | AD attribute filters |
| `--Stealth` | Low-noise, single-threaded |

---

### Performance Options

| Flag | Description |
|------|-------------|
| `--DomainController` | Specify DC |
| `--Throttle <ms>` | Delay between requests |
| `--Jitter <%>` | Adds randomness to throttle |

---

### Looping Collections

| Flag | Description |
|------|-------------|
| `--Loop` | Enable looped collection |
| `--LoopDuration hh:mm:ss` | Duration of collection |
| `--LoopInterval hh:mm:ss` | Wait time between loops |

---

## 🧪 BloodHound: Setup and Usage

### Download & Install

- SharpHound (C#): [SharpHound3](https://github.com/BloodHoundAD/SharpHound3)  
- SharpHound (PowerShell): [Collectors](https://github.com/BloodHound/Collectors)  
- Python: [BloodHound.py](https://github.com/fox-it/BloodHound.py)  
- Docs: [BloodHound Docs](https://bloodhound.readthedocs.io)

### Usage

1. Start Neo4j
2. Upload `.zip` output from SharpHound into BloodHound GUI
3. Use the menu to access:
   - Analysis queries
   - Pathfinding mode
   - Node metadata
   - Group unrolled paths

---

## 🧠 BloodHound Cypher Queries

### Users

```cypher
MATCH (g:Group) WHERE g.name =~ "(?i).*DOMAIN ADMINS.*"
WITH g MATCH (g)<-[r:MemberOf*1..]-(a)
RETURN a.name
```

**Kerberoastable Users**
```cypher
MATCH (u:User) WHERE u.hasspn=true RETURN u.name
```

**AS-REP Roastable Users**
```cypher
MATCH (u:User {dontreqpreauth: true}) RETURN u.name
```

**Sessions of Domain Admins**
```cypher
MATCH (u:User)-[:MemberOf*1..]->(g:Group)
WHERE g.objectid ENDS WITH '-512'
MATCH p = (c:Computer)-[:HasSession]->(u)
RETURN c.name, u.name
```

### Computers

**OS Version Count**
```cypher
MATCH (c:Computer)
RETURN DISTINCT c.operatingsystem, COUNT(c.operatingsystem)
```

**Windows 2008 by LastLogon**
```cypher
MATCH (c:Computer)
WHERE c.operatingsystem CONTAINS '2008'
RETURN c.name, c.operatingsystem,
datetime({ epochSeconds: toInteger(c.lastlogontimestamp) }) AS rdate
ORDER BY rdate DESC
```

### Groups / Delegation

**Find all GPOs with 'SERVER'**
```cypher
MATCH (g:GPO) WHERE toUpper(g.name) CONTAINS "SERVER" RETURN g
```

**High-value Group Members**
```cypher
MATCH p=(u:User)-[r:MemberOf*1..]->(g:Group {highvalue:true})
RETURN u.name
```

---

## 🧱 Query Syntax Reference

```cypher
MATCH p=(c:Computer)-[r:HasSession]->(u:User {domain: "LAB"})
WHERE c.operatingsystem CONTAINS 'Server'
RETURN c.name, COUNT(*)
```

### Explanation

- `MATCH` — Pattern to search
- `WHERE` — Filters, e.g., `CONTAINS`, `STARTS WITH`, `ENDS WITH`
- `RETURN` — Results, e.g., `DISTINCT`, `COUNT(*)`, `c.name`

---

## 🔗 References

- https://bloodhound.readthedocs.io/en/latest/data-collection/sharphound-all-flags.html  
- https://github.com/BloodHoundAD/BloodHound/releases  
- https://gist.github.com/jeffmcjunkin/7b4a67bb7dd0cfbfbd83768f3aa6eb12  
- https://hausec.com/2019/09/09/bloodhound-cypher-cheatsheet/  
- https://github.com/SadProcessor/Cheats/blob/master/DogWhispererV2.md  
- https://blog.compass-security.com/2020/07/make-the-most-out-of-bloodhound/  
- https://phackt.com/pentesting-bloodhound-cypher-queries  
- https://github.com/awsmhacks/awsmBloodhoundCustomQueries

---

**Converted by: Christen Reinhart**  
**Source: BloodHound Cheat Sheet v1.0**
