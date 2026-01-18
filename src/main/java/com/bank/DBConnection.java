package com.bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import io.github.cdimascio.dotenv.Dotenv;

public class DBConnection {

    private static final Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();

    public static Connection getConnection() {
        try {
            String url = getEnvVariable("DB_URL");
            String user = getEnvVariable("DB_USER");
            String password = getEnvVariable("DB_PASSWORD");

            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Database connection failed", e);
        }
    }

    private static String getEnvVariable(String key) {
        String value = System.getenv(key);

        if (value == null) {
            value = dotenv.get(key);
        }
        
        return value;
    }
}