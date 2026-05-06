package com.iga.network.utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String apiBaseUrl = sce.getServletContext().getInitParameter("API_BASE_URL");
        if (apiBaseUrl != null) {
            ApiClient.setBaseUrl(apiBaseUrl);
            System.out.println("IGA Network: API Base URL initialized to " + apiBaseUrl);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {}
}
