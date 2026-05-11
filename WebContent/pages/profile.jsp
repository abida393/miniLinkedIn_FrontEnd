<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    request.setAttribute("pageTitle", "Profile | IGA Network");
    HttpSession userSession = request.getSession(false);
    String userName  = userSession != null && userSession.getAttribute("userName")  != null ? (String) userSession.getAttribute("userName")  : "Academic User";
    String userRole  = userSession != null && userSession.getAttribute("userRole")  != null ? (String) userSession.getAttribute("userRole")  : "RESEARCHER";
    String userEmail = userSession != null && userSession.getAttribute("userEmail") != null ? (String) userSession.getAttribute("userEmail") : "";
    String avatarSeed = userEmail.isEmpty() ? "default" : userEmail.replace("@","-");
    String avatarUrl  = "https://api.dicebear.com/7.x/avataaars/svg?seed=" + avatarSeed;
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../partials/header.jsp" />
<body class="bg-[#0b0e14] text-white/90 min-h-screen flex flex-col">
    
    <!-- Top Navigation -->
    <jsp:include page="../partials/navbar.jsp" />

    <div class="max-w-[1440px] mx-auto flex px-6 py-8 flex-1">
        <!-- Left Sidebar -->
        <jsp:include page="../partials/sidebar.jsp" />

        <!-- Main Content Area -->
        <main class="flex-1 px-8 overflow-y-auto">
            <div id="profile-content-container">
                <!-- Loading State -->
                <div class="flex flex-col items-center justify-center py-40 text-white/10">
                    <i data-lucide="loader-2" class="w-12 h-12 mb-4 animate-spin"></i>
                    <p class="text-xs font-bold uppercase tracking-widest">Synchronizing Profile...</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();
        document.addEventListener('DOMContentLoaded', () => {
            if (typeof window.loadFullProfile === 'function') {
                window.loadFullProfile();
            }
        });
    </script>
</body>
</html>
