# Payroll System - Java Application

## 📝 Overview
A desktop-based payroll management system built with Java Swing and MySQL. Designed for managing employee information, attendance tracking, and salary calculations.

## ✨ Features
- **User Authentication** - Secure login system with database validation
- **Employee Management** - Add, update, and list employees with complete details
- **Attendance Tracking** - Record and manage employee daily attendance
- **Salary Management** - Calculate and generate employee payslips
- **Database Integration** - MySQL backend for persistent data storage

## 🛠️ Technologies Used
- **Language:** Java SE
- **GUI Framework:** Swing & AWT
- **Database:** MySQL
- **Build Tool:** Apache Ant
- **IDE:** NetBeans
- **JDBC:** MySQL JDBC Driver

## 📋 Prerequisites
- Java Development Kit (JDK) 8 or higher
- MySQL Server 5.7 or higher
- NetBeans IDE (optional, can use command line with Ant)
- MySQL JDBC Driver (com.mysql.jdbc.Driver)

## 🚀 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/Gayatriv196/Payroll-System-JAVA.git
cd Payroll-System-JAVA
```

### 2. Setup MySQL Database
```sql
-- Create database
CREATE DATABASE ps;
USE ps;

-- Create login table
CREATE TABLE login (
    username VARCHAR(100) PRIMARY KEY,
    password VARCHAR(100) NOT NULL
);

-- Create employee table
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

-- Create attendance table
CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id VARCHAR(50),
    attendance_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (emp_id) REFERENCES employee(id)
);

-- Create salary table
CREATE TABLE salary (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id VARCHAR(50),
    base_salary DOUBLE,
    bonus DOUBLE,
    deductions DOUBLE,
    net_salary DOUBLE,
    FOREIGN KEY (emp_id) REFERENCES employee(id)
);

-- Insert default login credentials
INSERT INTO login VALUES ('admin', 'admin123');
```

### 3. Configure Database Credentials
```bash
# Copy the example config file
cp config.properties.example config.properties

# Edit config.properties with your database credentials
# Open config.properties and update:
# db.user=your_mysql_user
# db.password=your_mysql_password
# db.url=jdbc:mysql://localhost:3306/ps (update host/port if different)
```

### 4. Compile and Run

**Using NetBeans:**
- Open the project in NetBeans
- Build: Run → Build Main Project (F11)
- Run: Run → Run Main Project (F6)

**Using Command Line:**
```bash
# Build the project
ant build

# Run the application
ant run

# Or compile and run directly
javac -d build/classes src/*.java
java -cp build/classes:lib/mysql-connector.jar Login
```

## 📖 Usage

1. **Launch Application:** Run Login.java
2. **Login:** Use default credentials (username: `admin`, password: `admin123`)
3. **Main Dashboard:** Access different modules through the menu bar:
   - **Master Menu:**
     - New Employee: Add new employees to the system
     - Salary: Manage employee salary details
     - List Employee: View all registered employees
   - **Reports Menu:**
     - Take Attendance: Record employee attendance
     - List Attendance: View attendance records
     - Pay Slip: Generate and view employee payslips
4. **Update Information:** Edit employee and salary details as needed

## 📊 Project Structure
```
Payroll-System-JAVA/
├── src/                      # Java source files
│   ├── Login.java           # User authentication module
│   ├── Project.java         # Main application window & menu
│   ├── NewEmployee.java     # Add new employee form
│   ├── ListEmployee.java    # Display all employees
│   ├── UpdateEmployee.java  # Modify employee information
│   ├── Salary.java          # Salary management module
│   ├── UpdateSalary.java    # Update salary information
│   ├── PaySlip.java         # Generate payslips
│   ├── TakeAttendance.java  # Record attendance
│   ├── ListAttendance.java  # View attendance records
│   ├── Conn.java            # Database connection manager
│   ├── Splash.java          # Application splash screen
│   └── icon/                # Application icons and images
├── nbproject/               # NetBeans project configuration
├── build.xml                # Ant build configuration
├── config.properties        # Database config (Git ignored)
├── config.properties.example # Configuration template
├── manifest.mf              # Java manifest file
└── README.md               # This file
```

## 🔒 Security Notes
- **Database Credentials:** Stored in `config.properties` (excluded from Git via `.gitignore`)
- **Never commit** `config.properties` to public repositories
- **Always use** `config.properties.example` as template
- Default login credentials should be changed after first use
- Use strong passwords for database user accounts
- Consider implementing role-based access control for production use

## 🐛 Troubleshooting

### Database Connection Issues
- Verify MySQL is running: `mysql -u root -p`
- Check database exists: `SHOW DATABASES;`
- Ensure `config.properties` has correct credentials
- Verify JDBC driver is in classpath

### Missing Icons
- Ensure `src/icon/` folder contains all required image files
- Check file paths in source code match actual icon files

### Class Not Found Errors
- Rebuild project: `ant clean build`
- Verify all Java files are in `src/` folder
- Check Java version compatibility

## 🚧 Future Improvements
- [ ] Enhanced user role management (Admin, Manager, Employee)
- [ ] Export payslips to PDF format
- [ ] Email payslips directly to employees
- [ ] Advanced reporting with filters and date ranges
- [ ] Database backup and restore functionality
- [ ] Migrate to modern UI framework (JavaFX)
- [ ] REST API backend for multi-client support
- [ ] User interface improvements and dark mode
- [ ] Input validation and error handling enhancements
- [ ] Audit logging for all transactions

## 📧 Author & Contact
- **Developer:** V Gayatri
- **Email:** gayatriv196@gmail.com
- **GitHub:** [@Gayatriv196](https://github.com/Gayatriv196)

## 📄 License
This project is created for educational and professional use. Feel free to modify and distribute as needed.

## 💡 Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support
For issues, questions, or suggestions, please:
- Open an issue on GitHub
- Email the author
- Check existing documentation

---
**Last Updated:** May 28, 2026
