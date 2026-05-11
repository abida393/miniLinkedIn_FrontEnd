<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    String path = request.getContextPath();
    String title = (String) request.getAttribute("pageTitle");
    if (title == null) title = "MiniLinkedIn";
    String apiBaseUrl = application.getInitParameter("API_BASE_URL");
%>
<script>
    window.IGA_CONFIG = {
        apiBaseUrl: '<%= apiBaseUrl != null ? apiBaseUrl : "http://localhost:8000/api" %>'
    };
</script>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= title %></title>
    
    <!-- Favicon -->
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🎓</text></svg>">
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        linkedin: {
                            blue: '#0a66c2',
                            darkBlue: '#004182',
                            lightBlue: '#eef3f8',
                            gray: '#666666',
                        },
                    }
                }
            }
        }
    </script>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Lucide Icons -->
    <script src="https://cdn.jsdelivr.net/npm/lucide@0.344.0/dist/umd/lucide.min.js"></script>
    
    <!-- Custom Styles -->
    <link rel="stylesheet" href="<%= path %>/assets/css/main.css">
    
    <!-- Frontend JavaScript Libraries -->
    <script src="<%= path %>/assets/js/api.js"></script>
    <script src="<%= path %>/assets/js/utils.js"></script>
    <script src="<%= path %>/assets/js/render.js"></script>
    <script src="<%= path %>/assets/js/event-handlers.js"></script>

    <!-- Sync server HttpSession → client sessionStorage for JS auth checks -->
    <script>
        (function() {
            <%
                HttpSession userSess = request.getSession(false);
                if (userSess != null && userSess.getAttribute("authToken") != null) {
                    String jsToken  = (String) userSess.getAttribute("authToken");
                    String jsUserId = String.valueOf(userSess.getAttribute("userId"));
            %>
                sessionStorage.setItem('authToken', '<%= jsToken %>');
                sessionStorage.setItem('iga_user_id', '<%= jsUserId %>');
            <% } %>
        })();
    </script>
</head>