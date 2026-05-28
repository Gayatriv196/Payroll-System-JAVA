# Troubleshooting Guide - Payroll System Not Running

## Problem: Application not displaying anything or crashing silently

### Common Issues & Solutions

---

## ✅ Issue 1: Missing MySQL JDBC Driver

**Symptoms:**
- Application doesn't start
- No error visible (silent failure)
- ClassNotFoundException for com.mysql.jdbc.Driver

**Solution:**
1. Download MySQL JDBC Driver:
   - Go to: https://dev.mysql.com/downloads/connector/j/
   - Download: **mysql-connector-java-5.1.49.jar**

2. Place JAR file in `lib/` folder:
   ```
   Payroll-System-JAVA/
   └── lib/
       └── mysql-connector-java-5.1.49.jar
   ```

3. Compile with driver in classpath:
   ```powershell
   javac -d build/classes -cp "lib\*" src\*.java
   ```

4. Run with driver in classpath:
   ```powershell
   java -cp "build\classes;lib\*" Login
   ```

---

## ✅ Issue 2: Database Connection Failed

**Symptoms:**
- Login window appears
- Error message: "Cannot connect to database"
- Error about "ps" database not found

**Solution:**

### Step 1: Verify MySQL is Running
```powershell
# Check if MySQL is running
Get-Service MySQL80

# Start MySQL if not running
Start-Service MySQL80
```

### Step 2: Create Database & Tables
```sql
-- Connect to MySQL
mysql -u root -p

-- Run these SQL commands:
CREATE DATABASE ps;
USE ps;

CREATE TABLE login (
    username VARCHAR(100) PRIMARY KEY,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE employee (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id VARCHAR(50),
    attendance_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (emp_id) REFERENCES employee(id)
);

CREATE TABLE salary (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id VARCHAR(50),
    base_salary DOUBLE,
    bonus DOUBLE,
    deductions DOUBLE,
    net_salary DOUBLE,
    FOREIGN KEY (emp_id) REFERENCES employee(id)
);

INSERT INTO login VALUES ('admin', 'admin123');
```

### Step 3: Verify config.properties
```properties
# File: config.properties
db.driver=com.mysql.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/ps
db.user=root
db.password=mysql123
```

---

## ✅ Issue 3: config.properties Not Found

**Symptoms:**
- Error: "config.properties not found"
- Application won't start

**Solution:**

```powershell
# From project root directory:
cd "c:\Users\gayat\OneDrive\Desktop\Payroll-System-JAVA"

# Copy template to actual config
copy config.properties.example config.properties

# Edit config.properties with your MySQL credentials
# Update: db.password=your_actual_mysql_password
```

---

## ✅ Issue 4: Compilation Errors

**Symptoms:**
- Compilation fails with error messages
- Cannot compile Java files

**Solution:**

```powershell
# Recompile with verbose output
javac -d build/classes -cp "lib\*" -verbose src\*.java

# Check for syntax errors
javac -d build/classes src\*.java 2>&1 | findstr /i "error"
```

---

## ✅ Issue 5: Icons Not Loading (GUI appears broken)

**Symptoms:**
- Login window appears but no icons/images
- Missing images in buttons

**Solution:**

1. Check if icons folder exists:
   ```powershell
   ls "src\icon\"
   ```

2. Ensure you compile from project root with proper classpath:
   ```powershell
   javac -d build/classes src\*.java
   ```

3. Run from project root:
   ```powershell
   cd "c:\Users\gayat\OneDrive\Desktop\Payroll-System-JAVA"
   java -cp "build\classes;lib\*" Login
   ```

---

## 🚀 Complete Setup Instructions (Step-by-Step)

### Step 1: Navigate to Project
```powershell
cd "c:\Users\gayat\OneDrive\Desktop\Payroll-System-JAVA"
```

### Step 2: Create lib folder
```powershell
mkdir lib
```

### Step 3: Download MySQL Driver
- Download: https://dev.mysql.com/downloads/connector/j/
- File: mysql-connector-java-5.1.49.jar
- Save to: `lib/` folder

### Step 4: Setup Database
```sql
# In MySQL command line:
CREATE DATABASE ps;
USE ps;
CREATE TABLE login (username VARCHAR(100) PRIMARY KEY, password VARCHAR(100));
INSERT INTO login VALUES ('admin', 'admin123');
# ... (create other tables as shown above)
```

### Step 5: Create config.properties
```powershell
copy config.properties.example config.properties
# Edit config.properties with your MySQL password
```

### Step 6: Compile
```powershell
javac -d build/classes -cp "lib\*" src\*.java
```

### Step 7: Run
```powershell
java -cp "build\classes;lib\*" Login
```

---

## 🔍 Debugging: Enable Debug Output

Create a test file `TestConnection.java`:

```java
import java.sql.*;

public class TestConnection {
    public static void main(String[] args) {
        try {
            System.out.println("1. Loading config...");
            Conn conn = new Conn();
            
            System.out.println("2. Testing database query...");
            ResultSet rs = conn.s.executeQuery("SELECT COUNT(*) FROM login");
            while(rs.next()) {
                System.out.println("3. Login records: " + rs.getInt(1));
            }
            
            System.out.println("✓ Everything works!");
        } catch (Exception e) {
            System.out.println("✗ Error occurred:");
            e.printStackTrace();
        }
    }
}
```

Run it:
```powershell
javac -d build/classes -cp "lib\*" src\TestConnection.java
java -cp "build\classes;lib\*" TestConnection
```

---

## 📞 Need More Help?

If issues persist:
1. Check console output carefully - error messages will tell you the issue
2. Verify MySQL service is running: `Get-Service MySQL*`
3. Ensure config.properties has correct credentials
4. Make sure lib/mysql-connector-java-5.1.49.jar exists
5. Try compiling and running with full paths

---

**Last Updated:** May 28, 2026
