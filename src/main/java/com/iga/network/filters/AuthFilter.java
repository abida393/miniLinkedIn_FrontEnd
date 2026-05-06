package com.iga.network.filters;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * AuthFilter: Protects authenticated pages.
 * Redirects to login if no token exists in session.
 */
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        String token = (session != null) ? (String) session.getAttribute("authToken") : null;

        if (token == null || token.isEmpty()) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/pages/login.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {}
}
