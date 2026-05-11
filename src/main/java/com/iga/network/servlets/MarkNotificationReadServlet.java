package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * MarkNotificationReadServlet: Mark a specific notification as read
 * POST /api/notifications/{notification}/read
 */
public class MarkNotificationReadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String token = (session != null) ? (String) session.getAttribute("authToken") : null;

        if (token == null || token.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"Not authenticated\"}");
            return;
        }

        try {
            String notificationId = request.getParameter("notificationId");
            if (notificationId == null || notificationId.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("application/json");
                response.getWriter().write("{\"error\": \"notificationId parameter required\"}");
                return;
            }

            JSONObject result = ApiClient.post("/notifications/" + notificationId + "/read", null, token);
            response.setContentType("application/json");
            response.getWriter().write(result.toString());

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            response.setContentType("application/json");
            response.getWriter().write(error.toString());
        }
    }
}
