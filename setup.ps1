# Payroll System Setup Script for PowerShell
# Run this to automatically setup your environment

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Payroll System - Java Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get project root
$projectRoot = Get-Location
$libFolder = Join-Path $projectRoot "lib"
$configFile = Join-Path $projectRoot "config.properties"

# Create lib folder
if (!(Test-Path $libFolder)) {
    Write-Host "Creating lib folder..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $libFolder | Out-Null
    Write-Host "✓ lib folder created" -ForegroundColor Green
}

# Check MySQL driver
$driverPath = Join-Path $libFolder "mysql-connector-java-5.1.49.jar"
if (!(Test-Path $driverPath)) {
    Write-Host ""
    Write-Host "MySQL JDBC Driver NOT FOUND" -ForegroundColor Red
    Write-Host "This is required to run the application!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please download from:" -ForegroundColor Yellow
    Write-Host "  https://dev.mysql.com/downloads/connector/j/" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Download: mysql-connector-java-5.1.49.jar" -ForegroundColor Yellow
    Write-Host "Save to: $libFolder" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "✓ MySQL JDBC Driver found" -ForegroundColor Green
}

# Check config.properties
if (!(Test-Path $configFile)) {
    Write-Host ""
    Write-Host "config.properties NOT FOUND" -ForegroundColor Red
    Write-Host "Creating from template..." -ForegroundColor Yellow
    
    $templateFile = Join-Path $projectRoot "config.properties.example"
    if (Test-Path $templateFile) {
        Copy-Item $templateFile $configFile
        Write-Host "✓ config.properties created" -ForegroundColor Green
        Write-Host "  Please edit it with your MySQL password:" -ForegroundColor Yellow
        Write-Host "  - Open: $configFile" -ForegroundColor Cyan
        Write-Host "  - Update: db.password=your_password" -ForegroundColor Cyan
    }
} else {
    Write-Host "✓ config.properties found" -ForegroundColor Green
}

# Compile project
Write-Host ""
Write-Host "Compiling Java files..." -ForegroundColor Yellow

if (!(Test-Path "build\classes")) {
    New-Item -ItemType Directory -Path "build\classes" -Force | Out-Null
}

$classpath = "`"lib\*`""
& javac -d build/classes -cp $classpath src/*.java 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Compilation successful" -ForegroundColor Green
} else {
    Write-Host "✗ Compilation failed - check errors above" -ForegroundColor Red
}

# Next steps
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Download MySQL JDBC Driver:" -ForegroundColor Yellow
Write-Host "   https://dev.mysql.com/downloads/connector/j/" -ForegroundColor Cyan
Write-Host "   Save to: $libFolder" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Setup MySQL Database:" -ForegroundColor Yellow
Write-Host "   mysql -u root -p < setup.sql" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Edit config.properties:" -ForegroundColor Yellow
Write-Host "   Update db.password with your MySQL password" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. Run the application:" -ForegroundColor Yellow
Write-Host "   java -cp `"build\classes;lib\*`" Login" -ForegroundColor Cyan
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
