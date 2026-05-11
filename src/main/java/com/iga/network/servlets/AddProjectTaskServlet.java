package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AddProjectTaskServlet: Creates a new task inside a project.
 * Mapped to: POST /api/projects/tasks/add
 */
public class AddProjectTaskServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        String token = (session != null) ? (String) session.getAttribute("authToken") : null;

        if (token == null || token.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Unauthorized. Please log in.\"}");
            return;
        }

        String projectIdStr = request.getParameter("projectId");
        String title        = request.getParameter("title");
        String assignedTo   = request.getParameter("assigned_to");

        if (projectIdStr == null || title == null || title.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"projectId and title are required.\"}");
            return;
        }

        try {
            int projectId = Integer.parseInt(projectIdStr);
            JSONObject body = new JSONObject();
            body.put("title", title);
            if (assignedTo != null && !assignedTo.isEmpty()) {
                body.put("assigned_to", Integer.parseInt(assignedTo));
            }

            JSONObject result = ApiClient.createProjectTask(token, projectId, body);
            int statusCode = result.optInt("statusCode", 200);
            response.setStatus(statusCode);
            response.getWriter().write(result.toString());
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid ID format.\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            response.getWriter().write(error.toString());
        }
    }
}
