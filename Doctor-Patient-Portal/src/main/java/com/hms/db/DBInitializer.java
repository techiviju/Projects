package com.hms.db;
import java.sql.Connection;
import java.sql.Statement;

public class DBInitializer {
    public static void createTables(Connection conn) {
        try (Statement stmt = conn.createStatement()) {
            stmt.execute(
                "CREATE TABLE IF NOT EXISTS user_details ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "full_name VARCHAR(45) NOT NULL, "
                + "email VARCHAR(45) NOT NULL UNIQUE, "
                + "password VARCHAR(45), "
                + "registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                + ")"
            );
            stmt.execute(
                "CREATE TABLE IF NOT EXISTS doctor ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "fullName VARCHAR(45), "
                + "dateOfBirth VARCHAR(45), "
                + "qualification VARCHAR(45), "
                + "specialist VARCHAR(45), "
                + "email VARCHAR(45), "
                + "phone VARCHAR(45), "
                + "password VARCHAR(45)"
                + ")"
            );
            stmt.execute(
                "CREATE TABLE IF NOT EXISTS appointment ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "userId INT, "
                + "fullName VARCHAR(45), "
                + "gender VARCHAR(45), "
                + "age VARCHAR(45), "
                + "appointmentDate VARCHAR(45), "
                + "email VARCHAR(45), "
                + "phone VARCHAR(45), "
                + "diseases VARCHAR(45), "
                + "doctorId INT, "
                + "address VARCHAR(45), "
                + "status VARCHAR(45)"
                + ")"
            );
            stmt.execute(
                "CREATE TABLE IF NOT EXISTS specialist ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "specialist_name VARCHAR(45)"
                + ")"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
