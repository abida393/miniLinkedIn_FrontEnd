<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    String contextPath = request.getContextPath();
    HttpSession navSession = request.getSession(false);
    String navUserName  = navSession != null && navSession.getAttribute("userName")  != null ? (String) navSession.getAttribute("userName")  : "Academic User";
    String navUserEmail = navSession != null && navSession.getAttribute("userEmail") != null ? (String) navSession.getAttribute("userEmail") : "";
    String navUserRole  = navSession != null && navSession.getAttribute("userRole")  != null ? (String) navSession.getAttribute("userRole")  : "RESEARCHER";
    String navAvatarSeed = navUserEmail.isEmpty() ? "default" : navUserEmail.replace("@", "-");
    String navAvatarUrl  = "https://api.dicebear.com/7.x/avataaars/svg?seed=" + navAvatarSeed;
    boolean navIsAdmin = "ADMIN".equals(navUserRole);
%>
<!-- Top Navigation -->
<nav class="sticky top-0 z-50 bg-[#0d1117] border-b border-white/5 px-6 py-3 flex items-center justify-between">
    <div class="flex items-center space-x-6 flex-1">
        <a href="<%= contextPath %>/pages/home.jsp" class="text-blue-500 font-bold text-xl tracking-tight shrink-0">IGA Network</a>
        <div class="relative w-full max-w-md hidden md:block">
            <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-white/30">
                <i data-lucide="search" class="w-4 h-4"></i>
            </span>
            <input type="text" placeholder="Search research, peers..." 
                class="w-full bg-[#161b22] border border-white/5 rounded-full py-2 pl-12 pr-4 text-sm text-white focus:outline-none focus:ring-1 focus:ring-blue-500/50 transition-all">
        </div>
    </div>
    <div class="flex items-center space-x-6">
        <button class="text-white/50 hover:text-white transition-colors"><i data-lucide="mail" class="w-5 h-5"></i></button>
        <button onclick="window.location.href='<%= contextPath %>/pages/notifications.jsp'" class="text-white/50 hover:text-white transition-colors relative">
            <i data-lucide="bell" class="w-5 h-5"></i>
            <span id="nav-notif-dot" class="absolute top-0 right-0 w-2 h-2 bg-blue-500 rounded-full border-2 border-[#0d1117] hidden"></span>
        </button>
        <a href="<%= contextPath %>/pages/profile.jsp">
            <img src="<%= navAvatarUrl %>" alt="<%= navUserName %>" class="w-8 h-8 rounded-full border border-white/10 cursor-pointer">
        </a>
        <% if (navIsAdmin) { %>
        <a href="<%= contextPath %>/pages/admin.jsp" class="text-white/50 hover:text-white transition-colors">
            <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
        </a>
        <% } %>
    </div>
</nav>

<script>
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>
