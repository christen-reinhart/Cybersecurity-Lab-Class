# 🗃️ SQLite Pocket Reference Guide

**Authors**:  
Lee Crognale, Sarah Edwards (mac4n6.com), Heather Mahalik (smarterforensics.com)  
**Version**: 2.0  
**Source**: SANS FOR518 & FOR585 | Forensic SQLite Analysis

---

## 📖 Overview

SQLite is a self-contained, file-based database format frequently used across macOS, iOS, Android, and many applications for storing structured data. This reference provides a memory-jog for queries, data types, operators, and common analysis tasks.

---

## 📁 Database Structure & Files

- SQLite databases are single files with the magic string: `SQLite format 3`.
- **Journal Files** (default): backup of data before a transaction, used for recovery.
- **Write Ahead Logs (WAL)**: new changes are written here first and committed to the DB later.
- Temporary files may be created in support of transactions.

---

## 🧪 SQLite Analysis Tools

| Tool | Description |
|------|-------------|
| [DB Browser for SQLite](https://sqlitebrowser.org) | GUI for Mac/Win/Linux |
| [sqlite3](https://sqlite.org/cli.html) | CLI tool |
| [SQLite Spy](https://www.yunqa.de/delphi/products/sqlitespy/index) | Windows GUI |
| Sanderson Forensics Toolkit | Commercial Windows tool |
| [SQLite Miner](https://github.com/threeplanetssoftware/sqlite_miner) | Script to extract BLOBs |
| Commercial Forensic Suites | Often include SQLite viewers |

---

## 🔢 Data Types

- `NULL`: Null value
- `INTEGER`: Signed integer
- `REAL`: Floating-point number
- `TEXT`: UTF-8, UTF-16BE/LE
- `BLOB`: Binary data (images, audio, gzip, etc.)

---

## ➗ Operators

### Arithmetic
- `+` Add
- `-` Subtract
- `*` Multiply
- `/` Divide
- `%` Modulo

### Comparison
- `=` or `==`, `!=` or `<>`, `<`, `<=`, `>`, `>=`

### Logical
- `IS`, `IS NOT`, `IN`, `NOT IN`, `LIKE`, `GLOB`, `BETWEEN`, `AND`, `OR`

---

## 🔍 Basic SQL Queries

```sql
SELECT * FROM A_TABLE;
SELECT COLUMN_A, COLUMN_B FROM A_TABLE;
SELECT COUNT(*) FROM A_TABLE;
SELECT CONTACT, MESSAGE FROM CHAT WHERE CONTACT LIKE '%Hank%';
```

### Aggregating & Sorting
```sql
SELECT MESSAGES, COUNT(*) FROM CHAT GROUP BY CONTACT;
SELECT * FROM CHAT ORDER BY A_TIMESTAMP ASC;
```

### Aliasing Columns
```sql
SELECT ZAWKWARDCOLUMNNAME AS "Chat Messages" FROM A_TABLE;
```

---

## 🧱 Table Joins

### LEFT JOIN
Returns all rows from the left table and matched rows from the right.

```sql
SELECT Z1.ZTEXT, Z2.ZNAME
FROM ZVIBERMESSAGE Z1
LEFT JOIN ZATTACHMENT Z2 ON Z2.Z_PK = Z1.ZATTACHMENT;
```

### INNER JOIN
Returns rows where both tables match.

```sql
SELECT * FROM TABLE1 JOIN TABLE2 ON TABLE1.ID = TABLE2.ID;
```

---

## 🕓 Timestamp Conversion

### Unix Epoch (seconds)
```sql
SELECT datetime(timestamp_column, 'unixepoch');
```

### Unix Epoch (milliseconds)
```sql
SELECT datetime(timestamp_column/1000, 'unixepoch');
```

### Mac Absolute Time
```sql
SELECT datetime(timestamp_column + 978307200, 'unixepoch');
```

### Chrome/Webkit (microseconds since 1601)
```sql
SELECT datetime(timestamp_column/1000000 + strftime('%s','1601-01-01'), 'unixepoch');
```

---

## 💻 sqlite3 CLI Tips

```bash
sqlite3 <db_file>
.tables                -- list all tables
.headers on            -- show column names
.mode column           -- display mode
.output results.txt    -- redirect output
.dump                  -- dump contents
.quit                  -- exit
```

---

## 🧹 Deletion Recovery

- SQLite uses `free pages` and Booleans to track deletions.
- Use hex view or specialized tools to recover deleted data.

### Tools
- [SQLite Deleted Records Parser](https://github.com/mdegrazia/SQLite-Deleted-Records-Parser)

---

## �� References

- [Official SQLite Docs](https://sqlite.org)
- [SQLite Tutorial](https://www.tutorialspoint.com/sqlite/)
- [SQLiteTutorial.net](http://www.sqlitetutorial.net/)
- [Zetcode SQLite Guide](http://zetcode.com/db/sqlite/)
- [Sanderson Forensics](http://sandersonforensics.com/)

---

**Maintained by: Christen Reinhart**  
**Converted from: SQLite Pocket Reference Guide (FOR518/FOR585)**  
**Original Authors: Lee Crognale, Sarah Edwards, Heather Mahalik**
