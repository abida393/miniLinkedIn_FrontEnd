<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "Admin Dashboard | IGA Network");
    HttpSession userSession = request.getSession(false);
    String userName  = userSession != null && userSession.getAttribute("userName")  != null ? (String) userSession.getAttribute("userName")  : "Admin";
    String userRole  = userSession != null && userSession.getAttribute("userRole")  != null ? (String) userSession.getAttribute("userRole")  : "ADMIN";
    String userEmail = userSession != null && userSession.getAttribute("userEmail") != null ? (String) userSession.getAttribute("userEmail") : "";
    String avatarSeed = userEmail.isEmpty() ? "admin" : userEmail.replace("@","-");
    String avatarUrl  = "https://api.dicebear.com/7.x/avataaars/svg?seed=" + avatarSeed;
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
                <input type="text" placeholder="Search systems..." 
                    class="w-full bg-[#161b22] border border-white/5 rounded-full py-2 pl-12 pr-4 text-sm text-white focus:outline-none focus:ring-1 focus:ring-blue-500/50 transition-all">
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
                <div class="p-2 bg-blue-600/20 rounded-lg">
                    <i data-lucide="shield-check" class="w-6 h-6 text-blue-500"></i>
                </div>
                <div>
                    <h4 class="text-sm font-bold"><%= userName %></h4>
                    <p class="text-[10px] text-white/40 uppercase tracking-widest font-bold"><%= userRole %></p>
                </div>
            </div>

            <nav class="flex-1 space-y-1">
                <a href="<%= request.getContextPath() %>/pages/home.jsp" class="flex items-center space-x-3 px-4 py-3 text-white bg-blue-600/10 border border-blue-600/20 rounded-xl transition-all shadow-lg shadow-blue-600/10">
                    <i data-lucide="layout-dashboard" class="w-5 h-5 text-blue-500"></i>
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
        <main class="flex-1 p-8 space-y-8 overflow-y-auto">
            <!-- Header Section -->
            <div class="flex justify-between items-end">
                <div>
                    <h1 class="text-4xl font-bold text-white mb-2">System Overview</h1>
                    <p class="text-white/40 text-sm italic">Welcome back, Admin. System pulse is steady at 98.4% uptime.</p>
                </div>
                <div class="text-right">
                    <div class="text-[10px] font-bold text-white/40 uppercase tracking-widest mb-1">October 24, 2023</div>
                    <div class="text-sm font-bold text-white">09:42 AM EST</div>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
                <!-- Stat Card 1 -->
                <div class="bg-[#161b22] p-6 rounded-3xl border border-white/5 shadow-xl relative overflow-hidden group">
                    <div class="flex justify-between items-start mb-4">
                        <h3 class="text-[10px] font-bold text-white/30 uppercase tracking-[0.2em]">Total Users</h3>
                        <i data-lucide="users" class="w-4 h-4 text-white/20"></i>
                    </div>
                    <div class="flex items-end space-x-3 mb-6">
                        <div class="text-3xl font-bold">12,842</div>
                        <div class="text-[10px] font-bold text-green-500 flex items-center mb-1">
                            <i data-lucide="trending-up" class="w-3 h-3 mr-1"></i> 12%
                        </div>
                    </div>
                    <!-- Sparkline Mockup -->
                    <div class="h-12 w-full flex items-end space-x-1">
                        <div class="flex-1 bg-green-500/20 rounded-t h-[40%] group-hover:h-[60%] transition-all"></div>
                        <div class="flex-1 bg-green-500/20 rounded-t h-[30%] group-hover:h-[50%] transition-all"></div>
                        <div class="flex-1 bg-green-500/20 rounded-t h-[60%] group-hover:h-[80%] transition-all"></div>
                        <div class="flex-1 bg-green-500/20 rounded-t h-[45%] group-hover:h-[65%] transition-all"></div>
                        <div class="flex-1 bg-green-500/20 rounded-t h-[70%] group-hover:h-[90%] transition-all"></div>
                        <div class="flex-1 bg-green-500/40 rounded-t h-[90%] group-hover:h-[100%] transition-all"></div>
                    </div>
                </div>

                <!-- Stat Card 2 -->
                <div class="bg-[#161b22] p-6 rounded-3xl border border-white/5 shadow-xl relative overflow-hidden group">
                    <div class="flex justify-between items-start mb-4">
                        <h3 class="text-[10px] font-bold text-white/30 uppercase tracking-[0.2em]">Active Projects</h3>
                        <i data-lucide="microscope" class="w-4 h-4 text-white/20"></i>
                    </div>
                    <div class="flex items-end space-x-3 mb-6">
                        <div class="text-3xl font-bold">843</div>
                        <div class="text-[10px] font-bold text-green-500 flex items-center mb-1">
                            <i data-lucide="trending-up" class="w-3 h-3 mr-1"></i> 4%
                        </div>
                    </div>
                    <div class="h-12 w-full flex items-end space-x-1">
                        <div class="flex-1 bg-blue-500/20 rounded-t h-[20%]"></div>
                        <div class="flex-1 bg-blue-500/20 rounded-t h-[40%]"></div>
                        <div class="flex-1 bg-blue-500/20 rounded-t h-[35%]"></div>
                        <div class="flex-1 bg-blue-500/20 rounded-t h-[65%]"></div>
                        <div class="flex-1 bg-blue-500/20 rounded-t h-[50%]"></div>
                        <div class="flex-1 bg-blue-500/40 rounded-t h-[80%]"></div>
                    </div>
                </div>

                <!-- Stat Card 3 -->
                <div class="bg-[#161b22] p-6 rounded-3xl border border-white/5 shadow-xl relative overflow-hidden group">
                    <div class="flex justify-between items-start mb-4">
                        <h3 class="text-[10px] font-bold text-white/30 uppercase tracking-[0.2em]">Pending Reports</h3>
                        <i data-lucide="flag" class="w-4 h-4 text-white/20"></i>
                    </div>
                    <div class="flex items-end space-x-3 mb-6">
                        <div class="text-3xl font-bold">24</div>
                        <div class="text-[10px] font-bold text-red-500 flex items-center mb-1">
                            <i data-lucide="trending-down" class="w-3 h-3 mr-1"></i> 8%
                        </div>
                    </div>
                    <div class="h-12 w-full flex items-end space-x-1">
                        <div class="flex-1 bg-red-500/20 rounded-t h-[80%]"></div>
                        <div class="flex-1 bg-red-500/20 rounded-t h-[60%]"></div>
                        <div class="flex-1 bg-red-500/20 rounded-t h-[90%]"></div>
                        <div class="flex-1 bg-red-500/20 rounded-t h-[40%]"></div>
                        <div class="flex-1 bg-red-500/20 rounded-t h-[30%]"></div>
                        <div class="flex-1 bg-red-500/40 rounded-t h-[15%]"></div>
                    </div>
                </div>

                <!-- Stat Card 4 -->
                <div class="bg-[#161b22] p-6 rounded-3xl border border-white/5 shadow-xl relative overflow-hidden group">
                    <div class="flex justify-between items-start mb-4">
                        <h3 class="text-[10px] font-bold text-white/30 uppercase tracking-[0.2em]">New Today</h3>
                        <i data-lucide="user-plus" class="w-4 h-4 text-white/20"></i>
                    </div>
                    <div class="flex items-end space-x-3 mb-6">
                        <div class="text-3xl font-bold">156</div>
                        <div class="text-[10px] font-bold text-green-500 flex items-center mb-1">
                            <i data-lucide="trending-up" class="w-3 h-3 mr-1"></i> 22%
                        </div>
                    </div>
                    <div class="h-12 w-full flex items-end space-x-1">
                        <div class="flex-1 bg-indigo-500/20 rounded-t h-[30%]"></div>
                        <div class="flex-1 bg-indigo-500/20 rounded-t h-[45%]"></div>
                        <div class="flex-1 bg-indigo-500/20 rounded-t h-[25%]"></div>
                        <div class="flex-1 bg-indigo-500/20 rounded-t h-[70%]"></div>
                        <div class="flex-1 bg-indigo-500/20 rounded-t h-[55%]"></div>
                        <div class="flex-1 bg-indigo-500/40 rounded-t h-[95%]"></div>
                    </div>
                </div>
            </div>

            <!-- Charts Grid -->
            <div class="grid grid-cols-1 xl:grid-cols-12 gap-8">
                <!-- User Activity Chart -->
                <div class="xl:col-span-8 bg-[#161b22] p-8 rounded-3xl border border-white/5 shadow-xl">
                    <div class="flex justify-between items-center mb-10">
                        <h3 class="text-xl font-bold text-white">User Activity Over Time</h3>
                        <div class="flex bg-[#0d1117] p-1 rounded-xl border border-white/5">
                            <button class="px-4 py-1.5 text-[10px] font-bold text-white/40 hover:text-white transition-colors">Weekly</button>
                            <button class="px-4 py-1.5 text-[10px] font-bold text-white bg-blue-600 rounded-lg">Monthly</button>
                        </div>
                    </div>
                    <div class="h-64 flex items-end justify-between space-x-4">
                        <div class="flex-1 space-y-4">
                            <div class="w-full bg-white/5 rounded-t-lg h-[40%] hover:bg-white/10 transition-all cursor-pointer relative group">
                                <div class="absolute -top-10 left-1/2 -translate-x-1/2 bg-blue-600 px-2 py-1 rounded text-[10px] font-bold opacity-0 group-hover:opacity-100 transition-all">4.2k</div>
                            </div>
                            <div class="text-[10px] font-bold text-white/20 uppercase text-center">Jun</div>
                        </div>
                        <div class="flex-1 space-y-4">
                            <div class="w-full bg-white/5 rounded-t-lg h-[65%]"></div>
                            <div class="text-[10px] font-bold text-white/20 uppercase text-center">Jul</div>
                        </div>
                        <div class="flex-1 space-y-4">
                            <div class="w-full bg-white/5 rounded-t-lg h-[50%]"></div>
                            <div class="text-[10px] font-bold text-white/20 uppercase text-center">Aug</div>
                        </div>
                        <div class="flex-1 space-y-4">
                            <div class="w-full bg-white/5 rounded-t-lg h-[80%]"></div>
                            <div class="text-[10px] font-bold text-white/20 uppercase text-center">Sep</div>
                        </div>
                        <div class="flex-1 space-y-4">
                            <div class="w-full bg-white/5 rounded-t-lg h-[70%]"></div>
                            <div class="text-[10px] font-bold text-white/20 uppercase text-center">Oct</div>
                        </div>
                        <div class="flex-1 space-y-4">
                            <div class="w-full bg-blue-500/20 rounded-t-lg h-[95%] border-t-2 border-blue-500"></div>
                            <div class="text-[10px] font-bold text-white/20 uppercase text-center">Nov</div>
                        </div>
                        <div class="flex-1 space-y-4">
                            <div class="w-full bg-white/5 rounded-t-lg h-[85%]"></div>
                            <div class="text-[10px] font-bold text-white/20 uppercase text-center">Dec</div>
                        </div>
                    </div>
                </div>

                <!-- Users by Role Chart -->
                <div class="xl:col-span-4 bg-[#161b22] p-8 rounded-3xl border border-white/5 shadow-xl flex flex-col">
                    <h3 class="text-xl font-bold text-white mb-10">Users by Role</h3>
                    <div class="flex-1 flex items-center justify-center relative">
                        <!-- Donut Chart Mockup -->
                        <div class="relative w-48 h-48 rounded-full border-[16px] border-blue-600/20 flex items-center justify-center">
                            <div class="absolute inset-[-16px] rounded-full border-[16px] border-transparent border-t-blue-500 border-r-indigo-500 rotate-[45deg]"></div>
                            <div class="absolute inset-[-16px] rounded-full border-[16px] border-transparent border-l-green-400 rotate-[200deg]"></div>
                            <div class="text-center">
                                <div class="text-2xl font-bold text-white">Role</div>
                                <div class="text-[9px] font-bold text-white/30 uppercase tracking-[0.2em]">Distribution</div>
                            </div>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-4 mt-10">
                        <div class="flex items-center space-x-3">
                            <span class="w-2 h-2 rounded-full bg-blue-500"></span>
                            <span class="text-[10px] font-bold text-white/50 uppercase tracking-widest">Students (45%)</span>
                        </div>
                        <div class="flex items-center space-x-3">
                            <span class="w-2 h-2 rounded-full bg-indigo-500"></span>
                            <span class="text-[10px] font-bold text-white/50 uppercase tracking-widest">Teachers (25%)</span>
                        </div>
                        <div class="flex items-center space-x-3">
                            <span class="w-2 h-2 rounded-full bg-green-400"></span>
                            <span class="text-[10px] font-bold text-white/50 uppercase tracking-widest">Researchers (20%)</span>
                        </div>
                        <div class="flex items-center space-x-3">
                            <span class="w-2 h-2 rounded-full bg-white"></span>
                            <span class="text-[10px] font-bold text-white/50 uppercase tracking-widest">Admins (10%)</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- User Management Table -->
            <div class="bg-[#161b22] rounded-3xl border border-white/5 shadow-xl overflow-hidden">
                <div class="p-8 border-b border-white/5 flex justify-between items-center">
                    <h3 class="text-xl font-bold text-white">User Management</h3>
                    <button class="px-6 py-2 bg-blue-600 text-white rounded-xl text-[10px] font-bold uppercase tracking-widest hover:bg-blue-500 transition-all shadow-lg shadow-blue-600/20">Export Records</button>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="text-[10px] font-bold text-white/20 uppercase tracking-[0.2em] border-b border-white/5">
                                <th class="px-8 py-6">User Identity</th>
                                <th class="px-8 py-6">Role</th>
                                <th class="px-8 py-6">Status</th>
                                <th class="px-8 py-6">Verification</th>
                                <th class="px-8 py-6 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5">
                            <!-- Row 1 -->
                            <tr class="hover:bg-white/[0.02] transition-all group">
                                <td class="px-8 py-6">
                                    <div class="flex items-center space-x-4">
                                        <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Sarah" class="w-10 h-10 rounded-full border border-white/10">
                                        <div>
                                            <h4 class="text-sm font-bold text-white">Dr. Sarah Jenkins</h4>
                                            <p class="text-[10px] text-white/30">s.jenkins@academy.edu</p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-8 py-6">
                                    <span class="px-3 py-1 bg-green-500/10 text-green-500 text-[9px] font-bold rounded-lg border border-green-500/20">RESEARCHER</span>
                                </td>
                                <td class="px-8 py-6">
                                    <div class="flex items-center space-x-2">
                                        <span class="w-1.5 h-1.5 bg-green-500 rounded-full"></span>
                                        <span class="text-[10px] font-bold text-white/60">ACTIVE</span>
                                    </div>
                                </td>
                                <td class="px-8 py-6">
                                    <i data-lucide="verified" class="w-5 h-5 text-blue-500"></i>
                                </td>
                                <td class="px-8 py-6 text-right space-x-4">
                                    <button class="text-white/20 hover:text-white transition-colors"><i data-lucide="edit-2" class="w-4 h-4"></i></button>
                                    <button class="text-white/20 hover:text-red-500 transition-colors"><i data-lucide="ban" class="w-4 h-4"></i></button>
                                </td>
                            </tr>
                            <!-- Row 2 -->
                            <tr class="hover:bg-white/[0.02] transition-all group">
                                <td class="px-8 py-6">
                                    <div class="flex items-center space-x-4">
                                        <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Marcus" class="w-10 h-10 rounded-full border border-white/10">
                                        <div>
                                            <h4 class="text-sm font-bold text-white">Marcus Thorne</h4>
                                            <p class="text-[10px] text-white/30">m.thorne@iga.net</p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-8 py-6">
                                    <span class="px-3 py-1 bg-blue-500/10 text-blue-500 text-[9px] font-bold rounded-lg border border-blue-500/20">STUDENT</span>
                                </td>
                                <td class="px-8 py-6">
                                    <div class="flex items-center space-x-2">
                                        <span class="w-1.5 h-1.5 bg-orange-500 rounded-full animate-pulse"></span>
                                        <span class="text-[10px] font-bold text-white/60">PENDING</span>
                                    </div>
                                </td>
                                <td class="px-8 py-6">
                                    <i data-lucide="help-circle" class="w-5 h-5 text-white/10"></i>
                                </td>
                                <td class="px-8 py-6 text-right space-x-4">
                                    <button class="px-4 py-1.5 bg-white/5 border border-white/10 rounded-lg text-[9px] font-bold hover:bg-blue-600 hover:border-blue-600 transition-all">VALIDATE</button>
                                    <button class="text-white/20 hover:text-red-500 transition-colors"><i data-lucide="trash-2" class="w-4 h-4"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Incident Reports Table -->
            <div class="bg-[#161b22] rounded-3xl border border-white/5 shadow-xl overflow-hidden">
                <div class="p-8 border-b border-white/5 flex justify-between items-center">
                    <h3 class="text-xl font-bold text-white">Incident Reports</h3>
                    <span class="px-3 py-1 bg-red-500/10 text-red-500 text-[9px] font-bold rounded-full border border-red-500/20 uppercase tracking-widest animate-pulse">24 Critical</span>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs">
                        <thead>
                            <tr class="text-[10px] font-bold text-white/20 uppercase tracking-[0.2em] border-b border-white/5">
                                <th class="px-8 py-6">Reporter</th>
                                <th class="px-8 py-6">Type</th>
                                <th class="px-8 py-6">Reason</th>
                                <th class="px-8 py-6">Date</th>
                                <th class="px-8 py-6 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5">
                            <tr class="hover:bg-white/[0.02] transition-all">
                                <td class="px-8 py-6 font-bold text-white">Admin_Automator</td>
                                <td class="px-8 py-6"><span class="text-red-400 font-bold underline decoration-red-400/30">Plagiarism</span></td>
                                <td class="px-8 py-6 text-white/40 italic">High similarity index (92%) detected in Project #2039.</td>
                                <td class="px-8 py-6 text-white/60">Oct 24, 08:30</td>
                                <td class="px-8 py-6 text-right space-x-6">
                                    <button class="text-blue-400 font-bold uppercase tracking-widest hover:text-white transition-all">Resolve</button>
                                    <button class="text-white/20 font-bold uppercase tracking-widest hover:text-white transition-all">Dismiss</button>
                                </td>
                            </tr>
                            <tr class="hover:bg-white/[0.02] transition-all">
                                <td class="px-8 py-6 font-bold text-white">User_ElenaV</td>
                                <td class="px-8 py-6"><span class="text-blue-400 font-bold underline decoration-blue-400/30">Harassment</span></td>
                                <td class="px-8 py-6 text-white/40 italic">Unprofessional conduct in collaboration chat.</td>
                                <td class="px-8 py-6 text-white/60">Oct 23, 14:15</td>
                                <td class="px-8 py-6 text-right space-x-6">
                                    <button class="text-blue-400 font-bold uppercase tracking-widest hover:text-white transition-all">Resolve</button>
                                    <button class="text-white/20 font-bold uppercase tracking-widest hover:text-white transition-all">Dismiss</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>
