import java.sql.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class Conn {

    public Connection c;
    public Statement s;

    public Conn() {
        try {
            Properties props = new Properties();
            
            // Load database configuration from config.properties
            try (FileInputStream fis = new FileInputStream("config.properties")) {
                props.load(fis);
            } catch (IOException e) {
                System.err.println("ERROR: config.properties not found!");
                System.err.println("Please ensure config.properties exists in the project root directory.");
                System.err.println("You can copy it from config.properties.example");
                throw new RuntimeException("Configuration file missing", e);
            }
            
            String driverClass = props.getProperty("db.driver", "com.mysql.jdbc.Driver");
            String dbUrl = props.getProperty("db.url", "jdbc:mysql://localhost:3306/ps");
            String dbUser = props.getProperty("db.user", "root");
            String dbPassword = props.getProperty("db.password", "");
            
            // Load JDBC driver
            try {
                Class.forName(driverClass);
            } catch (ClassNotFoundException e) {
                System.err.println("ERROR: MySQL JDBC Driver not found!");
                System.err.println("Please download mysql-connector-java-5.1.49.jar");
                System.err.println("Place it in: lib/ folder");
                System.err.println("Download from: https://dev.mysql.com/downloads/connector/j/");
                throw new RuntimeException("JDBC Driver not found", e);
            }
            
            // Create connection using credentials from config file
            try {
                c = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                s = c.createStatement();
                System.out.println("✓ Database connected successfully!");
            } catch (SQLException e) {
                System.err.println("ERROR: Cannot connect to database!");
                System.err.println("Database URL: " + dbUrl);
                System.err.println("User: " + dbUser);
                System.err.println("Please check:");
                System.err.println("  1. MySQL server is running");
                System.err.println("  2. Database 'ps' exists");
                System.err.println("  3. Username and password are correct in config.properties");
                throw new RuntimeException("Database connection failed", e);
            }

        } catch (Exception e) {
            System.err.println("\n" + "=".repeat(60));
            System.err.println("DATABASE CONNECTION ERROR");
            System.err.println("=".repeat(60));
            e.printStackTrace();
            System.err.println("=".repeat(60));
        }
    }
}
