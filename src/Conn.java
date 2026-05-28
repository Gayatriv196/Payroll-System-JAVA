import java.sql.*;
import java.io.FileInputStream;
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
            }
            
            // Load JDBC driver
            Class.forName(props.getProperty("db.driver", "com.mysql.jdbc.Driver"));
            
            // Create connection using credentials from config file
            String dbUrl = props.getProperty("db.url", "jdbc:mysql://localhost:3306/ps");
            String dbUser = props.getProperty("db.user", "root");
            String dbPassword = props.getProperty("db.password", "");
            
            c = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            s = c.createStatement();
            
            System.out.println("Database connected successfully!");

        } catch (Exception e) {
            System.err.println("Database Connection Error:");
            e.printStackTrace();
        }
    }
}
