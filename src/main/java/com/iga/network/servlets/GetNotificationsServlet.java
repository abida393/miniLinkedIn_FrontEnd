package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * GetNotificationsServlet: Get user's notifications (paginated)
 * GET /api/notifications
 */
public class GetNotificationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        String token = (session != null) ? (String) session.getAttribute("authToken") : null;

        if (token == null || token.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Not authenticated\"}");
            return;
        }

        try {
            // Get query parameters
            String page = request.getParameter("page");
            String perPage = request.getParameter("per_page");
            String isRead = request.getParameter("is_read");

            StringBuilder endpoint = new StringBuilder("/notifications");
            boolean hasParams = false;

            if (page != null && !page.isEmpty()) {
                endpoint.append(hasParams ? "&" : "?").append("page=").append(page);
                hasParams = true;
            }
            if (perPage != null && !perPage.isEmpty()) {
                endpoint.append(hasParams ? "&" : "?").append("per_page=").append(perPage);
                hasParams = true;
            }
            if (isRead != null && !isRead.isEmpty()) {
                endpoint.append(hasParams ? "&" : "?").append("is_read=").append(isRead);
            }

            JSONObject result = ApiClient.get(endpoint.toString(), token);
            response.getWriter().write(result.toString());

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            response.getWriter().write(error.toString());
        }
    }
}
