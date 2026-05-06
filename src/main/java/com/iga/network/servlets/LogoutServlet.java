package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import javax.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String token = (String) session.getAttribute("authToken");
            try {
                if (token != null) ApiClient.logout(token);
            } catch (Exception ignored) {}
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }
}
