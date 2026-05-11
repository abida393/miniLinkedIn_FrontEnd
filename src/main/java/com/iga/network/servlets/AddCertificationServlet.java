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
 * AddCertificationServlet: Adds a new certification to the current user's profile.
 * Mapped to: POST /api/profile/certifications/add
 */
public class AddCertificationServlet extends HttpServlet {

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

        String title      = request.getParameter("title");
        String issuer     = request.getParameter("issuer");
        String issueDate  = request.getParameter("issue_date");
        String expDate    = request.getParameter("expiry_date");
        String credId     = request.getParameter("credential_id");
        String credUrl    = request.getParameter("credential_url");

        if (title == null || title.isEmpty() || issuer == null || issuer.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"title and issuer are required.\"}");
            return;
        }

        try {
            JSONObject body = new JSONObject();
            body.put("title", title);
            body.put("issuer", issuer);
            if (issueDate != null && !issueDate.isEmpty())  body.put("issue_date", issueDate);
            if (expDate   != null && !expDate.isEmpty())    body.put("expiry_date", expDate);
            if (credId    != null && !credId.isEmpty())     body.put("credential_id", credId);
            if (credUrl   != null && !credUrl.isEmpty())    body.put("credential_url", credUrl);

            JSONObject result = ApiClient.addCertification(token, body);
            int statusCode = result.optInt("statusCode", 200);
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
