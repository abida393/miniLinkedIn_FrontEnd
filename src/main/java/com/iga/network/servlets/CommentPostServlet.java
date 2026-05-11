package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.BufferedReader;

/**
 * CommentPostServlet: Add a comment to a post
 * POST /api/posts/comment
 *
 * FIX: Previously mixed getParameter() and getReader() on the same request.
 * Calling getParameter() first can consume the input stream, leaving getReader()
 * empty. Now reads everything from the JSON body only.
 *
 * Expected JSON body: { "postId": 123, "content": "..." }
 */
public class CommentPostServlet extends HttpServlet {

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

        // FIX: Read postId from the JSON body, not from getParameter(),
        // so the input stream is only consumed once.
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        JSONObject requestBody;
        try {
            requestBody = new JSONObject(sb.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid JSON body\"}");
            return;
        }

        String postId = requestBody.optString("postId", "");
        if (postId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"postId is required in request body\"}");
            return;
        }

        try {
            JSONObject result = ApiClient.post("/posts/" + postId + "/comment", requestBody, token);
            response.getWriter().write(result.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            response.getWriter().write(error.toString());
        }
    }
}