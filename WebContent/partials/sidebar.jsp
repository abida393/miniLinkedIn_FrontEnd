<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    String sideContextPath = request.getContextPath();
    HttpSession sideSession = request.getSession(false);
    String sideUserName  = sideSession != null && sideSession.getAttribute("userName")  != null ? (String) sideSession.getAttribute("userName")  : "Academic User";
    String sideUserEmail = sideSession != null && sideSession.getAttribute("userEmail") != null ? (String) sideSession.getAttribute("userEmail") : "";
    String sideUserRole  = sideSession != null && sideSession.getAttribute("userRole")  != null ? (String) sideSession.getAttribute("userRole")  : "RESEARCHER";
    String sideAvatarSeed = sideUserEmail.isEmpty() ? "default" : sideUserEmail.replace("@", "-");
    String sideAvatarUrl  = "https://api.dicebear.com/7.x/avataaars/svg?seed=" + sideAvatarSeed;
    
    String currentURI = request.getRequestURI();
%>
<aside class="hidden lg:flex w-72 flex-col space-y-6 shrink-0 h-[calc(100vh-120px)] sticky top-24 overflow-y-auto pr-2">
    <!-- User Card -->
    <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl text-center">
        <div class="relative w-24 h-24 mx-auto mb-4">
            <div class="absolute -inset-1 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-full blur opacity-40"></div>
            <img src="<%= sideAvatarUrl %>" alt="<%= sideUserName %>" class="relative w-24 h-24 rounded-full border-4 border-[#161b22] bg-[#0d1117]">
            <div class="absolute bottom-1 right-1 w-4 h-4 bg-green-500 border-4 border-[#161b22] rounded-full"></div>
        </div>
        <h4 class="font-bold text-lg"><%= sideUserName %></h4>
        <span class="inline-block px-3 py-1 bg-green-500/10 text-green-500 text-[10px] font-bold rounded-full uppercase tracking-widest border border-green-500/20 mt-2"><%= sideUserRole %></span>
        
        <div class="grid grid-cols-3 gap-2 mt-8 pt-6 border-t border-white/5 text-center">
            <div>
                <div id="side-posts-count" class="text-sm font-bold text-white">0</div>
                <div class="text-[8px] font-bold text-white/30 uppercase tracking-widest mt-1">Posts</div>
            </div>
            <div>
                <div id="side-conns-count" class="text-sm font-bold text-white">0</div>
                <div class="text-[8px] font-bold text-white/30 uppercase tracking-widest mt-1">Conns</div>
            </div>
            <div>
                <div id="side-follows-count" class="text-sm font-bold text-white">0</div>
                <div class="text-[8px] font-bold text-white/30 uppercase tracking-widest mt-1">Follows</div>
            </div>
        </div>
    </div>

    <script>
        async function updateSidebarStats() {
            try {
                // Use the frontend API client
                const response = await API.getNetwork();
                if (response.ok) {
                    const stats = response.data.data || response.data;
                    
                    // Update DOM with counts, using multiple potential keys from backend
                    const postsCount = stats.posts_count || stats.posts || stats.total_posts || 0;
                    const connsCount = stats.connections_count || stats.connections || stats.total_connections || 0;
                    const followsCount = stats.followers_count || stats.followers || stats.total_followers || 0;

                    // Simple formatter for large numbers (e.g. 1500 -> 1.5k)
                    const fmt = (num) => {
                        if (num >= 1000) return (num / 1000).toFixed(1).replace(/\.0$/, '') + 'k';
                        return num;
                    };

                    document.getElementById('side-posts-count').textContent = fmt(postsCount);
                    document.getElementById('side-conns-count').textContent = fmt(connsCount);
                    document.getElementById('side-follows-count').textContent = fmt(followsCount);
                }
            } catch (error) {
                console.error('Sidebar Stats Error:', error);
            }
        }
        document.addEventListener('DOMContentLoaded', updateSidebarStats);
    </script>



    <!-- Navigation -->
    <nav class="space-y-1">
        <a href="<%= sideContextPath %>/pages/home.jsp" class="flex items-center space-x-4 px-6 py-4 <%= currentURI.contains("home.jsp") ? "bg-blue-600/10 text-white border border-blue-600/20 shadow-lg shadow-blue-600/10" : "text-white/40 hover:text-white hover:bg-white/5" %> rounded-2xl transition-all">
            <i data-lucide="home" class="w-5 h-5 <%= currentURI.contains("home.jsp") ? "text-blue-500" : "" %>"></i>
            <span class="text-sm font-bold tracking-wide">Home</span>
        </a>
        <a href="<%= sideContextPath %>/pages/network.jsp" class="flex items-center space-x-4 px-6 py-4 <%= currentURI.contains("network.jsp") ? "bg-blue-600/10 text-white border border-blue-600/20 shadow-lg shadow-blue-600/10" : "text-white/40 hover:text-white hover:bg-white/5" %> rounded-2xl transition-all">
            <i data-lucide="compass" class="w-5 h-5 <%= currentURI.contains("network.jsp") ? "text-blue-500" : "" %>"></i>
            <span class="text-sm font-bold tracking-wide">Explore</span>
        </a>
        <a href="<%= sideContextPath %>/pages/projects.jsp" class="flex items-center space-x-4 px-6 py-4 <%= currentURI.contains("projects.jsp") ? "bg-blue-600/10 text-white border border-blue-600/20 shadow-lg shadow-blue-600/10" : "text-white/40 hover:text-white hover:bg-white/5" %> rounded-2xl transition-all">
            <i data-lucide="microscope" class="w-5 h-5 <%= currentURI.contains("projects.jsp") ? "text-blue-500" : "" %>"></i>
            <span class="text-sm font-bold tracking-wide">Projects</span>
        </a>
        <a href="<%= sideContextPath %>/pages/messages.jsp" class="flex items-center space-x-4 px-6 py-4 <%= currentURI.contains("messages.jsp") ? "bg-blue-600/10 text-white border border-blue-600/20 shadow-lg shadow-blue-600/10" : "text-white/40 hover:text-white hover:bg-white/5" %> rounded-2xl transition-all">
            <i data-lucide="message-square" class="w-5 h-5 <%= currentURI.contains("messages.jsp") ? "text-blue-500" : "" %>"></i>
            <span class="text-sm font-bold tracking-wide">Messages</span>
        </a>
        <a href="<%= sideContextPath %>/pages/notifications.jsp" class="flex items-center space-x-4 px-6 py-4 <%= currentURI.contains("notifications.jsp") ? "bg-blue-600/10 text-white border border-blue-600/20 shadow-lg shadow-blue-600/10" : "text-white/40 hover:text-white hover:bg-white/5" %> rounded-2xl transition-all">
            <i data-lucide="bell" class="w-5 h-5 <%= currentURI.contains("notifications.jsp") ? "text-blue-500" : "" %>"></i>
            <span class="text-sm font-bold tracking-wide">Notifications</span>
        </a>
        <a href="<%= sideContextPath %>/pages/profile.jsp" class="flex items-center space-x-4 px-6 py-4 <%= currentURI.contains("profile.jsp") ? "bg-blue-600/10 text-white border border-blue-600/20 shadow-lg shadow-blue-600/10" : "text-white/40 hover:text-white hover:bg-white/5" %> rounded-2xl transition-all">
            <i data-lucide="user" class="w-5 h-5 <%= currentURI.contains("profile.jsp") ? "text-blue-500" : "" %>"></i>
            <span class="text-sm font-bold tracking-wide">Profile</span>
        </a>
    </nav>

    <button class="w-full py-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-2xl font-bold text-sm shadow-xl shadow-blue-600/20 hover:scale-[1.02] active:scale-[0.98] transition-all">
        Create Project
    </button>
    
    <div class="pt-6 mt-auto border-t border-white/5 space-y-1">
        <a href="<%= sideContextPath %>/pages/edit-profile.jsp" class="flex items-center space-x-4 px-6 py-3 text-white/30 hover:text-white transition-all text-xs font-bold uppercase tracking-widest">
            <i data-lucide="settings" class="w-4 h-4"></i>
            <span>Settings</span>
        </a>
        <form action="<%= sideContextPath %>/auth/logout" method="POST">
            <button type="submit" class="w-full flex items-center space-x-4 px-6 py-3 text-red-400/40 hover:text-red-400 transition-all text-xs font-bold uppercase tracking-widest">
                <i data-lucide="log-out" class="w-4 h-4"></i>
                <span>Logout</span>
            </button>
        </form>
    </div>
</aside>
