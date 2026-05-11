package com.iga.network.servlets;

import com.iga.network.utils.ApiClient;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.BufferedReader;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            if (firstName == null || lastName == null || email == null || password == null) {
                request.setAttribute("error", "All fields are required.");
                request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
                return;
            }

            JSONObject requestBody = new JSONObject();
            requestBody.put("first_name", firstName);
            requestBody.put("last_name", lastName);
            requestBody.put("email", email);
            requestBody.put("password", password);
            requestBody.put("role", role != null ? role : "STUDENT");

            JSONObject result = ApiClient.register(requestBody);
            int statusCode = result.getInt("statusCode");

            if (statusCode == 200 || statusCode == 201) {
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp?registered=true");
            } else {
                String errorMsg = "Registration failed.";
                if (result.has("data")) {
                    JSONObject errorData = result.getJSONObject("data");
                    if (errorData.has("message")) errorMsg = errorData.getString("message");
                }
                request.setAttribute("error", errorMsg);
                request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            request.setAttribute("error", "System Error: " + e.getMessage());
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/pages/register.jsp");
    }
}
