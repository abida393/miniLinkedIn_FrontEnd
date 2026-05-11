<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    request.setAttribute("pageTitle", "Network | IGA Network");
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
        <main class="flex-1 px-8 overflow-y-auto">
            <!-- Header Section -->
            <div class="flex justify-between items-center mb-8">
                <div>
                    <h1 class="text-4xl font-bold text-white mb-2">My Network</h1>
                    <p class="text-white/40 text-sm">Grow your connections and collaborate with global researchers.</p>
                </div>
            </div>

            <!-- Filters Bar & Search -->
            <div class="bg-[#161b22] p-4 rounded-2xl border border-white/5 mb-8 flex flex-wrap items-center gap-6">
                <div class="relative flex-1 min-w-[300px]">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-white/20">
                        <i data-lucide="search" class="w-4 h-4"></i>
                    </span>
                    <input type="text" id="network-search" placeholder="Search researchers, teachers, students..." class="w-full bg-[#0d1117] border border-white/5 rounded-xl py-3 pl-12 pr-4 text-sm focus:outline-none focus:ring-1 focus:ring-blue-500/30 text-white transition-all">
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-[10px] font-bold text-white/30 uppercase tracking-widest">Filter:</span>
                    <div class="flex bg-[#0d1117] p-1 rounded-lg border border-white/5">
                        <button onclick="filterNetwork('ALL')" class="px-4 py-2 text-[10px] font-bold text-white bg-blue-600 rounded-md">ALL</button>
                        <button onclick="filterNetwork('STUDENT')" class="px-4 py-2 text-[10px] font-bold text-white/40 hover:text-white transition-colors">STUDENTS</button>
                        <button onclick="filterNetwork('TEACHER')" class="px-4 py-2 text-[10px] font-bold text-white/40 hover:text-white transition-colors">TEACHERS</button>
                    </div>
                </div>
            </div>

            <!-- Network Content Grid -->
            <div class="grid grid-cols-1 xl:grid-cols-12 gap-8">
                <!-- Left Column: Suggestions -->
                <div class="xl:col-span-8 space-y-8">
                    <div class="bg-[#161b22] rounded-3xl border border-white/5 shadow-xl overflow-hidden">
                        <div class="px-6 py-4 border-b border-white/5 flex justify-between items-center bg-white/5">
                            <h2 class="text-lg font-bold text-white">Suggested Connections</h2>
                        </div>
                        <div id="suggestions-container" class="p-6 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <!-- Suggestions will be loaded here -->
                            <div class="col-span-full py-10 text-center text-white/20">
                                <p class="text-xs font-bold uppercase tracking-widest">Loading suggestions...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Connections List -->
                <div class="xl:col-span-4 space-y-8">
                    <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                        <div class="flex justify-between items-center mb-6">
                            <h3 class="text-lg font-bold text-white">Connections</h3>
                            <span id="connections-count" class="text-xs font-bold text-blue-400">0 Total</span>
                        </div>
                        <div id="connections-list" class="space-y-4 max-h-[600px] overflow-y-auto pr-2 custom-scrollbar">
                            <!-- Connections will be loaded here -->
                        </div>
                        <button class="w-full mt-6 py-2.5 bg-white/5 border border-white/10 rounded-xl text-xs font-bold hover:bg-white/10 transition-all uppercase tracking-widest text-white/60">Manage Network</button>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();
        document.addEventListener('DOMContentLoaded', () => {
            if (typeof window.loadNetwork === 'function') {
                window.loadNetwork();
            }
        });
        // filterNetwork() is provided by event-handlers.js — do not redefine here
    </script>
</body>
</html>
