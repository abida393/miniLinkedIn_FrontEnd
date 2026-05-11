<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
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
    <jsp:include page="../partials/navbar.jsp" />

    <div class="flex flex-1 overflow-hidden">
        <!-- Left Sidebar -->
        <jsp:include page="../partials/sidebar.jsp" />

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

                <div id="conversations-container" class="flex-1 overflow-y-auto px-4 space-y-2 pb-6">
                    <!-- Conversations will be loaded here -->
                    <div class="flex flex-col items-center justify-center py-20 text-white/10">
                        <i data-lucide="message-square" class="w-12 h-12 mb-4 opacity-5"></i>
                        <p class="text-xs font-bold uppercase tracking-widest">Loading Chats...</p>
                    </div>
                </div>
            </aside>

            <!-- Chat Window -->
            <main class="flex-1 flex flex-col bg-[#0b0e14]">
                <!-- Chat Header -->
                <header id="chat-header" class="p-6 bg-[#0d1117] border-b border-white/5 flex items-center justify-between shrink-0">
                    <div class="flex items-center space-x-4">
                        <div class="relative shrink-0">
                            <div class="w-10 h-10 rounded-full bg-[#161b22] border border-white/5"></div>
                        </div>
                        <div>
                            <h3 class="text-sm font-bold text-white">Select a conversation</h3>
                            <p class="text-[10px] text-white/30 font-bold uppercase tracking-widest mt-0.5">Encrypted messaging</p>
                        </div>
                    </div>
                </header>

                <!-- Message History -->
                <div id="chat-messages" class="flex-1 overflow-y-auto p-8 space-y-8">
                    <!-- Messages will be rendered here -->
                    <div class="flex flex-col items-center justify-center h-full text-white/10 italic">
                        <p>No messages to display</p>
                    </div>
                </div>

                <!-- Chat Input Area -->
                <footer class="p-6 shrink-0 space-y-4">
                    <form id="send-message-form" class="bg-[#161b22] border border-white/5 rounded-2xl p-2 flex items-end space-x-2 focus-within:ring-1 focus-within:ring-blue-500/30 transition-all">
                        <div class="flex p-2 space-x-1">
                            <button type="button" class="p-2 text-white/30 hover:text-white hover:bg-white/5 rounded-xl transition-all"><i data-lucide="plus" class="w-5 h-5"></i></button>
                        </div>
                        <textarea id="message-input" placeholder="Write a message..." 
                            class="flex-1 bg-transparent border-none py-3 px-2 text-sm text-white placeholder-white/20 focus:outline-none resize-none min-h-[44px] max-h-32"></textarea>
                        <div class="flex p-2 space-x-1 items-center">
                            <button type="submit" class="p-3 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl shadow-lg shadow-blue-600/20 hover:scale-[1.05] active:scale-[0.95] transition-all">
                                <i data-lucide="send" class="w-5 h-5"></i>
                            </button>
                        </div>
                    </form>
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
        document.addEventListener('DOMContentLoaded', () => {
            if (typeof window.loadConversations === 'function') {
                window.loadConversations();
            }
        });
    </script>
</body>
</html>
