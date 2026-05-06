<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<body class="bg-[#0b0e14] text-white/90 min-h-screen flex flex-col">
    
    <!-- Top Navigation -->
    <nav class="sticky top-0 z-50 bg-[#0d1117] border-b border-white/5 px-6 py-3 flex items-center justify-between">
        <div class="flex items-center space-x-8">
            <div class="text-linkedin-blue font-bold text-xl tracking-tight">IGA Network</div>
            <div class="hidden md:flex space-x-6 text-xs font-bold uppercase tracking-widest text-white/50">
                <a href="<%= request.getContextPath() %>/pages/home.jsp" class="hover:text-white transition-colors">Home</a>
                <a href="#" class="hover:text-white transition-colors">Explore</a>
                <a href="<%= request.getContextPath() %>/pages/projects.jsp" class="text-white border-b-2 border-blue-500 pb-1">Projects</a>
            </div>
        </div>
        <div class="flex items-center space-x-6">
            <button class="text-white/50 hover:text-white transition-colors"><i data-lucide="mail" class="w-5 h-5"></i></button>
            <button class="text-white/50 hover:text-white transition-colors"><i data-lucide="bell" class="w-5 h-5"></i></button>
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
                <a href="<%= request.getContextPath() %>/pages/projects.jsp" class="flex items-center space-x-3 px-4 py-3 text-white bg-blue-600/10 border border-blue-600/20 rounded-xl transition-all">
                    <i data-lucide="microscope" class="w-5 h-5 text-blue-500"></i>
                    <span class="text-sm font-semibold">Projects</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/messages.jsp" class="flex items-center space-x-3 px-4 py-3 text-white/50 hover:text-white hover:bg-white/5 rounded-xl transition-all">
                    <i data-lucide="message-square" class="w-5 h-5"></i>
                    <span class="text-sm font-semibold">Messages</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/notifications.jsp" class="flex items-center space-x-3 px-4 py-3 text-white/50 hover:text-white hover:bg-white/5 rounded-xl transition-all">
                    <i data-lucide="bell" class="w-5 h-5"></i>
                    <span class="text-sm font-semibold">Notifications</span>
                </a>
            </nav>

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
        <main class="flex-1 p-8 overflow-y-auto">
            <!-- Header Section -->
            <div class="flex justify-between items-center mb-8">
                <div>
                    <h1 class="text-4xl font-bold text-white mb-2">Projects</h1>
                    <p class="text-white/40 text-sm">Browse and collaborate on cutting-edge research initiatives.</p>
                </div>
                <button class="px-6 py-2.5 bg-blue-600 text-white rounded-xl font-bold text-sm shadow-xl shadow-blue-600/20 flex items-center hover:bg-blue-500 transition-all">
                    <i data-lucide="plus" class="w-4 h-4 mr-2"></i> Create Project
                </button>
            </div>

            <!-- Filters Bar -->
            <div class="bg-[#161b22] p-4 rounded-2xl border border-white/5 mb-8 flex flex-wrap items-center gap-6">
                <div class="relative flex-1 min-w-[300px]">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-white/20">
                        <i data-lucide="search" class="w-4 h-4"></i>
                    </span>
                    <input type="text" placeholder="Search projects by title..." class="w-full bg-[#0d1117] border border-white/5 rounded-xl py-2.5 pl-12 pr-4 text-sm focus:outline-none focus:ring-1 focus:ring-blue-500/30">
                </div>
                <div class="flex items-center space-x-4">
                    <span class="text-[10px] font-bold text-white/30 uppercase tracking-widest">Type:</span>
                    <div class="flex bg-[#0d1117] p-1 rounded-lg border border-white/5">
                        <button class="px-3 py-1 text-[10px] font-bold text-white bg-blue-600 rounded-md">ALL</button>
                        <button class="px-3 py-1 text-[10px] font-bold text-white/40 hover:text-white transition-colors">ACADEMIC</button>
                        <button class="px-3 py-1 text-[10px] font-bold text-white/40 hover:text-white transition-colors">RESEARCH</button>
                    </div>
                </div>
                <div class="flex items-center space-x-3">
                    <span class="text-[10px] font-bold text-white/30 uppercase tracking-widest">Status:</span>
                    <select class="bg-[#0d1117] border border-white/5 rounded-lg px-3 py-1.5 text-[10px] font-bold text-white focus:outline-none focus:ring-1 focus:ring-blue-500/30">
                        <option>OPEN</option>
                        <option>CLOSED</option>
                    </select>
                </div>
            </div>

            <!-- Projects Grid -->
            <div class="grid grid-cols-1 xl:grid-cols-3 gap-6 mb-12">
                <!-- Project Card 1 -->
                <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl hover:translate-y-[-4px] transition-all group">
                    <div class="flex justify-between items-start mb-4">
                        <span class="px-2 py-0.5 bg-green-500/10 text-green-500 text-[9px] font-bold rounded uppercase tracking-widest border border-green-500/20">Research</span>
                        <div class="flex items-center text-green-500 space-x-1.5">
                            <span class="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse"></span>
                            <span class="text-[9px] font-bold uppercase tracking-widest">Open</span>
                        </div>
                    </div>
                    <h3 class="text-xl font-bold text-white mb-3 group-hover:text-blue-400 transition-colors">Neural Architecture Search for Climate Modeling</h3>
                    <p class="text-white/40 text-xs leading-relaxed mb-6 line-clamp-3">Investigating the efficiency of automated neural architecture search (NAS) in optimizing predictive models for climate variability.</p>
                    <div class="flex flex-wrap gap-2 mb-8">
                        <span class="px-2 py-1 bg-white/5 text-[9px] font-bold text-white/60 rounded border border-white/5">PyTorch</span>
                        <span class="px-2 py-1 bg-white/5 text-[9px] font-bold text-white/60 rounded border border-white/5">NAS</span>
                        <span class="px-2 py-1 bg-white/5 text-[9px] font-bold text-white/60 rounded border border-white/5">Geospatial</span>
                    </div>
                    <div class="flex items-center justify-between pt-6 border-t border-white/5 mb-6">
                        <div class="flex items-center space-x-2">
                            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Elena" class="w-8 h-8 rounded-full">
                            <div>
                                <h4 class="text-[10px] font-bold text-white">Dr. Elena Vos</h4>
                                <p class="text-[8px] text-white/30 uppercase font-bold">Oxford University</p>
                            </div>
                        </div>
                        <span class="text-[9px] font-bold text-white/30 flex items-center"><i data-lucide="users" class="w-3 h-3 mr-1"></i> 12</span>
                    </div>
                    <button class="w-full py-2.5 border border-white/10 rounded-xl text-xs font-bold hover:bg-white/5 transition-all uppercase tracking-widest">Request to Join</button>
                </div>

                <!-- Project Card 2 -->
                <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl hover:translate-y-[-4px] transition-all group">
                    <div class="flex justify-between items-start mb-4">
                        <span class="px-2 py-0.5 bg-blue-500/10 text-blue-500 text-[9px] font-bold rounded uppercase tracking-widest border border-blue-500/20">Academic</span>
                        <div class="flex items-center text-green-500 space-x-1.5">
                            <span class="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse"></span>
                            <span class="text-[9px] font-bold uppercase tracking-widest">Open</span>
                        </div>
                    </div>
                    <h3 class="text-xl font-bold text-white mb-3 group-hover:text-blue-400 transition-colors">Quantum Cryptography Standards Proposal</h3>
                    <p class="text-white/40 text-xs leading-relaxed mb-6 line-clamp-3">A collaborative effort to draft a standardized framework for post-quantum cryptographic protocols in network security.</p>
                    <div class="flex flex-wrap gap-2 mb-8">
                        <span class="px-2 py-1 bg-white/5 text-[9px] font-bold text-white/60 rounded border border-white/5">Security</span>
                        <span class="px-2 py-1 bg-white/5 text-[9px] font-bold text-white/60 rounded border border-white/5">Q-Comms</span>
                    </div>
                    <div class="flex items-center justify-between pt-6 border-t border-white/5 mb-6">
                        <div class="flex items-center space-x-2">
                            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Marcus" class="w-8 h-8 rounded-full">
                            <div>
                                <h4 class="text-[10px] font-bold text-white">Prof. Marcus Chen</h4>
                                <p class="text-[8px] text-white/30 uppercase font-bold">MIT Media Lab</p>
                            </div>
                        </div>
                        <span class="text-[9px] font-bold text-white/30 flex items-center"><i data-lucide="users" class="w-3 h-3 mr-1"></i> 8</span>
                    </div>
                    <button class="w-full py-2.5 border border-white/10 rounded-xl text-xs font-bold hover:bg-white/5 transition-all uppercase tracking-widest">Request to Join</button>
                </div>

                <!-- Project Card 3 -->
                <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl hover:translate-y-[-4px] transition-all group">
                    <div class="flex justify-between items-start mb-4">
                        <span class="px-2 py-0.5 bg-purple-500/10 text-purple-500 text-[9px] font-bold rounded uppercase tracking-widest border border-purple-500/20">University</span>
                        <div class="flex items-center text-green-500 space-x-1.5">
                            <span class="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse"></span>
                            <span class="text-[9px] font-bold uppercase tracking-widest">Open</span>
                        </div>
                    </div>
                    <h3 class="text-xl font-bold text-white mb-3 group-hover:text-blue-400 transition-colors">Distributed Ledger for Peer-Reviewed Journals</h3>
                    <p class="text-white/40 text-xs leading-relaxed mb-6 line-clamp-3">Developing a transparent, immutable ledger system for tracking peer-review contributions and academic publishing.</p>
                    <div class="flex flex-wrap gap-2 mb-8">
                        <span class="px-2 py-1 bg-white/5 text-[9px] font-bold text-white/60 rounded border border-white/5">Blockchain</span>
                        <span class="px-2 py-1 bg-white/5 text-[9px] font-bold text-white/60 rounded border border-white/5">DApp</span>
                    </div>
                    <div class="flex items-center justify-between pt-6 border-t border-white/5 mb-6">
                        <div class="flex items-center space-x-2">
                            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah" class="w-8 h-8 rounded-full">
                            <div>
                                <h4 class="text-[10px] font-bold text-white">Sarah Jenkins</h4>
                                <p class="text-[8px] text-white/30 uppercase font-bold">Stanford Univ.</p>
                            </div>
                        </div>
                        <span class="text-[9px] font-bold text-white/30 flex items-center"><i data-lucide="users" class="w-3 h-3 mr-1"></i> 24</span>
                    </div>
                    <button class="w-full py-2.5 border border-white/10 rounded-xl text-xs font-bold hover:bg-white/5 transition-all uppercase tracking-widest">Request to Join</button>
                </div>
            </div>

            <!-- Project Detail Section (Featured/Active) -->
            <div class="grid grid-cols-1 xl:grid-cols-12 gap-8">
                <div class="xl:col-span-8 bg-[#161b22] rounded-3xl border border-white/5 shadow-2xl overflow-hidden">
                    <div class="p-8 border-b border-white/5 bg-gradient-to-r from-blue-900/10 to-transparent">
                        <h2 class="text-2xl font-bold text-white">Project Detail: Advanced Bio-Informatics Cluster</h2>
                    </div>
                    <div class="p-8">
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-8 mb-10 pb-10 border-b border-white/5">
                            <div>
                                <div class="text-[9px] font-bold text-white/30 uppercase tracking-widest mb-1">Status</div>
                                <div class="flex items-center space-x-2">
                                    <span class="w-2 h-2 bg-green-500 rounded-full shadow-[0_0_8px_rgba(34,197,94,0.5)]"></span>
                                    <span class="text-xs font-bold uppercase tracking-widest text-green-500">Active</span>
                                </div>
                            </div>
                            <div>
                                <div class="text-[9px] font-bold text-white/30 uppercase tracking-widest mb-1">Lead Investigator</div>
                                <div class="text-xs font-bold text-white">Dr. Alan Turing II</div>
                            </div>
                            <div>
                                <div class="text-[9px] font-bold text-white/30 uppercase tracking-widest mb-1">Timeline</div>
                                <div class="text-xs font-bold text-white">Jan 2024 - Dec 2024</div>
                            </div>
                            <div>
                                <div class="text-[9px] font-bold text-white/30 uppercase tracking-widest mb-1">Budget</div>
                                <div class="text-xs font-bold text-white">$120k Grant</div>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-12 mb-12">
                            <div>
                                <h3 class="text-sm font-bold text-white/60 uppercase tracking-widest mb-4">Description</h3>
                                <p class="text-xs text-white/40 leading-relaxed">
                                    This project focuses on the construction of a high-performance computing cluster tailored specifically for large-scale genomic sequence alignment and protein folding simulations. Our goal is to reduce computational latency by 40% compared to current cloud-based solutions.
                                </p>
                            </div>
                            <div>
                                <h3 class="text-sm font-bold text-white/60 uppercase tracking-widest mb-4">Objectives</h3>
                                <ul class="space-y-3">
                                    <li class="flex items-center space-x-3 text-xs text-white/40">
                                        <i data-lucide="check-circle" class="w-4 h-4 text-green-500"></i>
                                        <span>Deploy 64-node GPU cluster.</span>
                                    </li>
                                    <li class="flex items-center space-x-3 text-xs text-white/40">
                                        <i data-lucide="check-circle" class="w-4 h-4 text-green-500"></i>
                                        <span>Implement MPI-based alignment tool.</span>
                                    </li>
                                    <li class="flex items-center space-x-3 text-xs text-white/40">
                                        <i data-lucide="circle" class="w-4 h-4 text-white/10"></i>
                                        <span>Run 10k comparative tests.</span>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!-- Kanban Board Mockup -->
                        <div class="space-y-6">
                            <h3 class="text-sm font-bold text-white/60 uppercase tracking-widest">Tasks Kanban</h3>
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                <div class="space-y-4">
                                    <div class="flex justify-between items-center px-4 py-2 bg-[#0d1117] rounded-xl border border-white/5">
                                        <span class="text-[9px] font-bold text-white/40 uppercase tracking-widest">Pending</span>
                                        <span class="text-[10px] font-bold text-white/20">3</span>
                                    </div>
                                    <div class="p-4 bg-white/5 rounded-2xl border border-white/5 space-y-3">
                                        <p class="text-xs font-semibold text-white/60">Optimize CUDA kernels</p>
                                    </div>
                                    <div class="p-4 bg-white/5 rounded-2xl border border-white/5 space-y-3">
                                        <p class="text-xs font-semibold text-white/60">Data scrubbing protocol</p>
                                    </div>
                                </div>
                                <div class="space-y-4">
                                    <div class="flex justify-between items-center px-4 py-2 bg-[#0d1117] rounded-xl border border-white/5">
                                        <span class="text-[9px] font-bold text-blue-400 uppercase tracking-widest">In Progress</span>
                                        <span class="text-[10px] font-bold text-blue-400/20">1</span>
                                    </div>
                                    <div class="p-4 bg-blue-500/10 rounded-2xl border border-blue-500/20 space-y-3">
                                        <p class="text-xs font-semibold text-blue-400">Network switch config</p>
                                    </div>
                                </div>
                                <div class="space-y-4">
                                    <div class="flex justify-between items-center px-4 py-2 bg-[#0d1117] rounded-xl border border-white/5">
                                        <span class="text-[9px] font-bold text-green-500 uppercase tracking-widest">Completed</span>
                                        <span class="text-[10px] font-bold text-green-500/20">8</span>
                                    </div>
                                    <div class="p-4 bg-green-500/5 rounded-2xl border border-green-500/10 space-y-3 opacity-60">
                                        <p class="text-xs font-semibold text-green-500">Server rack installation</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Detail Sidebar -->
                <div class="xl:col-span-4 space-y-8">
                    <!-- Active Members -->
                    <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                        <h3 class="text-lg font-bold text-white mb-6">Active Members</h3>
                        <div class="space-y-4 mb-8">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center space-x-3">
                                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Alex" class="w-10 h-10 rounded-full">
                                    <div>
                                        <h4 class="text-xs font-bold text-white">Alex Rivera</h4>
                                        <p class="text-[8px] text-white/30 uppercase font-bold tracking-widest">Lead Architect</p>
                                    </div>
                                </div>
                                <span class="px-2 py-0.5 bg-blue-500/10 text-blue-500 text-[8px] font-bold rounded uppercase tracking-tighter border border-blue-500/20">Admin</span>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center space-x-3">
                                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Maya" class="w-10 h-10 rounded-full">
                                    <div>
                                        <h4 class="text-xs font-bold text-white">Maya Patel</h4>
                                        <p class="text-[8px] text-white/30 uppercase font-bold tracking-widest">Data Scientist</p>
                                    </div>
                                </div>
                                <span class="px-2 py-0.5 bg-green-500/10 text-green-500 text-[8px] font-bold rounded uppercase tracking-tighter border border-green-500/20">Researcher</span>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center space-x-3">
                                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Kevin" class="w-10 h-10 rounded-full">
                                    <div>
                                        <h4 class="text-xs font-bold text-white">Kevin Zhang</h4>
                                        <p class="text-[8px] text-white/30 uppercase font-bold tracking-widest">Project Lead</p>
                                    </div>
                                </div>
                                <span class="px-2 py-0.5 bg-purple-500/10 text-purple-500 text-[8px] font-bold rounded uppercase tracking-tighter border border-purple-500/20">Teacher</span>
                            </div>
                        </div>
                        <button class="w-full py-2.5 bg-white/5 border border-white/10 rounded-xl text-xs font-bold hover:bg-white/10 transition-all uppercase tracking-widest text-white/60">View All 12 Members</button>
                    </div>

                    <!-- Attachments -->
                    <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                        <h3 class="text-lg font-bold text-white mb-6">Attachments</h3>
                        <div class="space-y-4">
                            <div class="p-4 bg-white/5 rounded-2xl flex items-center space-x-4 group cursor-pointer hover:bg-white/10 transition-all">
                                <div class="p-3 bg-red-500/20 text-red-500 rounded-xl">
                                    <i data-lucide="file-text" class="w-5 h-5"></i>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <h4 class="text-xs font-bold text-white truncate">Project_Charter_v2.pdf</h4>
                                    <p class="text-[9px] text-white/30 mt-1 uppercase font-bold">2.4 MB • Oct 12</p>
                                </div>
                            </div>
                            <div class="p-4 bg-white/5 rounded-2xl flex items-center space-x-4 group cursor-pointer hover:bg-white/10 transition-all">
                                <div class="p-3 bg-green-500/20 text-green-500 rounded-xl">
                                    <i data-lucide="table" class="w-5 h-5"></i>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <h4 class="text-xs font-bold text-white truncate">Cluster_Allocation.xlsx</h4>
                                    <p class="text-[9px] text-white/30 mt-1 uppercase font-bold">1.1 MB • Oct 15</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>
