<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
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
    <jsp:include page="../partials/navbar.jsp" />

    <div class="max-w-[1440px] mx-auto flex px-6 py-8">
        <!-- Left Sidebar -->
        <jsp:include page="../partials/sidebar.jsp" />

        <!-- Main Feed -->
        <main class="flex-1 px-8 space-y-6">
            <!-- Create Post Box -->
            <form id="create-post-form" class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <div class="flex items-start space-x-4">
                    <img src="<%= avatarUrl %>" class="w-12 h-12 rounded-full border border-white/10">
                    <div class="flex-1">
                        <textarea id="post-content" name="content" placeholder="Share a breakthrough or project update..." 
                            class="w-full bg-[#0d1117] border border-white/5 rounded-2xl p-5 text-sm text-white placeholder-white/20 focus:outline-none focus:ring-1 focus:ring-blue-500/30 transition-all min-h-[120px] resize-none"></textarea>
                    </div>
                </div>
                <div class="flex items-center justify-between mt-6 pt-6 border-t border-white/5">
                    <div class="flex space-x-6">
                        <select id="post-type" class="bg-[#0d1117] border border-white/5 rounded-lg p-2 text-xs text-white/60 focus:outline-none">
                            <option value="GENERAL">General</option>
                            <option value="ARTICLE">Article</option>
                            <option value="PROJECT">Project</option>
                            <option value="RESEARCH">Research</option>
                        </select>
                        <input type="file" id="post-file" accept=".pdf,.jpg,.png,.gif,.mp4" class="hidden">
                        <button type="button" onclick="document.getElementById('post-file').click()" class="flex items-center space-x-2 text-white/40 hover:text-white transition-colors">
                            <i data-lucide="paperclip" class="w-4 h-4"></i>
                            <span class="text-xs font-bold">Attach</span>
                        </button>
                    </div>
                    <button type="submit" class="px-10 py-2.5 bg-blue-600 text-white rounded-xl font-bold text-sm hover:bg-blue-500 transition-all">Post</button>
                </div>
            </form>

            <!-- Posts Container -->
            <div id="posts-container" class="space-y-6">
                <!-- Posts will be rendered here by JavaScript -->
            </div>
        </main>

        <!-- Right Sidebar -->
        <aside class="hidden xl:flex w-80 flex-col space-y-6 shrink-0 h-[calc(100vh-120px)] sticky top-24">
            <!-- People You May Know -->
            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="font-bold text-white">Suggested for you</h3>
                    <a href="network.jsp" class="text-[10px] font-bold text-blue-500 hover:text-white transition-colors uppercase tracking-widest">View All</a>
                </div>
                <div id="home-suggestions-container" class="space-y-6">
                    <p class="text-[10px] text-white/20 uppercase tracking-widest text-center py-4 font-bold">Loading...</p>
                </div>
            </div>

            <!-- Trending Projects -->
            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="font-bold text-white">Trending Projects</h3>
                    <a href="projects.jsp" class="text-[10px] font-bold text-blue-500 hover:text-white transition-colors uppercase tracking-widest">Browse</a>
                </div>
                <div id="home-trending-container" class="space-y-6">
                    <p class="text-[10px] text-white/20 uppercase tracking-widest text-center py-4 font-bold">Loading...</p>
                </div>
            </div>

            <!-- Recent Alert -->
            <div id="home-alert-container" class="hidden">
            </div>
        </aside>
    </div>

    <script>
        async function loadHomeSidebarData() {
            const CTX_HOME = window.IGA_CONFIG?.contextPath || '/MiniLinkedIn';
            try {
                // Load Suggestions
                const sugResp = await fetch(CTX_HOME + '/api/network/suggestions');
                if (sugResp.ok) {
                    const data = await sugResp.json();
                    const users = unwrapApiResponse(data, 'suggestions').slice(0, 3);
                    const container = document.getElementById('home-suggestions-container');
                    if (users.length > 0) {
                        container.innerHTML = users.map(function(user) {
                            const avatarSeed = (user.email || 'default').replace('@', '-');
                            const avatarUrl = 'https://api.dicebear.com/7.x/avataaars/svg?seed=' + avatarSeed;
                            return '<div class="flex items-center justify-between group">' +
                                '<div class="flex items-center space-x-3">' +
                                    '<img src="' + avatarUrl + '" class="w-10 h-10 rounded-full border border-white/5 bg-[#0d1117]">' +
                                    '<div class="min-w-0">' +
                                        '<h4 class="text-xs font-bold text-white truncate">' + user.first_name + ' ' + user.last_name + '</h4>' +
                                        '<p class="text-[9px] text-white/30 font-bold uppercase tracking-widest mt-1 truncate">' + (user.role || 'Member') + '</p>' +
                                    '</div>' +
                                '</div>' +
                                '<button onclick="sendConnectionRequest(' + user.id + ')" class="p-2 text-white/20 hover:text-blue-500 transition-colors">' +
                                    '<i data-lucide="user-plus" class="w-4 h-4"></i>' +
                                '</button>' +
                            '</div>';
                        }).join('');
                        lucide.createIcons();
                    } else {
                        container.innerHTML = '<p class="text-[10px] text-white/10 text-center font-bold">No suggestions</p>';
                    }
                }

                // Load Projects
                const projResp = await fetch(CTX_HOME + '/api/projects');
                if (projResp.ok) {
                    const data = await projResp.json();
                    const projects = unwrapApiResponse(data, 'projects').slice(0, 3);
                    const container = document.getElementById('home-trending-container');
                    if (projects.length > 0) {
                        container.innerHTML = projects.map(function(proj) {
                            return '<div onclick="viewProjectDetails(' + proj.id + ')" class="group cursor-pointer">' +
                                '<div class="flex items-center justify-between mb-1">' +
                                    '<span class="text-[9px] font-bold text-blue-400 uppercase tracking-widest">' + (proj.type || 'Research') + '</span>' +
                                    '<span class="text-[9px] font-bold text-white/30 flex items-center">' +
                                        '<i data-lucide="users" class="w-3 h-3 mr-1"></i> ' + (proj.member_count || 0) +
                                    '</span>' +
                                '</div>' +
                                '<h4 class="text-sm font-bold text-white group-hover:text-blue-400 transition-colors truncate">' + proj.title + '</h4>' +
                            '</div>';
                        }).join('');
                        lucide.createIcons();
                    } else {
                        container.innerHTML = '<p class="text-[10px] text-white/10 text-center font-bold">No trending projects</p>';
                    }
                }
            } catch (err) {
                console.error('Home Sidebar Error:', err);
            }
        }
        document.addEventListener('DOMContentLoaded', loadHomeSidebarData);
    </script>

    <!-- Comment Modal -->
    <div id="comment-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm">
      <div class="bg-[#161b22] rounded-3xl border border-white/5 shadow-2xl p-8 w-full max-w-lg mx-4">
        <div class="flex justify-between items-center mb-6">
          <h3 class="text-lg font-bold text-white">Add Comment</h3>
          <button onclick="document.getElementById('comment-modal').classList.add('hidden')"
                  class="text-white/30 hover:text-white transition-colors">
            <i data-lucide="x" class="w-5 h-5"></i>
          </button>
        </div>
        <form id="comment-form">
          <textarea id="comment-content" placeholder="Write your comment..." rows="4"
            class="w-full bg-[#0d1117] border border-white/5 rounded-2xl p-4 text-sm text-white 
                   placeholder-white/20 focus:outline-none focus:ring-1 focus:ring-blue-500/30 
                   resize-none mb-6 transition-all"></textarea>
          <div class="flex justify-end space-x-3">
            <button type="button" 
                    onclick="document.getElementById('comment-modal').classList.add('hidden')"
                    class="px-6 py-2.5 text-white/40 hover:text-white font-bold transition-all text-sm">
              Cancel
            </button>
            <button type="button" onclick="submitComment()"
                    class="px-8 py-2.5 bg-blue-600 hover:bg-blue-500 text-white rounded-xl 
                           font-bold text-sm transition-all shadow-lg shadow-blue-600/20">
              Post Comment
            </button>
          </div>
        </form>
      </div>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>