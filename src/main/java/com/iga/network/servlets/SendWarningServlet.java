package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.BufferedReader;

public class SendWarningServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;
        if (!"ADMIN".equals(userRole)) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("{\"error\": \"Forbidden: Admin access required\"}");
            return;
        }

        String userIdStr = null;
        String message   = null;

        try {
            String contentType = request.getContentType();

            if (contentType != null && contentType.contains("application/json")) {
                // JSON body — read from stream only
                StringBuilder sb = new StringBuilder();
                String line;
                BufferedReader reader = request.getReader();
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }

                if (sb.length() > 0) {
                    JSONObject body = new JSONObject(sb.toString());
                    if (body.has("userId"))  userIdStr = String.valueOf(body.getInt("userId"));
                    if (body.has("message")) message   = body.getString("message");
                }

            } else {
                // Form params — use getParameter() only, never mix with getReader()
                userIdStr = request.getParameter("userId");
                message   = request.getParameter("message");
            }

            if (userIdStr == null || userIdStr.isEmpty() || message == null || message.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"userId and message are required\"}");
                return;
            }

            int userId;
            try {
                userId = Integer.parseInt(userIdStr);
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"userId must be a valid integer\"}");
                return;
            }

            JSONObject result = ApiClient.sendWarning(token, userId, message);
            response.getWriter().write(result.toString());

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage() != null ? e.getMessage() : "Unknown server error");
            response.getWriter().write(error.toString());
        }
    }
}