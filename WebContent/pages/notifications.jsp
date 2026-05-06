<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<body class="bg-[#0b0e14] text-white/90 min-h-screen flex flex-col">
    
    <!-- Top Navigation -->
    <nav class="sticky top-0 z-50 bg-[#0d1117] border-b border-white/5 px-6 py-3 flex items-center justify-between">
        <div class="flex items-center space-x-6 flex-1">
            <div class="text-linkedin-blue font-bold text-xl tracking-tight shrink-0">IGA Network</div>
            <div class="relative w-full max-w-md hidden md:block">
                <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-white/30">
                    <i data-lucide="search" class="w-4 h-4"></i>
                </span>
                <input type="text" placeholder="Search research..." 
                    class="w-full bg-[#161b22] border border-white/5 rounded-full py-2 pl-12 pr-4 text-sm text-white focus:outline-none focus:ring-1 focus:ring-blue-500/50 transition-all">
            </div>
        </div>
        <div class="flex items-center space-x-6">
            <button class="text-white/50 hover:text-white transition-colors relative">
                <i data-lucide="bell" class="w-5 h-5 text-blue-500"></i>
                <span class="absolute -bottom-2 left-0 right-0 h-0.5 bg-blue-500"></span>
            </button>
            <button class="text-white/50 hover:text-white transition-colors"><i data-lucide="mail" class="w-5 h-5"></i></button>
            <img src="<%= avatarUrl %>" alt="<%= userName %>" class="w-8 h-8 rounded-full border border-white/10">
        </div>
    </nav>

    <div class="flex flex-1">
        <!-- Left Sidebar -->
        <aside class="hidden lg:flex w-64 flex-col bg-[#0d1117] border-r border-white/5 p-6 sticky top-16 h-[calc(100vh-64px)] overflow-y-auto">
            <div class="flex items-center space-x-3 mb-10">
                <img src="<%= avatarUrl %>" alt="<%= userName %>" class="w-10 h-10 rounded-lg border border-white/10 bg-[#161b22]">
                <div>
                    <h4 class="text-sm font-bold"><%= userName %></h4>
                    <p class="text-[10px] text-white/40 uppercase tracking-widest"><%= userRole %></p>
                </div>
            </div>

            <nav class="flex-1 space-y-1">
                <a href="<%= request.getContextPath() %>/pages/home.jsp" class="flex items-center space-x-3 px-4 py-3 text-white/50 hover:text-white hover:bg-white/5 rounded-xl transition-all">
                    <i data-lucide="home" class="w-5 h-5"></i>
                    <span class="text-sm font-semibold">Home</span>
                </a>
                <a href="#" class="flex items-center space-x-3 px-4 py-3 text-white/50 hover:text-white hover:bg-white/5 rounded-xl transition-all">
                    <i data-lucide="compass" class="w-5 h-5"></i>
                    <span class="text-sm font-semibold">Explore</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/projects.jsp" class="flex items-center space-x-3 px-4 py-3 text-white/50 hover:text-white hover:bg-white/5 rounded-xl transition-all">
                    <i data-lucide="microscope" class="w-5 h-5"></i>
                    <span class="text-sm font-semibold">Projects</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/messages.jsp" class="flex items-center space-x-3 px-4 py-3 text-white/50 hover:text-white hover:bg-white/5 rounded-xl transition-all">
                    <i data-lucide="message-square" class="w-5 h-5"></i>
                    <span class="text-sm font-semibold">Messages</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/notifications.jsp" class="flex items-center space-x-3 px-4 py-3 text-white bg-blue-600/10 border border-blue-600/20 rounded-xl transition-all">
                    <i data-lucide="bell" class="w-5 h-5 text-blue-500"></i>
                    <span class="text-sm font-semibold">Notifications</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/profile.jsp" class="flex items-center space-x-3 px-4 py-3 text-white/50 hover:text-white hover:bg-white/5 rounded-xl transition-all">
                    <i data-lucide="user" class="w-5 h-5"></i>
                    <span class="text-sm font-semibold">Profile</span>
                </a>
            </nav>

            <button class="w-full py-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-2xl font-bold text-xs shadow-xl shadow-blue-600/20 hover:scale-[1.02] transition-all mt-6">
                Create Project
            </button>

            <div class="mt-auto pt-6 border-t border-white/5 space-y-1">
                <a href="#" class="flex items-center space-x-3 px-4 py-3 text-white/50 hover:text-white transition-all">
                    <i data-lucide="settings" class="w-5 h-5"></i>
                    <span class="text-sm font-semibold">Settings</span>
                </a>
                <form action="<%= request.getContextPath() %>/auth/logout" method="POST">
                    <button type="submit" class="w-full flex items-center space-x-3 px-4 py-3 text-red-400/70 hover:text-red-400 hover:bg-red-500/10 rounded-xl transition-all">
                        <i data-lucide="log-out" class="w-5 h-5"></i>
                        <span class="text-sm font-semibold">Logout</span>
                    </button>
                </form>
            </div>
        </aside>

        <!-- Main Content Area -->
        <main class="flex-1 p-8 max-w-5xl mx-auto overflow-y-auto">
            <div class="flex justify-between items-center mb-10">
                <div>
                    <h1 class="text-4xl font-bold text-white mb-2">Notifications</h1>
                    <p class="text-white/40 text-sm">Stay updated with your academic network and project milestones.</p>
                </div>
                <button class="px-6 py-2 bg-white/5 border border-white/10 rounded-xl text-[10px] font-bold uppercase tracking-widest hover:bg-white/10 transition-all flex items-center">
                    <i data-lucide="check-check" class="w-4 h-4 mr-2"></i> Mark all as read
                </button>
            </div>

            <!-- Today Section -->
            <div class="space-y-4 mb-12">
                <h3 class="text-[10px] font-bold text-white/30 uppercase tracking-[0.2em] px-4 mb-4">Today</h3>
                
                <!-- Notification Card 1 -->
                <div class="bg-[#161b22] p-6 rounded-2xl border border-white/5 shadow-xl flex items-start space-x-6 relative group cursor-pointer hover:bg-white/[0.03] transition-all border-l-2 border-l-blue-500">
                    <div class="p-3 bg-blue-500/20 text-blue-400 rounded-xl">
                        <i data-lucide="user-plus" class="w-6 h-6"></i>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm text-white/80 leading-relaxed">
                            <span class="font-bold text-white">Dr. Elena Volkov</span> requested to connect with you regarding your recent paper on "Neural Plasticity".
                        </p>
                        <div class="mt-2 flex items-center space-x-3 text-[10px] font-bold uppercase tracking-wider">
                            <span class="text-white/30">2m ago</span>
                            <span class="w-1 h-1 bg-white/20 rounded-full"></span>
                            <span class="text-blue-400">Connection</span>
                        </div>
                    </div>
                </div>

                <!-- Notification Card 2 -->
                <div class="bg-[#161b22] p-6 rounded-2xl border border-white/5 shadow-xl flex items-start space-x-6 relative group cursor-pointer hover:bg-white/[0.03] transition-all border-l-2 border-l-blue-500">
                    <div class="p-3 bg-blue-500/10 text-blue-400 rounded-xl">
                        <i data-lucide="message-square" class="w-6 h-6"></i>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm text-white/80 leading-relaxed">
                            <span class="font-bold text-white">Project: Quantum Leap</span> — New message from <span class="font-bold text-white">Sarah Jenkins</span>: "The latest data set has been uploaded to the repository."
                        </p>
                        <div class="mt-2 flex items-center space-x-3 text-[10px] font-bold uppercase tracking-wider">
                            <span class="text-white/30">45m ago</span>
                            <span class="w-1 h-1 bg-white/20 rounded-full"></span>
                            <span class="text-blue-400">Message</span>
                        </div>
                    </div>
                </div>

                <!-- Notification Card 3 -->
                <div class="bg-[#161b22] p-6 rounded-2xl border border-white/5 shadow-xl flex items-start space-x-6 relative group cursor-pointer hover:bg-white/[0.03] transition-all">
                    <div class="p-3 bg-purple-500/10 text-purple-400 rounded-xl">
                        <i data-lucide="microscope" class="w-6 h-6"></i>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm text-white/80 leading-relaxed">
                            Milestone <span class="font-bold text-white">Phase 1: Data Collection</span> was successfully completed in the <span class="italic text-white">Global Climate Survey</span> project.
                        </p>
                        <div class="mt-2 flex items-center space-x-3 text-[10px] font-bold uppercase tracking-wider">
                            <span class="text-white/30">4h ago</span>
                            <span class="w-1 h-1 bg-white/20 rounded-full"></span>
                            <span class="text-purple-400">Project</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Earlier Section -->
            <div class="space-y-4">
                <h3 class="text-[10px] font-bold text-white/30 uppercase tracking-[0.2em] px-4 mb-4">Earlier</h3>
                
                <!-- Notification Card 4 -->
                <div class="bg-[#161b22] p-6 rounded-2xl border border-white/5 shadow-xl flex items-start space-x-6 relative group cursor-pointer hover:bg-white/[0.03] transition-all">
                    <div class="p-3 bg-green-500/10 text-green-400 rounded-xl">
                        <i data-lucide="check-circle" class="w-6 h-6"></i>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm text-white/80 leading-relaxed">
                            Your credential for <span class="font-bold text-white">Senior Researcher</span> has been validated by the <span class="font-bold text-white">Oxford Institute Board</span>.
                        </p>
                        <div class="mt-2 flex items-center space-x-3 text-[10px] font-bold uppercase tracking-wider">
                            <span class="text-white/30">Yesterday</span>
                            <span class="w-1 h-1 bg-white/20 rounded-full"></span>
                            <span class="text-green-400">Validation</span>
                        </div>
                    </div>
                </div>

                <!-- Notification Card 5 -->
                <div class="bg-[#161b22] p-6 rounded-2xl border border-white/5 shadow-xl flex items-start space-x-6 relative group cursor-pointer hover:bg-white/[0.03] transition-all">
                    <div class="p-3 bg-red-500/10 text-red-400 rounded-xl">
                        <i data-lucide="heart" class="w-6 h-6"></i>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm text-white/80 leading-relaxed">
                            <span class="font-bold text-white">Prof. Marcus Thorne</span> and <span class="font-bold text-white">12 others</span> liked your publication on "Ethical AI Architecture".
                        </p>
                        <div class="mt-2 flex items-center space-x-3 text-[10px] font-bold uppercase tracking-wider">
                            <span class="text-white/30">Yesterday</span>
                            <span class="w-1 h-1 bg-white/20 rounded-full"></span>
                            <span class="text-red-400">Like</span>
                        </div>
                    </div>
                </div>

                <!-- Notification Card 6 -->
                <div class="bg-[#161b22] p-6 rounded-2xl border border-white/5 shadow-xl flex items-start space-x-6 relative group cursor-pointer hover:bg-white/[0.03] transition-all">
                    <div class="p-3 bg-orange-500/10 text-orange-400 rounded-xl">
                        <i data-lucide="message-circle" class="w-6 h-6"></i>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm text-white/80 leading-relaxed">
                            <span class="font-bold text-white">Li Wei</span> commented on your discussion thread: "This approach to data integrity is groundbreaking..."
                        </p>
                        <div class="mt-2 flex items-center space-x-3 text-[10px] font-bold uppercase tracking-wider">
                            <span class="text-white/30">2 days ago</span>
                            <span class="w-1 h-1 bg-white/20 rounded-full"></span>
                            <span class="text-orange-400">Comment</span>
                        </div>
                    </div>
                </div>

                <!-- Notification Card 7 with Actions -->
                <div class="bg-[#161b22] p-6 rounded-2xl border border-white/5 shadow-xl flex items-start space-x-6 relative group cursor-pointer hover:bg-white/[0.03] transition-all">
                    <div class="p-3 bg-blue-500/10 text-blue-400 rounded-xl">
                        <i data-lucide="user-plus" class="w-6 h-6"></i>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm text-white/80 leading-relaxed">
                            You have been invited to join the <span class="font-bold text-white">Deep Space Observational Study</span> as a Primary Contributor.
                        </p>
                        <div class="mt-4 flex space-x-3">
                            <button class="px-6 py-2 bg-blue-600 text-white rounded-lg font-bold text-[10px] uppercase tracking-widest hover:bg-blue-500 transition-all">Accept</button>
                            <button class="px-6 py-2 bg-white/5 border border-white/10 text-white/60 rounded-lg font-bold text-[10px] uppercase tracking-widest hover:bg-white/10 transition-all">Decline</button>
                        </div>
                        <div class="mt-4 flex items-center space-x-3 text-[10px] font-bold uppercase tracking-wider">
                            <span class="text-white/30">3 days ago</span>
                            <span class="w-1 h-1 bg-white/20 rounded-full"></span>
                            <span class="text-blue-400">Project</span>
                        </div>
                    </div>
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
    </script>
</body>
</html>
