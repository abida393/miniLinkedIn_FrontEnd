<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    request.setAttribute("pageTitle", "Projects | IGA Network");
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
                    <h1 class="text-4xl font-bold text-white mb-2">Projects</h1>
                    <p class="text-white/40 text-sm">Browse and collaborate on cutting-edge research initiatives.</p>
                </div>
                <button onclick="document.getElementById('create-project-form-container').classList.toggle('hidden')" class="px-6 py-2.5 bg-blue-600 text-white rounded-xl font-bold text-sm shadow-xl shadow-blue-600/20 flex items-center hover:bg-blue-500 transition-all">
                    <i data-lucide="plus" class="w-4 h-4 mr-2"></i> Create Project
                </button>
            </div>

            <!-- Create Project Form (Hidden by default) -->
            <div id="create-project-form-container" class="hidden mb-8">
                <form id="create-project-form" class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl">
                    <h3 class="text-xl font-bold text-white mb-6">Create New Project</h3>
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-bold text-white/70 mb-2">Project Title</label>
                            <input type="text" id="project-title" name="title" required placeholder="Enter project title" class="w-full bg-[#0d1117] border border-white/5 rounded-xl p-3 text-white focus:outline-none focus:ring-1 focus:ring-blue-500/30 transition-all">
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-white/70 mb-2">Description</label>
                            <textarea id="project-description" name="description" required placeholder="Describe your project..." class="w-full bg-[#0d1117] border border-white/5 rounded-xl p-3 text-white focus:outline-none focus:ring-1 focus:ring-blue-500/30 min-h-[120px] resize-none transition-all"></textarea>
                        </div>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-bold text-white/70 mb-2">Project Type</label>
                                <select id="project-type" name="type" class="w-full bg-[#0d1117] border border-white/5 rounded-xl p-3 text-white focus:outline-none focus:ring-1 focus:ring-blue-500/30 transition-all">
                                    <option value="ACADEMIC">Academic</option>
                                    <option value="RESEARCH">Research</option>
                                    <option value="INNOVATIVE">Innovative</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-bold text-white/70 mb-2">Max Members</label>
                                <input type="number" id="project-max-members" name="max_members" value="10" min="1" max="100" class="w-full bg-[#0d1117] border border-white/5 rounded-xl p-3 text-white focus:outline-none focus:ring-1 focus:ring-blue-500/30 transition-all">
                            </div>
                        </div>
                        <div class="flex justify-end space-x-3 mt-6">
                            <button type="button" onclick="document.getElementById('create-project-form-container').classList.add('hidden')" class="px-6 py-2 text-white/40 hover:text-white font-bold transition-all">Cancel</button>
                            <button type="submit" class="px-8 py-3 bg-blue-600 text-white rounded-xl font-bold hover:bg-blue-500 transition-all shadow-lg shadow-blue-600/20">Initialize Project</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Filters Bar -->
            <div class="bg-[#161b22] p-4 rounded-2xl border border-white/5 mb-8 flex flex-wrap items-center gap-6">
                <div class="relative flex-1 min-w-[300px]">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-white/20">
                        <i data-lucide="search" class="w-4 h-4"></i>
                    </span>
                    <input type="text" id="project-search" placeholder="Search projects by title..." class="w-full bg-[#0d1117] border border-white/5 rounded-xl py-2.5 pl-12 pr-4 text-sm focus:outline-none focus:ring-1 focus:ring-blue-500/30 transition-all text-white">
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-[10px] font-bold text-white/30 uppercase tracking-widest">Type:</span>
                    <div class="flex bg-[#0d1117] p-1 rounded-lg border border-white/5">
                        <button onclick="filterProjects('ALL')" class="px-3 py-1 text-[10px] font-bold text-white bg-blue-600 rounded-md">ALL</button>
                        <button onclick="filterProjects('ACADEMIC')" class="px-3 py-1 text-[10px] font-bold text-white/40 hover:text-white transition-colors">ACADEMIC</button>
                        <button onclick="filterProjects('RESEARCH')" class="px-3 py-1 text-[10px] font-bold text-white/40 hover:text-white transition-colors">RESEARCH</button>
                    </div>
                </div>
                <div class="flex items-center space-x-3">
                    <span class="text-[10px] font-bold text-white/30 uppercase tracking-widest">Status:</span>
                    <select id="project-status-filter" class="bg-[#0d1117] border border-white/5 rounded-lg px-3 py-1.5 text-[10px] font-bold text-white focus:outline-none focus:ring-1 focus:ring-blue-500/30 transition-all">
                        <option value="OPEN">OPEN</option>
                        <option value="CLOSED">CLOSED</option>
                    </select>
                </div>
            </div>

            <!-- Projects Grid -->
            <div id="projects-container" class="grid grid-cols-1 xl:grid-cols-3 gap-6 mb-12">
                <!-- Projects will be rendered here by JavaScript -->
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();
        document.addEventListener('DOMContentLoaded', () => {
            if (typeof window.loadProjects === 'function') {
                window.loadProjects();
            }
        });
        // filterProjects() is provided by event-handlers.js — do not redefine here
    </script>
</body>
</html>
