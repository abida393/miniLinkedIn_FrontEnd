<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "Messages | IGA Network");
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
<body class="bg-[#0b0e14] text-white/90 min-h-screen flex flex-col overflow-hidden">
    
    <!-- Top Navigation -->
    <nav class="sticky top-0 z-50 bg-[#0d1117] border-b border-white/5 px-6 py-3 flex items-center justify-between shrink-0">
        <div class="flex items-center space-x-8">
            <div class="text-linkedin-blue font-bold text-xl tracking-tight">IGA Network</div>
            <div class="hidden md:flex space-x-6 text-xs font-bold uppercase tracking-widest text-white/50">
                <a href="<%= request.getContextPath() %>/pages/home.jsp" class="hover:text-white transition-colors">Home</a>
                <a href="#" class="hover:text-white transition-colors">Explore</a>
                <a href="<%= request.getContextPath() %>/pages/messages.jsp" class="text-white border-b-2 border-blue-500 pb-1">Messages</a>
            </div>
        </div>
        <div class="flex items-center space-x-6">
            <button class="text-white/50 hover:text-white transition-colors"><i data-lucide="bell" class="w-5 h-5"></i></button>
            <button class="text-white/50 hover:text-white transition-colors relative">
                <i data-lucide="mail" class="w-5 h-5 text-blue-500"></i>
                <span class="absolute -bottom-2 left-0 right-0 h-0.5 bg-blue-500"></span>
            </button>
            <img src="<%= avatarUrl %>" alt="<%= userName %>" class="w-8 h-8 rounded-full border border-white/10">
        </div>
    </nav>

    <div class="flex flex-1 overflow-hidden">
        <!-- Left Sidebar -->
        <aside class="hidden lg:flex w-64 flex-col bg-[#0d1117] border-r border-white/5 p-6 shrink-0 h-full overflow-y-auto">
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
                <a href="<%= request.getContextPath() %>/pages/messages.jsp" class="flex items-center space-x-3 px-4 py-3 text-white bg-blue-600/10 border border-blue-600/20 rounded-xl transition-all">
                    <i data-lucide="message-square" class="w-5 h-5 text-blue-500"></i>
                    <span class="text-sm font-semibold">Messages</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/notifications.jsp" class="flex items-center space-x-3 px-4 py-3 text-white/50 hover:text-white hover:bg-white/5 rounded-xl transition-all">
                    <i data-lucide="bell" class="w-5 h-5"></i>
                    <span class="text-sm font-semibold">Notifications</span>
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

        <!-- Messaging Center -->
        <div class="flex flex-1 overflow-hidden">
            <!-- Conversations List -->
            <aside class="w-full md:w-80 lg:w-96 bg-[#0d1117] border-r border-white/5 flex flex-col shrink-0">
                <div class="p-6 shrink-0">
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-xl font-bold text-white">Messages</h2>
                        <button class="p-2 text-white/40 hover:text-white transition-colors">
                            <i data-lucide="edit-3" class="w-5 h-5"></i>
                        </button>
                    </div>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-white/20">
                            <i data-lucide="search" class="w-4 h-4"></i>
                        </span>
                        <input type="text" placeholder="Search conversations..." 
                            class="w-full bg-[#161b22] border border-white/5 rounded-xl py-2.5 pl-12 pr-4 text-sm text-white focus:outline-none focus:ring-1 focus:ring-blue-500/30">
                    </div>
                </div>

                <div class="flex-1 overflow-y-auto px-4 space-y-2 pb-6">
                    <!-- Conversation Item 1 (Active) -->
                    <div class="p-4 bg-blue-600/10 border border-blue-600/20 rounded-2xl flex items-center space-x-4 cursor-pointer transition-all shadow-lg shadow-blue-600/10">
                        <div class="relative shrink-0">
                            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah" class="w-12 h-12 rounded-full border-2 border-blue-500/50">
                            <div class="absolute bottom-0 right-0 w-3 h-3 bg-green-500 border-2 border-[#0d1117] rounded-full"></div>
                        </div>
                        <div class="flex-1 min-w-0">
                            <div class="flex justify-between items-baseline mb-1">
                                <h4 class="text-sm font-bold text-white truncate">Dr. Sarah Chen</h4>
                                <span class="text-[9px] font-bold text-blue-400 uppercase">2m ago</span>
                            </div>
                            <p class="text-[11px] text-white/50 truncate">The peer review for the Neural Nets pape...</p>
                        </div>
                        <div class="w-5 h-5 bg-blue-500 text-white text-[9px] font-bold rounded-full flex items-center justify-center shrink-0">2</div>
                    </div>

                    <!-- Conversation Item 2 -->
                    <div class="p-4 hover:bg-white/[0.03] rounded-2xl flex items-center space-x-4 cursor-pointer transition-all">
                        <div class="shrink-0 p-3 bg-white/5 rounded-full text-white/20">
                            <i data-lucide="users" class="w-6 h-6"></i>
                        </div>
                        <div class="flex-1 min-w-0">
                            <div class="flex justify-between items-baseline mb-1">
                                <div class="flex items-center">
                                    <h4 class="text-sm font-bold text-white/70 truncate">Quantum Lab Group</h4>
                                    <i data-lucide="lock" class="w-3 h-3 ml-1.5 text-white/20"></i>
                                </div>
                                <span class="text-[9px] font-bold text-white/20 uppercase">1h ago</span>
                            </div>
                            <p class="text-[11px] text-white/30 truncate"><span class="font-bold text-white/40">Marcus:</span> I uploaded the latest simulation results.</p>
                        </div>
                    </div>

                    <!-- Conversation Item 3 -->
                    <div class="p-4 hover:bg-white/[0.03] rounded-2xl flex items-center space-x-4 cursor-pointer transition-all">
                        <div class="shrink-0 relative">
                            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Aris" class="w-12 h-12 rounded-full border border-white/5 grayscale">
                        </div>
                        <div class="flex-1 min-w-0">
                            <div class="flex justify-between items-baseline mb-1">
                                <h4 class="text-sm font-bold text-white/70 truncate">Prof. Aris Thorne</h4>
                                <span class="text-[9px] font-bold text-white/20 uppercase">Yest</span>
                            </div>
                            <p class="text-[11px] text-white/30 truncate">Are we still on for the thesis review tomorrow?</p>
                        </div>
                    </div>
                </div>
            </aside>

            <!-- Chat Window -->
            <main class="flex-1 flex flex-col bg-[#0b0e14]">
                <!-- Chat Header -->
                <header class="p-6 bg-[#0d1117] border-b border-white/5 flex items-center justify-between shrink-0">
                    <div class="flex items-center space-x-4">
                        <div class="relative shrink-0">
                            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah" class="w-10 h-10 rounded-full">
                            <div class="absolute bottom-0 right-0 w-2.5 h-2.5 bg-green-500 border-2 border-[#0d1117] rounded-full"></div>
                        </div>
                        <div>
                            <div class="flex items-center">
                                <h3 class="text-sm font-bold text-white">Dr. Sarah Chen</h3>
                                <span class="w-1.5 h-1.5 bg-green-500 rounded-full ml-2"></span>
                            </div>
                            <p class="text-[10px] text-white/30 font-bold uppercase tracking-widest mt-0.5">Lead Researcher • 14 Members in shared projects</p>
                        </div>
                    </div>
                    <div class="flex items-center space-x-6">
                        <button class="text-white/30 hover:text-white transition-colors"><i data-lucide="video" class="w-5 h-5"></i></button>
                        <button class="text-white/30 hover:text-white transition-colors"><i data-lucide="phone" class="w-5 h-5"></i></button>
                        <button class="text-white/30 hover:text-white transition-colors"><i data-lucide="info" class="w-5 h-5"></i></button>
                    </div>
                </header>

                <!-- Message History -->
                <div class="flex-1 overflow-y-auto p-8 space-y-8">
                    <!-- Date Separator -->
                    <div class="flex items-center justify-center space-x-4">
                        <div class="h-[1px] flex-1 bg-white/5"></div>
                        <span class="text-[9px] font-bold text-white/20 uppercase tracking-[0.2em]">Tuesday, Oct 24</span>
                        <div class="h-[1px] flex-1 bg-white/5"></div>
                    </div>

                    <!-- Incoming Message -->
                    <div class="flex items-start space-x-4 max-w-2xl">
                        <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah" class="w-8 h-8 rounded-full shrink-0">
                        <div class="space-y-2">
                            <div class="p-4 bg-[#161b22] border border-white/5 rounded-2xl rounded-tl-none">
                                <p class="text-sm text-white/80 leading-relaxed">
                                    Hi there! I've just finished reviewing the draft for the Quantum Computing application. The methodology section looks much more robust now.
                                </p>
                            </div>
                            <span class="text-[10px] font-bold text-white/20 block pl-1">10:42 AM</span>
                        </div>
                    </div>

                    <!-- Outgoing Message -->
                    <div class="flex items-start justify-end space-x-4">
                        <div class="space-y-2 max-w-2xl text-right">
                            <div class="p-4 bg-gradient-to-br from-blue-600 to-indigo-600 text-white rounded-2xl rounded-tr-none shadow-lg shadow-blue-600/10">
                                <p class="text-sm leading-relaxed">
                                    Thanks, Sarah! I appreciate the quick turnaround. Did you have any concerns regarding the secondary data source we used for the simulations?
                                </p>
                            </div>
                            <div class="flex items-center justify-end space-x-2 pr-1">
                                <span class="text-[10px] font-bold text-white/20">10:45 AM • Read</span>
                                <div class="relative w-4 h-4 rounded-full overflow-hidden border border-white/10">
                                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah" class="w-full h-full object-cover">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Incoming Message with Attachment -->
                    <div class="flex items-start space-x-4 max-w-2xl">
                        <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah" class="w-8 h-8 rounded-full shrink-0">
                        <div class="space-y-4">
                            <div class="p-4 bg-[#161b22] border border-white/5 rounded-2xl rounded-tl-none">
                                <p class="text-sm text-white/80 leading-relaxed">
                                    It looks solid, but I attached a small adjustment for the error margin calculations. Check page 4.
                                </p>
                                <!-- PDF Attachment -->
                                <div class="mt-4 p-4 bg-[#0d1117] border border-white/5 rounded-xl flex items-center justify-between group cursor-pointer hover:bg-white/5 transition-all">
                                    <div class="flex items-center space-x-4">
                                        <div class="p-2 bg-red-500/20 text-red-500 rounded-lg">
                                            <i data-lucide="file-text" class="w-5 h-5"></i>
                                        </div>
                                        <div>
                                            <h4 class="text-xs font-bold text-white">Error_Margin_V2.pdf</h4>
                                            <p class="text-[9px] text-white/30 font-bold uppercase tracking-widest mt-1">1.2 MB • PDF Document</p>
                                        </div>
                                    </div>
                                    <i data-lucide="download" class="w-4 h-4 text-white/20 group-hover:text-white transition-colors"></i>
                                </div>
                            </div>
                            <span class="text-[10px] font-bold text-white/20 block pl-1">10:48 AM</span>
                        </div>
                    </div>

                    <!-- Incoming Message -->
                    <div class="flex items-start space-x-4 max-w-2xl">
                        <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah" class="w-8 h-8 rounded-full shrink-0">
                        <div class="space-y-2">
                            <div class="p-4 bg-[#161b22] border border-white/5 rounded-2xl rounded-tl-none">
                                <p class="text-sm text-white/80 leading-relaxed">
                                    The peer review for the Neural Nets paper is back. It's generally positive but they want more detail on the training set diversity.
                                </p>
                            </div>
                            <span class="text-[10px] font-bold text-white/20 block pl-1">Just now</span>
                        </div>
                    </div>
                </div>

                <!-- Chat Input Area -->
                <footer class="p-6 shrink-0 space-y-4">
                    <div class="bg-[#161b22] border border-white/5 rounded-2xl p-2 flex items-end space-x-2 focus-within:ring-1 focus-within:ring-blue-500/30 transition-all">
                        <div class="flex p-2 space-x-1">
                            <button class="p-2 text-white/30 hover:text-white hover:bg-white/5 rounded-xl transition-all"><i data-lucide="plus" class="w-5 h-5"></i></button>
                            <button class="p-2 text-white/30 hover:text-white hover:bg-white/5 rounded-xl transition-all"><i data-lucide="image" class="w-5 h-5"></i></button>
                        </div>
                        <textarea placeholder="Write a message..." 
                            class="flex-1 bg-transparent border-none py-3 px-2 text-sm text-white placeholder-white/20 focus:outline-none resize-none min-h-[44px] max-h-32"></textarea>
                        <div class="flex p-2 space-x-1 items-center">
                            <button class="p-2 text-white/30 hover:text-white hover:bg-white/5 rounded-xl transition-all"><i data-lucide="smile" class="w-5 h-5"></i></button>
                            <button class="p-3 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl shadow-lg shadow-blue-600/20 hover:scale-[1.05] active:scale-[0.95] transition-all">
                                <i data-lucide="send" class="w-5 h-5"></i>
                            </button>
                        </div>
                    </div>
                    <div class="flex items-center justify-center space-x-2">
                        <span class="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse"></span>
                        <span class="text-[8px] font-bold text-white/20 uppercase tracking-[0.2em]">SECURE P2P ENCRYPTION ACTIVE</span>
                    </div>
                </footer>
            </main>
        </div>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>
