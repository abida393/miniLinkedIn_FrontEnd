package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * SearchUsersServlet: Search for users
 * GET /api/network/search
 *
 * FIX: Raw user input was appended directly into the API URL, allowing
 * parameter injection (e.g. "foo&role=ADMIN"). Now URL-encoded properly.
 */
public class SearchUsersServlet extends HttpServlet {

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
            String query = request.getParameter("q");
            if (query == null || query.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"q parameter (search query) required\"}");
                return;
            }

            String type = request.getParameter("type");

            // FIX: URL-encode the search query and type to prevent parameter injection.
            String encodedQuery = URLEncoder.encode(query, StandardCharsets.UTF_8.name());
            StringBuilder endpoint = new StringBuilder("/network/search?q=").append(encodedQuery);

            if (type != null && !type.isEmpty()) {
                String encodedType = URLEncoder.encode(type, StandardCharsets.UTF_8.name());
                endpoint.append("&type=").append(encodedType);
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