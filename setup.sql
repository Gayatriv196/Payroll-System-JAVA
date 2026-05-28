-- Payroll System Database Setup Script
-- Run this in MySQL to create all required tables

-- Create database
CREATE DATABASE IF NOT EXISTS ps;
USE ps;

-- Drop existing tables (optional - uncomment if you want fresh start)
-- DROP TABLE IF EXISTS salary;
-- DROP TABLE IF EXISTS attendance;
-- DROP TABLE IF EXISTS employee;
-- DROP TABLE IF EXISTS login;

-- Create login table
CREATE TABLE IF NOT EXISTS login (
    username VARCHAR(100) PRIMARY KEY,
    password VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create employee table
CREATE TABLE IF NOT EXISTS employee (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create attendance table
CREATE TABLE IF NOT EXISTS attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id VARCHAR(50) NOT NULL,
    attendance_date DATE NOT NULL,
    status VARCHAR(10) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employee(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create salary table
CREATE TABLE IF NOT EXISTS salary (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id VARCHAR(50) NOT NULL,
    base_salary DOUBLE NOT NULL,
    bonus DOUBLE DEFAULT 0,
    deductions DOUBLE DEFAULT 0,
    net_salary DOUBLE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employee(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert default login credentials
INSERT INTO login (username, password) VALUES ('admin', 'admin123') 
ON DUPLICATE KEY UPDATE password='admin123';

-- Insert sample employee (optional)
INSERT INTO employee (id, name, gender, address, city, state, email, phone) 
VALUES ('E001', 'John Doe', 'Male', '123 Main St', 'New York', 'NY', 'john@example.com', '9876543210')
ON DUPLICATE KEY UPDATE name='John Doe';

-- Insert sample salary (optional)
INSERT INTO salary (emp_id, base_salary, bonus, deductions, net_salary)
VALUES ('E001', 50000, 5000, 5000, 50000)
ON DUPLICATE KEY UPDATE net_salary=50000;

-- Verify tables created
SELECT 'Tables created successfully!' AS Status;
SHOW TABLES;

-- Verify data
SELECT 'Login table:' AS '';
SELECT * FROM login;

SELECT 'Employee table:' AS '';
SELECT * FROM employee;
