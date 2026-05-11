<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%
    request.setAttribute("pageTitle", "Project Details | IGA Network");
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
        <main class="flex-1 p-8 overflow-y-auto">
            <!-- Breadcrumbs -->
            <div class="mb-6">
                <a href="<%= request.getContextPath() %>/pages/projects.jsp" class="text-xs font-bold text-blue-400 hover:text-blue-300 transition-colors mb-2 inline-flex items-center">
                    <i data-lucide="arrow-left" class="w-3 h-3 mr-1"></i> Back to Projects
                </a>
            </div>

            <!-- Dynamic Project Content -->
            <div id="project-details-content">
                <div class="flex flex-col items-center justify-center py-20 text-white/10">
                    <i data-lucide="loader-2" class="w-12 h-12 mb-4 animate-spin opacity-20"></i>
                    <p class="text-xs font-bold uppercase tracking-widest">Initialising Environment...</p>
                </div>
            </div>
        </main>
    </div>

    <script>
        lucide.createIcons();
        document.addEventListener('DOMContentLoaded', () => {
            if (typeof window.loadProjectDetails === 'function') {
                window.loadProjectDetails();
            }
        });

        // Modal placeholders for task/invite actions
        let currentProjectId = null;
        const CTX_PD = window.IGA_CONFIG?.contextPath || '/MiniLinkedIn';

        function showAddTaskModal(projectId) {
            currentProjectId = projectId;
            document.getElementById('add-task-modal').classList.remove('hidden');
            document.getElementById('task-title-input').focus();
        }
        
        function showInviteModal(projectId) {
            currentProjectId = projectId;
            document.getElementById('invite-modal').classList.remove('hidden');
            document.getElementById('invite-user-id-input').focus();
        }
        
        async function submitAddTask() {
            const title = document.getElementById('task-title-input').value.trim();
            const assignedTo = document.getElementById('task-assigned-input').value;
            if (!title) return;
            const res = await fetch(CTX_PD + '/api/projects/tasks/add', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ 
                    projectId: currentProjectId, title, 
                    ...(assignedTo ? { assigned_to: assignedTo } : {}) 
                })
            });
            if (res.ok) {
                document.getElementById('add-task-modal').classList.add('hidden');
                document.getElementById('task-title-input').value = '';
                if (typeof window.loadProjectDetails === 'function') {
                    window.loadProjectDetails();
                }
            }
        }
        
        async function submitInvite() {
            const userId = document.getElementById('invite-user-id-input').value.trim();
            if (!userId) return;
            const res = await fetch(CTX_PD + '/api/projects/invite', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ projectId: currentProjectId, userId })
            });
            if (res.ok) {
                document.getElementById('invite-modal').classList.add('hidden');
                showToast('Invitation sent!', 'success');
            }
        }
    </script>

    <!-- Add Task Modal -->
    <div id="add-task-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm">
      <div class="bg-[#161b22] rounded-3xl border border-white/5 shadow-2xl p-8 w-full max-w-md mx-4">
        <div class="flex justify-between items-center mb-6">
          <h3 class="text-lg font-bold text-white">Add Task</h3>
          <button onclick="document.getElementById('add-task-modal').classList.add('hidden')"
                  class="text-white/30 hover:text-white transition-colors">
            <i data-lucide="x" class="w-5 h-5"></i>
          </button>
        </div>
        <div class="space-y-4">
          <input type="text" id="task-title-input" placeholder="Task title" required
            class="w-full bg-[#0d1117] border border-white/5 rounded-xl px-4 py-3 text-sm 
                   text-white placeholder-white/20 focus:outline-none focus:ring-1 
                   focus:ring-blue-500/30 transition-all">
          <input type="number" id="task-assigned-input" placeholder="Assign to User ID (optional)"
            class="w-full bg-[#0d1117] border border-white/5 rounded-xl px-4 py-3 text-sm 
                   text-white placeholder-white/20 focus:outline-none focus:ring-1 
                   focus:ring-blue-500/30 transition-all">
          <div class="flex justify-end space-x-3 pt-2">
            <button onclick="document.getElementById('add-task-modal').classList.add('hidden')"
                    class="px-6 py-2.5 text-white/40 hover:text-white font-bold text-sm transition-all">
              Cancel
            </button>
            <button onclick="submitAddTask()"
                    class="px-8 py-2.5 bg-blue-600 hover:bg-blue-500 text-white rounded-xl 
                           font-bold text-sm transition-all shadow-lg shadow-blue-600/20">
              Add Task
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Invite User Modal -->
    <div id="invite-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm">
      <div class="bg-[#161b22] rounded-3xl border border-white/5 shadow-2xl p-8 w-full max-w-md mx-4">
        <div class="flex justify-between items-center mb-6">
          <h3 class="text-lg font-bold text-white">Invite Collaborator</h3>
          <button onclick="document.getElementById('invite-modal').classList.add('hidden')"
                  class="text-white/30 hover:text-white transition-colors">
            <i data-lucide="x" class="w-5 h-5"></i>
          </button>
        </div>
        <div class="space-y-4">
          <input type="number" id="invite-user-id-input" placeholder="Enter User ID to invite"
            class="w-full bg-[#0d1117] border border-white/5 rounded-xl px-4 py-3 text-sm 
                   text-white placeholder-white/20 focus:outline-none focus:ring-1 
                   focus:ring-blue-500/30 transition-all">
          <div class="flex justify-end space-x-3 pt-2">
            <button onclick="document.getElementById('invite-modal').classList.add('hidden')"
                    class="px-6 py-2.5 text-white/40 hover:text-white font-bold text-sm transition-all">
              Cancel
            </button>
            <button onclick="submitInvite()"
                    class="px-8 py-2.5 bg-blue-600 hover:bg-blue-500 text-white rounded-xl 
                           font-bold text-sm transition-all shadow-lg shadow-blue-600/20">
              Send Invite
            </button>
          </div>
        </div>
      </div>
    </div>
</body>
</html>
