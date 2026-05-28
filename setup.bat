@echo off
REM Setup script for Payroll System Java Application
REM This script downloads the MySQL JDBC driver and compiles the project

echo.
echo ========================================
echo Payroll System Setup Script
echo ========================================
echo.

REM Check if lib directory exists
if not exist "lib" (
    echo Creating lib directory...
    mkdir lib
)

REM Check if MySQL driver already exists
if not exist "lib\mysql-connector-java-5.1.49.jar" (
    echo.
    echo Downloading MySQL JDBC Driver...
    echo Note: You need curl or wget installed, or download manually from:
    echo   https://dev.mysql.com/downloads/connector/j/
    echo.
    
    REM Try to download using curl (if available)
    curl -o "lib\mysql-connector-java-5.1.49.jar" "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.49.zip"
    
    if errorlevel 1 (
        echo.
        echo WARNING: Could not download driver automatically.
        echo Please manually download MySQL JDBC Driver:
        echo   1. Go to: https://dev.mysql.com/downloads/connector/j/
        echo   2. Download "mysql-connector-java-5.1.49.jar"
        echo   3. Place it in: lib\ folder
        echo.
        pause
    )
)

REM Compile the project
echo.
echo Compiling Java files...
if not exist "build\classes" mkdir build\classes

javac -d build\classes -cp "lib\*" src\*.java

if errorlevel 0 (
    echo.
    echo Build successful!
    echo.
    echo To run the application:
    echo   java -cp "build\classes;lib\*" Login
    echo.
) else (
    echo.
    echo Build failed! Check errors above.
    echo.
)

pause
