package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class UpdateExperienceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        String token = (session != null) ? (String) session.getAttribute("authToken") : null;

        if (token == null || token.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            JSONObject error = new JSONObject();
            error.put("error", "Unauthorized. Please log in.");
            response.getWriter().write(error.toString());
            return;
        }

        String expId = request.getParameter("expId");
        if (expId == null || expId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JSONObject error = new JSONObject();
            error.put("error", "Experience ID is required.");
            response.getWriter().write(error.toString());
            return;
        }

        try {
            int id;
            try {
                id = Integer.parseInt(expId);
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject err = new JSONObject();
                err.put("error", "Invalid experience ID format.");
                response.getWriter().write(err.toString());
                return;
            }

            JSONObject data = new JSONObject();
            String[] fields = {"title", "organization", "location", "start_date", 
                               "end_date", "is_current", "type", "description"};
            for (String field : fields) {
                String value = request.getParameter(field);
                if (value != null && !value.isEmpty()) {
                    data.put(field, value);
                }
            }

            JSONObject result = ApiClient.updateExperience(token, id, data);
            int statusCode = result.has("statusCode") ? result.getInt("statusCode") : 200;
            response.setStatus(statusCode);
            response.getWriter().write(result.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            response.getWriter().write(error.toString());
        }
    }
}
