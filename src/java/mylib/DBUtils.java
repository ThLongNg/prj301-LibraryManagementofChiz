package mylib;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtils {
//    Do not change this code
    private static final String DB_NAME = "library_system";
    private static final String DB_USER_NAME = "SA";
    private static final String DB_PASSWORD = "12345";

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection conn = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // THAY ĐỔI DÒNG NÀY:
        String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DB_NAME + ";encrypt=false;"; 
        // Hoặc có thể thêm encrypt=false nếu bạn muốn tắt hoàn toàn mã hóa:
        // String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DB_NAME + ";;";trustServerCertificate=true
        
        conn = DriverManager.getConnection(url, DB_USER_NAME, DB_PASSWORD);
        return conn;
    }
}