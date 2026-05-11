package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class GetAdminUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");

        HttpSession session = request.getSession(false);
        String token = (session != null) ? (String) session.getAttribute("authToken") : null;

        if (token == null || token.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Not authenticated\"}");
            return;
        }

        // FIX: Verify the caller is actually an admin.
        String userRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equals(userRole)) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("{\"error\": \"Forbidden: Admin access required\"}");
            return;
        }

        try {
            String pageStr = request.getParameter("page");
            int page;
            try {
                page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
            } catch (NumberFormatException e) {
                page = 1;
            }

            String role   = request.getParameter("role");
            String status = request.getParameter("status");

            JSONObject result = ApiClient.getAdminUsers(token, page, role, status);
            response.getWriter().write(result.toString());

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            response.getWriter().write(error.toString());
        }
    }
}