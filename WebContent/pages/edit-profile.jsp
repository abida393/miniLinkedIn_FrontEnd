<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    request.setAttribute("pageTitle", "Edit Profile | IGA Network");
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
    <jsp:include page="../partials/navbar.jsp" />

    <div class="flex flex-1">
        <!-- Left Sidebar -->
        <jsp:include page="../partials/sidebar.jsp" />

        <!-- Main Content Area -->
        <main class="flex-1 p-8 max-w-4xl mx-auto w-full">
            <div class="mb-6 flex justify-between items-center">
                <a href="<%= request.getContextPath() %>/pages/profile.jsp" class="text-xs font-bold text-blue-400 hover:text-blue-300 transition-colors inline-flex items-center">
                    <i data-lucide="arrow-left" class="w-3 h-3 mr-1"></i> Back to Profile
                </a>
            </div>

            <div class="bg-[#161b22] rounded-3xl border border-white/5 shadow-2xl overflow-hidden mb-12">
                <!-- Header Banner Edit -->
                <div class="h-32 bg-gradient-to-r from-blue-900/40 via-purple-900/20 to-blue-900/40 relative group">
                    <button class="absolute inset-0 w-full h-full bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center text-white/80 font-bold text-sm">
                        <i data-lucide="camera" class="w-5 h-5 mr-2"></i> Update Cover Photo
                    </button>
                </div>

                <div class="p-8">
                    <!-- Avatar Edit -->
                    <div class="relative -mt-20 mb-8 w-24 h-24 group">
                        <img src="<%= avatarUrl %>" alt="Avatar" class="w-24 h-24 rounded-full border-4 border-[#161b22] bg-[#0d1117] object-cover">
                        <button class="absolute inset-0 w-full h-full bg-black/60 opacity-0 group-hover:opacity-100 rounded-full transition-opacity flex items-center justify-center text-white border-4 border-[#161b22]">
                            <i data-lucide="camera" class="w-5 h-5"></i>
                        </button>
                    </div>

                    <!-- Profile Form -->
                    <form id="update-profile-form" class="space-y-6">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="space-y-2">
                                <label class="text-[10px] font-bold text-white/40 uppercase tracking-widest">First Name</label>
                                <input type="text" id="first-name" name="first_name" value="<%= userName.split(" ")[0] %>" class="w-full bg-[#0d1117] border border-white/5 rounded-xl px-4 py-3 text-sm text-white focus:outline-none focus:ring-1 focus:ring-blue-500/50 transition-all">
                            </div>
                            <div class="space-y-2">
                                <label class="text-[10px] font-bold text-white/40 uppercase tracking-widest">Last Name</label>
                                <input type="text" id="last-name" name="last_name" value="<%= userName.contains(" ") ? userName.substring(userName.indexOf(" ") + 1) : "" %>" class="w-full bg-[#0d1117] border border-white/5 rounded-xl px-4 py-3 text-sm text-white focus:outline-none focus:ring-1 focus:ring-blue-500/50 transition-all">
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label class="text-[10px] font-bold text-white/40 uppercase tracking-widest">Headline</label>
                            <input type="text" id="headline" name="headline" placeholder="e.g. PhD Student at IGA" class="w-full bg-[#0d1117] border border-white/5 rounded-xl px-4 py-3 text-sm text-white focus:outline-none focus:ring-1 focus:ring-blue-500/50 transition-all">
                        </div>

                        <div class="space-y-2">
                            <div class="flex justify-between items-center">
                                <label class="text-[10px] font-bold text-white/40 uppercase tracking-widest">About (Bio)</label>
                                <button type="button" id="generate-ai-bio" class="text-[9px] font-bold text-purple-400 uppercase tracking-widest flex items-center hover:text-purple-300 transition-colors">
                                    <i data-lucide="sparkles" class="w-3 h-3 mr-1"></i> Generate with AI
                                </button>
                            </div>
                            <textarea id="bio-input" name="bio" rows="4" class="w-full bg-[#0d1117] border border-white/5 rounded-xl px-4 py-3 text-sm text-white focus:outline-none focus:ring-1 focus:ring-blue-500/50 leading-relaxed transition-all"></textarea>
                        </div>
                        
                        <div class="flex justify-end pt-4">
                            <button type="submit" class="px-10 py-3 bg-blue-600 hover:bg-blue-500 text-white rounded-xl font-bold transition-all shadow-lg shadow-blue-600/20">Save Profile</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Dynamic Sections (Skills, Experience, etc.) -->
            <div class="space-y-8 pb-20">
                <!-- Skills Section -->
                <div class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl">
                    <div class="flex justify-between items-center mb-6">
                        <h3 class="text-lg font-bold text-white uppercase tracking-widest text-white/60">Skills</h3>
                        <button type="button" onclick="showAddSkillModal()" class="text-xs text-blue-400 hover:text-white transition-colors font-bold flex items-center">
                            <i data-lucide="plus" class="w-3 h-3 mr-1"></i> Add Skill
                        </button>
                    </div>
                    <div id="skills-list" class="flex flex-wrap gap-3">
                        <!-- Skills will be loaded here -->
                    </div>
                </div>

                <!-- Experiences Section -->
                <div class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl">
                    <div class="flex justify-between items-center mb-6">
                        <h3 class="text-lg font-bold text-white uppercase tracking-widest text-white/60">Experience</h3>
                        <button type="button" onclick="showAddExperienceModal()" class="text-xs text-blue-400 hover:text-white transition-colors font-bold flex items-center">
                            <i data-lucide="plus" class="w-3 h-3 mr-1"></i> Add Experience
                        </button>
                    </div>
                    <div id="experiences-list" class="space-y-4">
                        <!-- Experiences will be loaded here -->
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();
        document.addEventListener('DOMContentLoaded', () => {
            // Load existing profile data
            if (typeof window.loadEditProfileData === 'function') {
                window.loadEditProfileData();
            }
        });
    </script>
</body>
</html>
