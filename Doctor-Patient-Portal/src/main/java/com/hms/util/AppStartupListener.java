package com.hms.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Connection;
import com.hms.db.DBConnection;
import com.hms.db.DBInitializer;

@WebListener
public class AppStartupListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Don't use try-with-resources if you have a static/singleton connection!
        Connection conn = DBConnection.getConn();
        DBInitializer.createTables(conn);
        System.out.println("✓ Tables verified/created on application startup.");
    }
    @Override
    public void contextDestroyed(ServletContextEvent sce) { }
}
