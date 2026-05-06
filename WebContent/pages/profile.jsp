<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<body class="bg-[#0b0e14] text-white/90 min-h-screen">
    
    <!-- Top Navigation -->
    <nav class="sticky top-0 z-50 bg-[#0d1117] border-b border-white/5 px-6 py-3 flex items-center justify-between">
        <div class="flex items-center space-x-8">
            <div class="text-linkedin-blue font-bold text-xl tracking-tight">IGA Network</div>
            <div class="hidden md:flex space-x-6 text-xs font-bold uppercase tracking-widest text-white/50">
                <a href="#" class="hover:text-white transition-colors">Explore</a>
                <a href="#" class="hover:text-white transition-colors">Network</a>
                <a href="#" class="hover:text-white transition-colors">Resources</a>
            </div>
        </div>
        <div class="flex items-center space-x-6">
            <button class="text-white/50 hover:text-white transition-colors"><i data-lucide="bell" class="w-5 h-5"></i></button>
            <button class="text-white/50 hover:text-white transition-colors"><i data-lucide="mail" class="w-5 h-5"></i></button>
            <img src="<%= avatarUrl %>" alt="<%= userName %>" class="w-8 h-8 rounded-full border border-white/10">
        </div>
    </nav>

    <div class="flex">
        <!-- Left Sidebar -->
        <aside class="hidden lg:flex w-64 flex-col bg-[#0d1117] border-r border-white/5 h-[calc(100vh-64px)] sticky top-16 p-6 overflow-y-auto">
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
                <a href="<%= request.getContextPath() %>/pages/profile.jsp" class="flex items-center space-x-3 px-4 py-3 text-white bg-blue-600/10 border border-blue-600/20 rounded-xl transition-all shadow-lg shadow-blue-600/10">
                    <i data-lucide="user" class="w-5 h-5 text-blue-500"></i>
                    <span class="text-sm font-semibold">Profile</span>
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
            <!-- Profile Header -->
            <div class="relative bg-[#161b22] rounded-3xl overflow-hidden border border-white/5 shadow-2xl mb-8">
                <!-- Cover -->
                <div class="h-48 bg-gradient-to-r from-blue-900/40 via-blue-800/20 to-[#161b22] relative">
                    <div class="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')] opacity-20"></div>
                </div>

                <div class="px-10 pb-10">
                    <div class="relative flex flex-col md:flex-row items-end md:items-center justify-between -mt-20">
                        <div class="flex flex-col md:flex-row items-center md:items-end space-y-4 md:space-y-0 md:space-x-8">
                            <!-- Avatar with Glowing Ring -->
                            <div class="relative">
                                <div class="absolute -inset-1 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-full blur opacity-50"></div>
                                <img src="<%= avatarUrl %>" alt="<%= userName %>" class="relative w-40 h-40 rounded-full border-4 border-[#161b22] bg-[#0d1117] object-cover">
                                <div class="absolute bottom-2 right-2 w-5 h-5 bg-green-500 border-4 border-[#161b22] rounded-full"></div>
                            </div>
                            
                            <div class="pb-2 text-center md:text-left">
                                <div class="flex items-center justify-center md:justify-start space-x-3">
                                    <h1 class="text-3xl font-bold text-white"><%= userName %></h1>
                                    <span class="px-2 py-0.5 bg-green-500/10 text-green-500 text-[10px] font-bold rounded uppercase tracking-tighter border border-green-500/20"><%= userRole %></span>
                                </div>
                                <div class="mt-2 flex flex-wrap justify-center md:justify-start items-center gap-4 text-sm text-white/60">
                                    <span class="px-2 py-0.5 bg-blue-500/10 text-blue-400 text-[10px] font-bold rounded uppercase tracking-tighter border border-blue-400/20">Teacher</span>
                                    <span>Stanford University</span>
                                    <span class="w-1.5 h-1.5 bg-white/20 rounded-full"></span>
                                    <span>Biomedical Engineering</span>
                                    <span class="w-1.5 h-1.5 bg-white/20 rounded-full"></span>
                                    <span>Genomics</span>
                                </div>
                                <div class="mt-6 flex space-x-3">
                                    <button class="px-8 py-2 bg-blue-600 text-white rounded-lg font-bold text-xs hover:bg-blue-500 transition-all shadow-lg shadow-blue-600/20">CONNECT</button>
                                    <button class="px-8 py-2 bg-white/5 border border-white/10 text-white rounded-lg font-bold text-xs hover:bg-white/10 transition-all">FOLLOW</button>
                                    <button class="p-2 bg-white/5 border border-white/10 text-white rounded-lg hover:bg-white/10 transition-all"><i data-lucide="mail" class="w-5 h-5"></i></button>
                                    <button class="p-2 bg-white/5 border border-white/10 text-white rounded-lg hover:bg-white/10 transition-all"><i data-lucide="more-horizontal" class="w-5 h-5"></i></button>
                                </div>
                            </div>
                        </div>

                        <!-- Header Stats -->
                        <div class="hidden xl:flex space-x-10 px-8 py-6 bg-white/5 border border-white/5 rounded-2xl backdrop-blur-sm">
                            <div class="text-center">
                                <div class="text-xl font-bold text-white">12.4k</div>
                                <div class="text-[9px] font-bold text-white/40 uppercase tracking-widest mt-1">Citations</div>
                            </div>
                            <div class="text-center">
                                <div class="text-xl font-bold text-white">184</div>
                                <div class="text-[9px] font-bold text-white/40 uppercase tracking-widest mt-1">Papers</div>
                            </div>
                            <div class="text-center">
                                <div class="text-xl font-bold text-white">3.2k</div>
                                <div class="text-[9px] font-bold text-white/40 uppercase tracking-widest mt-1">Followers</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Content Grid -->
            <div class="grid grid-cols-1 xl:grid-cols-12 gap-8">
                <!-- Center Column -->
                <div class="xl:col-span-8 space-y-8">
                    <!-- About Section -->
                    <div class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl">
                        <h3 class="text-xl font-bold text-white mb-4">About</h3>
                        <p class="text-white/60 leading-relaxed">
                            Senior Research Lead specializing in computational genomics and the application of synthetic biology in clinical environments. With over 15 years of experience at the intersection of AI and healthcare, my work focuses on accelerating therapeutic discovery through distributed network modeling.
                        </p>
                        <div class="mt-6 flex space-x-4">
                            <i data-lucide="globe" class="w-5 h-5 text-white/40 hover:text-white cursor-pointer transition-colors"></i>
                            <i data-lucide="linkedin" class="w-5 h-5 text-white/40 hover:text-white cursor-pointer transition-colors"></i>
                            <i data-lucide="file-text" class="w-5 h-5 text-white/40 hover:text-white cursor-pointer transition-colors"></i>
                        </div>
                    </div>

                    <!-- Expertise Section -->
                    <div class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl">
                        <h3 class="text-xl font-bold text-white mb-6">Expertise & Skills</h3>
                        <div class="flex flex-wrap gap-3">
                            <span class="px-4 py-2 bg-green-500/10 text-green-400 text-xs font-bold rounded-xl border border-green-500/20">CRISPR/Cas9 [EXPERT]</span>
                            <span class="px-4 py-2 bg-blue-500/10 text-blue-400 text-xs font-bold rounded-xl border border-blue-500/20">Neural Networks [INTERMEDIATE]</span>
                            <span class="px-4 py-2 bg-green-500/10 text-green-400 text-xs font-bold rounded-xl border border-green-500/20">Protein Folding [EXPERT]</span>
                            <span class="px-4 py-2 bg-white/5 text-white/50 text-xs font-bold rounded-xl border border-white/10">R Programming [BEGINNER]</span>
                            <span class="px-4 py-2 bg-blue-500/10 text-blue-400 text-xs font-bold rounded-xl border border-blue-500/20">Bayesian Inference [INTERMEDIATE]</span>
                        </div>
                    </div>

                    <!-- Timeline Section -->
                    <div class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl">
                        <h3 class="text-xl font-bold text-white mb-8">Professional Timeline</h3>
                        <div class="space-y-12 relative before:absolute before:left-2.5 before:top-2 before:bottom-2 before:w-0.5 before:bg-white/10">
                            <!-- Timeline Item 1 -->
                            <div class="relative pl-12">
                                <div class="absolute left-0 top-1.5 w-5 h-5 bg-blue-500 border-4 border-[#161b22] rounded-full shadow-lg shadow-blue-500/50"></div>
                                <div class="flex justify-between items-start">
                                    <div>
                                        <h4 class="font-bold text-white text-lg leading-tight">Lead Genomic Researcher</h4>
                                        <p class="text-white/60 text-sm mt-1">Stanford Department of Medicine</p>
                                        <p class="text-white/40 text-xs italic mt-2">Leading a team of 12 researchers in the 'Bio-Neural' initiative.</p>
                                    </div>
                                    <span class="text-[10px] font-bold text-blue-400 uppercase tracking-widest bg-blue-400/10 px-2 py-0.5 rounded border border-blue-400/20">Present</span>
                                </div>
                            </div>
                            <!-- Timeline Item 2 -->
                            <div class="relative pl-12">
                                <div class="absolute left-0 top-1.5 w-5 h-5 bg-white/20 border-4 border-[#161b22] rounded-full"></div>
                                <div class="flex justify-between items-start">
                                    <div>
                                        <h4 class="font-bold text-white text-lg leading-tight">Senior Bio-Engineer</h4>
                                        <p class="text-white/60 text-sm mt-1">Genentech Research Lab</p>
                                    </div>
                                    <span class="text-[10px] font-bold text-white/30 uppercase tracking-widest">2018 - 2021</span>
                                </div>
                            </div>
                            <!-- Timeline Item 3 -->
                            <div class="relative pl-12">
                                <div class="absolute left-0 top-1.5 w-5 h-5 bg-white/20 border-4 border-[#161b22] rounded-full"></div>
                                <div class="flex justify-between items-start">
                                    <div>
                                        <h4 class="font-bold text-white text-lg leading-tight">Doctoral Researcher</h4>
                                        <p class="text-white/60 text-sm mt-1">MIT Media Lab</p>
                                    </div>
                                    <span class="text-[10px] font-bold text-white/30 uppercase tracking-widest">2014 - 2018</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="xl:col-span-4 space-y-8">
                    <!-- Recent Insights -->
                    <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                        <div class="flex justify-between items-center mb-6">
                            <h3 class="text-lg font-bold text-white">Recent Insights</h3>
                            <a href="#" class="text-[10px] font-bold text-white/40 uppercase hover:text-white transition-colors">View All</a>
                        </div>
                        <div class="space-y-6">
                            <div class="group cursor-pointer">
                                <div class="h-32 rounded-2xl overflow-hidden mb-3 border border-white/5 relative">
                                    <img src="https://images.unsplash.com/photo-1576086213369-97a306d36557?w=400&q=80" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                                    <div class="absolute inset-0 bg-gradient-to-t from-[#0b0e14] to-transparent opacity-60"></div>
                                </div>
                                <p class="text-[10px] font-bold text-white/40 uppercase tracking-widest mb-1">Feb 12, 2024</p>
                                <h4 class="text-sm font-bold text-white group-hover:text-blue-400 transition-colors">The Ethics of CRISPR in Private Clinical Settings</h4>
                            </div>
                            <div class="group cursor-pointer">
                                <div class="h-32 rounded-2xl overflow-hidden mb-3 border border-white/5 relative">
                                    <img src="https://images.unsplash.com/photo-1532187863486-abf9d39d999e?w=400&q=80" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                                    <div class="absolute inset-0 bg-gradient-to-t from-[#0b0e14] to-transparent opacity-60"></div>
                                </div>
                                <p class="text-[10px] font-bold text-white/40 uppercase tracking-widest mb-1">Jan 28, 2024</p>
                                <h4 class="text-sm font-bold text-white group-hover:text-blue-400 transition-colors">Distributed Computing for Genomic Sequencing</h4>
                            </div>
                        </div>
                    </div>

                    <!-- Active Initiatives -->
                    <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                        <h3 class="text-lg font-bold text-white mb-6">Active Initiatives</h3>
                        <div class="space-y-4">
                            <div class="p-4 bg-white/5 border border-white/5 rounded-2xl flex items-center space-x-4 group cursor-pointer hover:bg-white/10 transition-all">
                                <div class="p-3 bg-blue-500/20 text-blue-400 rounded-xl">
                                    <i data-lucide="cpu" class="w-5 h-5"></i>
                                </div>
                                <div class="flex-1">
                                    <h4 class="text-sm font-bold text-white">Project: Alpha-Helix v2</h4>
                                    <div class="mt-2 w-full h-1 bg-white/5 rounded-full overflow-hidden">
                                        <div class="w-3/4 h-full bg-blue-500 shadow-[0_0_8px_rgba(59,130,246,0.5)]"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="p-4 bg-white/5 border border-white/5 rounded-2xl flex items-center space-x-4 group cursor-pointer hover:bg-white/10 transition-all">
                                <div class="p-3 bg-purple-500/20 text-purple-400 rounded-xl">
                                    <i data-lucide="brain" class="w-5 h-5"></i>
                                </div>
                                <div class="flex-1">
                                    <h4 class="text-sm font-bold text-white">Neural-Synth Interface</h4>
                                    <div class="mt-2 w-full h-1 bg-white/5 rounded-full overflow-hidden">
                                        <div class="w-1/2 h-full bg-purple-500 shadow-[0_0_8px_rgba(168,85,247,0.5)]"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Credentials -->
                    <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                        <h3 class="text-lg font-bold text-white mb-6">Credentials</h3>
                        <div class="space-y-4">
                            <div class="flex items-center space-x-3 text-sm">
                                <i data-lucide="check-circle" class="w-4 h-4 text-green-500"></i>
                                <span class="text-white/70">PhD in Molecular Biology (MIT)</span>
                            </div>
                            <div class="flex items-center space-x-3 text-sm">
                                <i data-lucide="check-circle" class="w-4 h-4 text-green-500"></i>
                                <span class="text-white/70">Senior Fellow - Academy of Sciences</span>
                            </div>
                            <div class="flex items-center space-x-3 text-sm">
                                <i data-lucide="award" class="w-4 h-4 text-orange-400"></i>
                                <span class="text-white/70">Lasker Award for Basic Research</span>
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
