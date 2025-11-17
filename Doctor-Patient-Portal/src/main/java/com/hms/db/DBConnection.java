
//package com.hms.db;
//
//import java.sql.Connection;
//import java.sql.DriverManager;
//
//public class DBConnection {
//
//	private static Connection conn;
//	
//	public static Connection getConn() {
//		
//		try {
//			
//			//step:1 for connection - load the driver class 
//			Class.forName("com.mysql.cj.jdbc.Driver");
//			
//			//step:2- create a connection
//			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitaldb","root","Zx@12345");
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			// TODOxxxxxxx: handle exception
//		}
//		
//		return conn;
//	}
//}



 package com.hms.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static volatile Connection conn;

    public static Connection getConn() {
        if (conn != null) return conn;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String dbName = System.getenv("MYSQLDATABASE");
            String user = System.getenv("MYSQLUSER");
            String password = System.getenv("MYSQLPASSWORD");

            // Local fallback for dev
            if (host == null) host = "localhost";
            if (port == null) port = "3306";
            if (dbName == null) dbName = "hospitaldb";
            if (user == null) user = "root";
            if (password == null) password = "Zx@12345";

            String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?useSSL=false&serverTimezone=UTC";
            conn = DriverManager.getConnection(url, user, password);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    private DBConnection() {}
}
