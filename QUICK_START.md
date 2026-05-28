# Quick Start Guide - 5 Minutes to Running

## The Issue: Missing MySQL JDBC Driver

Your application wasn't showing output because **the MySQL JDBC driver was missing**. Without it, the app crashes when trying to connect to the database.

---

## ✅ Quick Fix (Choose One Method)

### Method 1: Windows Batch Script (Easiest)
```powershell
# Run from project folder
.\setup.bat
```

### Method 2: PowerShell Script
```powershell
# Run from project folder
.\setup.ps1
```

### Method 3: Manual Setup (5 minutes)

#### Step 1: Download Driver (1 min)
- Go to: https://dev.mysql.com/downloads/connector/j/
- Download: `mysql-connector-java-5.1.49.jar`
- Save to: `Payroll-System-JAVA\lib\`

#### Step 2: Setup Database (2 min)
```powershell
# Open MySQL command line
mysql -u root -p

# Paste this (enter your password when prompted):
```
```sql
CREATE DATABASE ps;
USE ps;
CREATE TABLE login (username VARCHAR(100) PRIMARY KEY, password VARCHAR(100));
INSERT INTO login VALUES ('admin', 'admin123');
```

#### Step 3: Configure App (1 min)
```powershell
# Copy config from template
copy config.properties.example config.properties

# Edit config.properties
# Change: db.password=mysql123 (to your actual password)
```

#### Step 4: Compile & Run (1 min)
```powershell
# Compile
javac -d build/classes -cp "lib\*" src\*.java

# Run
java -cp "build\classes;lib\*" Login
```

---

## 📋 What's Missing?

| Component | Status | Fix |
|-----------|--------|-----|
| Java Source Code | ✅ Present | - |
| MySQL JDBC Driver | ❌ **MISSING** | Download & place in `lib/` |
| Database | ❌ **Not Created** | Run setup.sql in MySQL |
| config.properties | ⚠️ Created | Update with your password |

---

## 🎯 Expected Result After Fix

When you run the application:
1. ✅ Login window appears with username/password fields
2. ✅ "Database connected successfully!" appears in console
3. ✅ You can login with: `admin` / `admin123`

---

## ⚠️ Common Mistakes

❌ **Don't forget to:**
- Place MySQL driver in `lib/` folder (not anywhere else)
- Create the `ps` database in MySQL
- Update password in `config.properties` if different from `mysql123`
- Run commands from project root folder

---

## 🆘 Still Not Working?

1. Check console output for error messages
2. Read `TROUBLESHOOTING.md` for detailed solutions
3. Verify MySQL service is running:
   ```powershell
   Get-Service MySQL80
   ```

---

**Everything else is already set up! Just add the driver and you're done.** 🚀
