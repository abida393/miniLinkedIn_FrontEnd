<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String contextPath = request.getContextPath();
    HttpSession navSession = request.getSession(false);
    String navUserName  = navSession != null && navSession.getAttribute("userName")  != null ? (String) navSession.getAttribute("userName")  : "User";
    String navUserEmail = navSession != null && navSession.getAttribute("userEmail") != null ? (String) navSession.getAttribute("userEmail") : "";
    String navUserRole  = navSession != null && navSession.getAttribute("userRole")  != null ? (String) navSession.getAttribute("userRole")  : "";
    String navAvatarSeed = navUserEmail.isEmpty() ? "default" : navUserEmail.replace("@", "-");
    String navAvatarUrl  = "https://api.dicebear.com/7.x/avataaars/svg?seed=" + navAvatarSeed;
    boolean navIsAdmin = "ADMIN".equals(navUserRole);
%>
<nav class="sticky top-0 z-50 bg-white border-b border-gray-200 py-1">
    <div class="max-w-6xl mx-auto px-4 flex items-center justify-between">
        <!-- Logo & Search -->
        <div class="flex items-center space-x-3 flex-1">
            <a href="<%= contextPath %>/pages/home.jsp" class="text-linkedin-blue">
                <i data-lucide="linkedin" class="w-10 h-10 fill-current"></i>
            </a>
            <div class="relative max-w-xs w-full hidden md:block">
                <span class="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-400">
                    <i data-lucide="search" class="w-4 h-4"></i>
                </span>
                <input type="text" placeholder="Search" class="block w-full pl-10 pr-3 py-2 border-none bg-linkedin-lightBlue rounded-md focus:ring-2 focus:ring-linkedin-blue text-sm">
            </div>
        </div>

        <!-- Nav Items -->
        <div class="flex items-center space-x-8 text-gray-500">
            <a href="<%= contextPath %>/pages/home.jsp" class="flex flex-col items-center hover:text-black transition-colors">
                <i data-lucide="home" class="w-6 h-6"></i>
                <span class="text-xs mt-1">Home</span>
            </a>
            <a href="<%= contextPath %>/pages/projects.jsp" class="flex flex-col items-center hover:text-black transition-colors">
                <i data-lucide="briefcase" class="w-6 h-6"></i>
                <span class="text-xs mt-1">Projects</span>
            </a>
            <a href="<%= contextPath %>/pages/messages.jsp" class="flex flex-col items-center hover:text-black transition-colors">
                <i data-lucide="message-square" class="w-6 h-6"></i>
                <span class="text-xs mt-1">Messaging</span>
            </a>
            <a href="<%= contextPath %>/pages/notifications.jsp" class="flex flex-col items-center hover:text-black transition-colors relative">
                <i data-lucide="bell" class="w-6 h-6"></i>
                <span class="text-xs mt-1">Notifications</span>
                <span class="absolute -top-1 right-0 bg-red-600 text-white text-[10px] rounded-full w-4 h-4 flex items-center justify-center border-2 border-white">3</span>
            </a>
            <a href="<%= contextPath %>/pages/profile.jsp" class="flex flex-col items-center hover:text-black transition-colors border-l pl-8">
                <img src="<%= navAvatarUrl %>" alt="<%= navUserName %>" class="w-6 h-6 rounded-full border border-gray-200">
                <div class="flex items-center text-xs mt-1">
                    Me <i data-lucide="chevron-down" class="w-3 h-3 ml-1"></i>
                </div>
            </a>
            <% if (navIsAdmin) { %>
            <a href="<%= contextPath %>/pages/admin.jsp" class="flex flex-col items-center hover:text-black transition-colors">
                <i data-lucide="layout-dashboard" class="w-6 h-6"></i>
                <span class="text-xs mt-1">Admin</span>
            </a>
            <% } %>
        </div>
    </div>
</nav>

<script>
    lucide.createIcons();
</script>
