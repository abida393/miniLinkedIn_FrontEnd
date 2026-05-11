package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import com.iga.network.models.User;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return;
        }

        try {
            JSONObject result = ApiClient.login(email, password);
            int statusCode = result.getInt("statusCode");

            if (statusCode == 200) {
                JSONObject data = result.getJSONObject("data");
                String token = data.optString("token", data.optString("access_token", ""));
                User user = User.fromJson(data.optJSONObject("user"));

                if (token.isEmpty()) {
                    request.setAttribute("error",
                            "Login successful but no token received. Response: " + data.toString());
                    request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
                    return;
                }

                // FIX: Invalidate any existing session before creating a new one
                // to prevent session fixation attacks.
                //HttpSession oldSession = request.getSession(false);
                //if (oldSession != null) {
                  //  oldSession.invalidate();
                //}

                HttpSession session = request.getSession(true);
                session.setAttribute("authToken", token);

                if (user != null) {
                    session.setAttribute("userId", user.getId());
                    session.setAttribute("userName", user.getFullName());
                    session.setAttribute("userRole", user.getRole());
                    session.setAttribute("userEmail", user.getEmail());

                    if ("ADMIN".equals(user.getRole())) {
                        response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
                }

            } else {
                String errorMsg = "Invalid credentials (Status: " + statusCode + ")";
                if (result.has("data")) {
                    JSONObject errorData = result.getJSONObject("data");
                    if (errorData.has("message"))
                        errorMsg = errorData.getString("message");
                }
                request.setAttribute("error", errorMsg);
                request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            String detailedError = "System Error: " + e.getMessage();
            if (e.getCause() != null)
                detailedError += " (Cause: " + e.getCause().getMessage() + ")";
            request.setAttribute("error", detailedError);
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
    }
}