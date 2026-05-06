<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "Feed | IGA Network");
    HttpSession userSession = request.getSession(false);
    String userName  = userSession != null && userSession.getAttribute("userName")  != null ? (String) userSession.getAttribute("userName")  : "Academic User";
    String userRole  = userSession != null && userSession.getAttribute("userRole")  != null ? (String) userSession.getAttribute("userRole")  : "RESEARCHER";
    String userEmail = userSession != null && userSession.getAttribute("userEmail") != null ? (String) userSession.getAttribute("userEmail") : "";
    String avatarSeed = userEmail.isEmpty() ? "default" : userEmail.replace("@","-");
    String avatarUrl = "https://api.dicebear.com/7.x/avataaars/svg?seed=" + avatarSeed;
    boolean isAdmin  = "ADMIN".equals(userRole);
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../partials/header.jsp" />
<body class="bg-[#0b0e14] text-white/90 min-h-screen">
    
    <!-- Top Navigation -->
    <nav class="sticky top-0 z-50 bg-[#0d1117] border-b border-white/5 px-6 py-3 flex items-center justify-between">
        <div class="flex items-center space-x-6 flex-1">
            <div class="text-linkedin-blue font-bold text-xl tracking-tight shrink-0">IGA Network</div>
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
            <button class="text-white/50 hover:text-white transition-colors relative">
                <i data-lucide="bell" class="w-5 h-5"></i>
                <span class="absolute top-0 right-0 w-2 h-2 bg-blue-500 rounded-full border-2 border-[#0d1117]"></span>
            </button>
            <img src="<%= avatarUrl %>" alt="<%= userName %>" class="w-8 h-8 rounded-full border border-white/10 cursor-pointer">
        </div>
    </nav>

    <div class="max-w-[1440px] mx-auto flex px-6 py-8">
        <!-- Left Sidebar -->
        <aside class="hidden lg:flex w-72 flex-col space-y-6 shrink-0 h-[calc(100vh-120px)] sticky top-24 overflow-y-auto pr-2">
            <!-- User Card -->
            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl text-center">
                <div class="relative w-24 h-24 mx-auto mb-4">
                    <div class="absolute -inset-1 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-full blur opacity-40"></div>
                    <img src="<%= avatarUrl %>" alt="<%= userName %>" class="relative w-24 h-24 rounded-full border-4 border-[#161b22] bg-[#0d1117]">
                    <div class="absolute bottom-1 right-1 w-4 h-4 bg-green-500 border-4 border-[#161b22] rounded-full"></div>
                </div>
                <h4 class="font-bold text-lg"><%= userName %></h4>
                <span class="inline-block px-3 py-1 bg-green-500/10 text-green-500 text-[10px] font-bold rounded-full uppercase tracking-widest border border-green-500/20 mt-2"><%= userRole %></span>
                
                <div class="grid grid-cols-3 gap-2 mt-8 pt-6 border-t border-white/5">
                    <div>
                        <div class="text-sm font-bold text-white">12</div>
                        <div class="text-[8px] font-bold text-white/30 uppercase tracking-widest mt-1">Posts</div>
                    </div>
                    <div>
                        <div class="text-sm font-bold text-white">842</div>
                        <div class="text-[8px] font-bold text-white/30 uppercase tracking-widest mt-1">Conns</div>
                    </div>
                    <div>
                        <div class="text-sm font-bold text-white">2.1k</div>
                        <div class="text-[8px] font-bold text-white/30 uppercase tracking-widest mt-1">Follows</div>
                    </div>
                </div>
            </div>

            <!-- Navigation -->
            <nav class="space-y-1">
                <a href="<%= request.getContextPath() %>/pages/home.jsp" class="flex items-center space-x-4 px-6 py-4 bg-blue-600/10 text-white rounded-2xl border border-blue-600/20 transition-all shadow-lg shadow-blue-600/10">
                    <i data-lucide="home" class="w-5 h-5 text-blue-500"></i>
                    <span class="text-sm font-bold tracking-wide">Home</span>
                </a>
                <a href="#" class="flex items-center space-x-4 px-6 py-4 text-white/40 hover:text-white hover:bg-white/5 rounded-2xl transition-all">
                    <i data-lucide="compass" class="w-5 h-5"></i>
                    <span class="text-sm font-bold tracking-wide">Explore</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/projects.jsp" class="flex items-center space-x-4 px-6 py-4 text-white/40 hover:text-white hover:bg-white/5 rounded-2xl transition-all">
                    <i data-lucide="microscope" class="w-5 h-5"></i>
                    <span class="text-sm font-bold tracking-wide">Projects</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/messages.jsp" class="flex items-center space-x-4 px-6 py-4 text-white/40 hover:text-white hover:bg-white/5 rounded-2xl transition-all">
                    <i data-lucide="message-square" class="w-5 h-5"></i>
                    <span class="text-sm font-bold tracking-wide">Messages</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/notifications.jsp" class="flex items-center space-x-4 px-6 py-4 text-white/40 hover:text-white hover:bg-white/5 rounded-2xl transition-all">
                    <i data-lucide="bell" class="w-5 h-5"></i>
                    <span class="text-sm font-bold tracking-wide">Notifications</span>
                </a>
                <a href="<%= request.getContextPath() %>/pages/profile.jsp" class="flex items-center space-x-4 px-6 py-4 text-white/40 hover:text-white hover:bg-white/5 rounded-2xl transition-all">
                    <i data-lucide="user" class="w-5 h-5"></i>
                    <span class="text-sm font-bold tracking-wide">Profile</span>
                </a>
            </nav>

            <button class="w-full py-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-2xl font-bold text-sm shadow-xl shadow-blue-600/20 hover:scale-[1.02] active:scale-[0.98] transition-all">
                Create Project
            </button>
            <form action="<%= request.getContextPath() %>/auth/logout" method="POST" class="mt-2">
                <button type="submit" class="w-full flex items-center justify-center space-x-2 py-3 text-red-400/60 hover:text-red-400 hover:bg-red-500/10 rounded-2xl transition-all text-sm font-bold">
                    <i data-lucide="log-out" class="w-4 h-4"></i>
                    <span>Logout</span>
                </button>
            </form>
        </aside>

        <!-- Main Feed -->
        <main class="flex-1 px-8 space-y-6">
            <!-- Create Post Box -->
            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <div class="flex items-start space-x-4">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Alistair" class="w-12 h-12 rounded-full border border-white/10">
                    <div class="flex-1">
                        <textarea placeholder="Share a breakthrough or project update..." 
                            class="w-full bg-[#0d1117] border border-white/5 rounded-2xl p-5 text-sm text-white placeholder-white/20 focus:outline-none focus:ring-1 focus:ring-blue-500/30 transition-all min-h-[120px] resize-none"></textarea>
                    </div>
                </div>
                <div class="flex items-center justify-between mt-6 pt-6 border-t border-white/5">
                    <div class="flex space-x-6">
                        <button class="flex items-center space-x-2 text-white/40 hover:text-white transition-colors">
                            <i data-lucide="file-text" class="w-4 h-4 text-blue-500"></i>
                            <span class="text-xs font-bold uppercase tracking-wider">Article</span>
                        </button>
                        <button class="flex items-center space-x-2 text-white/40 hover:text-white transition-colors">
                            <i data-lucide="microscope" class="w-4 h-4 text-purple-500"></i>
                            <span class="text-xs font-bold uppercase tracking-wider">Project</span>
                        </button>
                        <button class="flex items-center space-x-2 text-white/40 hover:text-white transition-colors">
                            <i data-lucide="file-plus" class="w-4 h-4 text-green-500"></i>
                            <span class="text-xs font-bold uppercase tracking-wider">File</span>
                        </button>
                    </div>
                    <button class="px-10 py-2.5 bg-blue-600 text-white rounded-xl font-bold text-sm hover:bg-blue-500 transition-all">Post</button>
                </div>
            </div>

            <!-- Post Item 1 -->
            <div class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl space-y-6">
                <div class="flex justify-between items-start">
                    <div class="flex items-center space-x-4">
                        <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah" class="w-12 h-12 rounded-full border border-white/10">
                        <div>
                            <h4 class="font-bold text-white text-base">Dr. Sarah Jenkins</h4>
                            <p class="text-[10px] text-white/40 font-bold uppercase tracking-widest mt-0.5">Lead Biologist @ MIT • 2h ago</p>
                        </div>
                    </div>
                    <span class="px-2 py-0.5 bg-green-500/10 text-green-500 text-[10px] font-bold rounded uppercase tracking-tighter border border-green-500/20">Scientific_Article</span>
                </div>
                <div>
                    <h3 class="text-xl font-bold text-white mb-3">Neuromorphic Computing: A New Frontier in Neural Interfacing</h3>
                    <p class="text-white/60 leading-relaxed text-sm">
                        Our latest research highlights how neuromorphic chips can mimic human synaptic activity with 40% higher efficiency than previous models. This breakthrough suggests that the integration of organic and synthetic systems is closer than...
                    </p>
                </div>
                <!-- PDF Card -->
                <div class="p-4 bg-[#0d1117] border border-white/5 rounded-2xl flex items-center justify-between group cursor-pointer hover:bg-white/5 transition-all">
                    <div class="flex items-center space-x-4">
                        <div class="p-3 bg-red-500/20 text-red-500 rounded-xl">
                            <i data-lucide="file-text" class="w-6 h-6"></i>
                        </div>
                        <div>
                            <h4 class="text-sm font-bold text-white">neuromorphic_breakthrough.pdf</h4>
                            <p class="text-[10px] text-white/30 uppercase tracking-widest mt-1">12.4 MB • PDF Research Paper</p>
                        </div>
                    </div>
                    <i data-lucide="download" class="w-5 h-5 text-white/20 group-hover:text-white transition-colors"></i>
                </div>
                <div class="flex items-center justify-between pt-6 border-t border-white/5">
                    <div class="flex space-x-8">
                        <button class="flex items-center space-x-2 text-white/40 hover:text-white transition-colors">
                            <i data-lucide="thumbs-up" class="w-5 h-5"></i>
                            <span class="text-xs font-bold">1.2k</span>
                        </button>
                        <button class="flex items-center space-x-2 text-white/40 hover:text-white transition-colors">
                            <i data-lucide="message-circle" class="w-5 h-5"></i>
                            <span class="text-xs font-bold">48</span>
                        </button>
                    </div>
                    <button class="flex items-center space-x-2 text-white/40 hover:text-white transition-colors">
                        <i data-lucide="share-2" class="w-5 h-5"></i>
                        <span class="text-xs font-bold">Share</span>
                    </button>
                </div>
            </div>

            <!-- Post Item 2 -->
            <div class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl space-y-6">
                <div class="flex justify-between items-start">
                    <div class="flex items-center space-x-4">
                        <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Julian" class="w-12 h-12 rounded-full border border-white/10">
                        <div>
                            <h4 class="font-bold text-white text-base">Julian Vance</h4>
                            <p class="text-[10px] text-white/40 font-bold uppercase tracking-widest mt-0.5">Student @ Stanford CS • 5h ago</p>
                        </div>
                    </div>
                    <span class="px-2 py-0.5 bg-blue-500/10 text-blue-500 text-[10px] font-bold rounded uppercase tracking-tighter border border-blue-500/20">University_Project</span>
                </div>
                <div>
                    <h3 class="text-xl font-bold text-white mb-3">Project: Decentralized Ledger for Academic Peer Review</h3>
                    <p class="text-white/60 leading-relaxed text-sm">
                        Working on a blockchain-based solution to ensure the integrity of the peer review process. Looking for contributors with Rust experience and a passion for academic ethics.
                    </p>
                </div>
                <!-- Video/Image Placeholder -->
                <div class="relative rounded-3xl overflow-hidden border border-white/5 group cursor-pointer aspect-video bg-[#0d1117] flex items-center justify-center">
                    <img src="https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=1200&q=80" class="absolute inset-0 w-full h-full object-cover opacity-40 group-hover:scale-105 transition-transform duration-700">
                    <div class="relative z-10 p-5 bg-white/10 backdrop-blur-md rounded-full border border-white/20 text-white shadow-2xl">
                        <i data-lucide="play" class="w-10 h-10 fill-current"></i>
                    </div>
                </div>
                <div class="flex items-center space-x-8">
                    <button class="flex items-center space-x-2 text-white/40 hover:text-white transition-colors">
                        <i data-lucide="thumbs-up" class="w-5 h-5"></i>
                        <span class="text-xs font-bold">342</span>
                    </button>
                    <button class="flex items-center space-x-2 text-white/40 hover:text-white transition-colors">
                        <i data-lucide="message-circle" class="w-5 h-5"></i>
                        <span class="text-xs font-bold">15</span>
                    </button>
                </div>
            </div>
        </main>

        <!-- Right Sidebar -->
        <aside class="hidden xl:flex w-80 flex-col space-y-6 shrink-0 h-[calc(100vh-120px)] sticky top-24">
            <!-- People You May Know -->
            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <h3 class="font-bold text-white mb-6">People You May Know</h3>
                <div class="space-y-6">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Elena" class="w-10 h-10 rounded-full border border-white/5">
                            <div>
                                <h4 class="text-xs font-bold">Dr. Elena K.</h4>
                                <p class="text-[9px] text-white/30 font-bold uppercase tracking-widest mt-1">AI Researcher</p>
                            </div>
                        </div>
                        <button class="px-4 py-1.5 bg-white/5 border border-white/10 rounded-lg text-[10px] font-bold hover:bg-white/10 transition-all">Connect</button>
                    </div>
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Marcus" class="w-10 h-10 rounded-full border border-white/5">
                            <div>
                                <h4 class="text-xs font-bold">Marcus Ch...</h4>
                                <p class="text-[9px] text-white/30 font-bold uppercase tracking-widest mt-1">PhD Candidate</p>
                            </div>
                        </div>
                        <button class="px-4 py-1.5 bg-white/5 border border-white/10 rounded-lg text-[10px] font-bold hover:bg-white/10 transition-all">Connect</button>
                    </div>
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Aris" class="w-10 h-10 rounded-full border border-white/5">
                            <div>
                                <h4 class="text-xs font-bold">Prof. Aris T.</h4>
                                <p class="text-[9px] text-white/30 font-bold uppercase tracking-widest mt-1">Ethics Lead</p>
                            </div>
                        </div>
                        <button class="px-4 py-1.5 bg-white/5 border border-white/10 rounded-lg text-[10px] font-bold hover:bg-white/10 transition-all">Connect</button>
                    </div>
                </div>
            </div>

            <!-- Trending Projects -->
            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <h3 class="font-bold text-white mb-6">Trending Projects</h3>
                <div class="space-y-6">
                    <div class="group cursor-pointer">
                        <div class="flex items-center justify-between mb-1">
                            <span class="text-[9px] font-bold text-blue-400 uppercase tracking-widest">Genomics</span>
                            <span class="text-[9px] font-bold text-white/30 flex items-center"><i data-lucide="users" class="w-3 h-3 mr-1"></i> 12</span>
                        </div>
                        <h4 class="text-sm font-bold text-white group-hover:text-blue-400 transition-colors">CRISPR Meta-Analysis 2024</h4>
                    </div>
                    <div class="group cursor-pointer">
                        <div class="flex items-center justify-between mb-1">
                            <span class="text-[9px] font-bold text-purple-400 uppercase tracking-widest">Physics</span>
                            <span class="text-[9px] font-bold text-white/30 flex items-center"><i data-lucide="users" class="w-3 h-3 mr-1"></i> 8</span>
                        </div>
                        <h4 class="text-sm font-bold text-white group-hover:text-purple-400 transition-colors">Dark Matter Simulations</h4>
                    </div>
                    <div class="group cursor-pointer">
                        <div class="flex items-center justify-between mb-1">
                            <span class="text-[9px] font-bold text-green-400 uppercase tracking-widest">Linguistics</span>
                            <span class="text-[9px] font-bold text-white/30 flex items-center"><i data-lucide="users" class="w-3 h-3 mr-1"></i> 24</span>
                        </div>
                        <h4 class="text-sm font-bold text-white group-hover:text-green-400 transition-colors">AI-Language Evolution</h4>
                    </div>
                </div>
            </div>

            <!-- Recent Alert -->
            <div class="p-6 bg-gradient-to-br from-blue-600/20 to-indigo-600/10 border border-blue-500/20 rounded-3xl shadow-lg relative overflow-hidden">
                <div class="absolute top-4 right-4 w-2 h-2 bg-blue-500 rounded-full animate-pulse shadow-[0_0_8px_rgba(59,130,246,0.5)]"></div>
                <h3 class="font-bold text-white mb-3">Recent Alert</h3>
                <p class="text-xs text-white/60 leading-relaxed mb-4">Your paper "Urban Resilience" was cited in 3 new publications today.</p>
                <a href="#" class="text-[10px] font-bold text-blue-400 uppercase tracking-widest hover:text-white transition-colors flex items-center">
                    View Analytics <i data-lucide="arrow-right" class="w-3 h-3 ml-2"></i>
                </a>
            </div>
        </aside>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>
