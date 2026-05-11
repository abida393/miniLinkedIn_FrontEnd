<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    request.setAttribute("pageTitle", "Notifications | IGA Network");
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
<body class="bg-[#0b0e14] text-white/90 min-h-screen">
    
    <!-- Top Navigation -->
    <jsp:include page="../partials/navbar.jsp" />

    <div class="max-w-[1440px] mx-auto flex px-6 py-8">
        <!-- Left Sidebar -->
        <jsp:include page="../partials/sidebar.jsp" />

        <!-- Main Content Area -->
        <main class="flex-1 px-8 max-w-5xl overflow-y-auto">
            <div class="flex justify-between items-center mb-10">
                <div>
                    <h1 class="text-4xl font-bold text-white mb-2">Notifications</h1>
                    <p class="text-white/40 text-sm">Stay updated with your academic network and project milestones.</p>
                </div>
                <button onclick="markAllNotificationsRead()" class="px-6 py-2 bg-white/5 border border-white/10 rounded-xl text-[10px] font-bold uppercase tracking-widest hover:bg-white/10 transition-all flex items-center">
                    <i data-lucide="check-check" class="w-4 h-4 mr-2"></i> Mark all as read
                </button>
            </div>

            <div id="notifications-list" class="space-y-4 mb-12">
                <!-- Notifications will be rendered here by JavaScript -->
                <div class="flex flex-col items-center justify-center py-20 text-white/20">
                    <i data-lucide="bell-off" class="w-16 h-16 mb-4 opacity-10"></i>
                    <p class="text-sm font-medium">Loading notifications...</p>
                </div>
            </div>

            <!-- Footer Section -->
            <div class="mt-16 text-center space-y-4 pb-12">
                <div class="flex justify-center">
                    <div class="p-4 bg-white/5 rounded-full text-white/20">
                        <i data-lucide="history" class="w-8 h-8"></i>
                    </div>
                </div>
                <p class="text-sm text-white/30 italic">You're all caught up for now.</p>
                <button class="text-[10px] font-bold text-white/40 uppercase tracking-[0.2em] hover:text-white transition-colors">View Notification Settings</button>
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();
        document.addEventListener('DOMContentLoaded', () => {
            if (typeof window.loadAllNotifications === 'function') {
                window.loadAllNotifications();
            }
        });

        async function markAllNotificationsRead() {
            try {
                const ctx = window.IGA_CONFIG?.contextPath || '/MiniLinkedIn';
                const response = await fetch(ctx + '/api/notifications/read-all', { method: 'POST' });
                if (response.ok) {
                    showToast('All notifications marked as read', 'success');
                    if (typeof window.loadAllNotifications === 'function') {
                        window.loadAllNotifications();
                    }
                }
            } catch (err) {
                console.error('Mark all read error:', err);
            }
        }
    </script>

</body>
</html>
