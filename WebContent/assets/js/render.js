/**
 * Render Functions - Display data on pages
 */

/**
 * Render posts feed
 */
function renderPosts(posts, containerId = 'posts-container') {
  const container = document.getElementById(containerId);
  if (!container) return;
  
  if (!posts || posts.length === 0) {
    container.innerHTML = `
      <div class="py-20 text-center text-white/20">
        <i data-lucide="layout" class="w-12 h-12 mx-auto mb-4 opacity-20"></i>
        <p class="text-xs font-bold uppercase tracking-widest">No posts yet</p>
      </div>
    `;
    lucide.createIcons();
    return;
  }
  
  container.innerHTML = posts.map(post => {
    const avatarSeed = (post.author_email || 'default').replace("@", "-");
    const avatarUrl = `https://api.dicebear.com/7.x/avataaars/svg?seed=${avatarSeed}`;
    
    return `
      <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl mb-6 transition-all hover:border-white/10">
        <div class="flex justify-between items-start mb-6">
          <div class="flex items-center space-x-4">
            <img src="${avatarUrl}" class="w-12 h-12 rounded-full border-2 border-white/5" alt="${post.author_name}">
            <div>
              <h4 class="font-bold text-white text-sm">${post.author_name || 'Anonymous'}</h4>
              <p class="text-[10px] text-white/30 font-bold uppercase tracking-tighter">${formatDate(post.created_at)}</p>
            </div>
          </div>
          <span class="px-3 py-1 bg-blue-500/10 text-blue-400 text-[10px] font-bold rounded-full uppercase tracking-widest border border-blue-500/20">${post.type || 'GENERAL'}</span>
        </div>
        
        <p class="text-white/70 text-sm leading-relaxed mb-6">${post.content}</p>
        
        ${post.file_url ? `
          <div class="rounded-2xl overflow-hidden border border-white/5 mb-6">
            <img src="${post.file_url}" class="w-full object-cover max-h-[400px]" alt="Post image">
          </div>
        ` : ''}
        
        <div class="flex items-center space-x-6 pt-6 border-t border-white/5">
          <button onclick="likePost(${post.id})" class="flex items-center space-x-2 text-white/40 hover:text-red-500 transition-colors group">
            <i data-lucide="heart" class="w-4 h-4 group-hover:fill-current"></i>
            <span class="text-[10px] font-bold">${post.likes_count || 0}</span>
          </button>
          <button onclick="showCommentForm(${post.id})" class="flex items-center space-x-2 text-white/40 hover:text-blue-500 transition-colors group">
            <i data-lucide="message-circle" class="w-4 h-4 group-hover:fill-current"></i>
            <span class="text-[10px] font-bold">${post.comments_count || 0}</span>
          </button>
          <button onclick="sharePost(${post.id})" class="flex items-center space-x-2 text-white/40 hover:text-green-500 transition-colors group">
            <i data-lucide="repeat" class="w-4 h-4"></i>
            <span class="text-[10px] font-bold">SHARE</span>
          </button>
          ${isPostOwner(post.author_id) ? `
            <button onclick="deletePost(${post.id})" class="ml-auto text-white/10 hover:text-red-500 transition-colors">
              <i data-lucide="trash-2" class="w-4 h-4"></i>
            </button>
          ` : ''}
        </div>
      </div>
    `;
  }).join('');
  
  lucide.createIcons();
}

/**
 * Render projects list
 */
function renderProjects(projects, containerId = 'projects-container') {
  const container = document.getElementById(containerId);
  if (!container) return;
  
  if (!projects || projects.length === 0) {
    container.innerHTML = `
      <div class="col-span-full py-20 text-center text-white/20">
        <i data-lucide="folder-kanban" class="w-12 h-12 mx-auto mb-4 opacity-20"></i>
        <p class="text-xs font-bold uppercase tracking-widest">No active projects found</p>
      </div>
    `;
    lucide.createIcons();
    return;
  }
  
  container.innerHTML = projects.map(project => `
    <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl flex flex-col transition-all hover:border-blue-500/20 group">
      <div class="flex justify-between items-start mb-6">
        <div class="p-3 bg-blue-600/10 rounded-2xl border border-blue-600/20 group-hover:bg-blue-600 group-hover:text-white transition-all text-blue-500">
          <i data-lucide="microscope" class="w-6 h-6"></i>
        </div>
        <span class="px-3 py-1 ${project.status === 'OPEN' ? 'bg-green-500/10 text-green-500 border-green-500/20' : 'bg-red-500/10 text-red-500 border-red-500/20'} text-[10px] font-bold rounded-full uppercase tracking-widest border">
          ${project.status}
        </span>
      </div>
      
      <h3 class="text-lg font-bold text-white mb-2">${project.title}</h3>
      <p class="text-white/40 text-xs mb-6 line-clamp-3 leading-relaxed">${project.description}</p>
      
      <div class="mt-auto pt-6 border-t border-white/5">
        <div class="flex items-center justify-between mb-6">
          <div class="flex -space-x-2">
            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=1" class="w-8 h-8 rounded-full border-2 border-[#161b22]">
            <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=2" class="w-8 h-8 rounded-full border-2 border-[#161b22]">
            <div class="w-8 h-8 rounded-full border-2 border-[#161b22] bg-[#0d1117] flex items-center justify-center text-[10px] font-bold text-white/40">
              +${project.member_count}
            </div>
          </div>
          <span class="text-[10px] font-bold text-white/30 uppercase tracking-widest">${project.type}</span>
        </div>
        
        <div class="grid grid-cols-2 gap-3">
          <button onclick="viewProjectDetails(${project.id})" class="py-2.5 bg-white/5 border border-white/10 rounded-xl text-[10px] font-bold uppercase tracking-widest hover:bg-white/10 transition-all">Details</button>
          <button onclick="joinProject(${project.id})" class="py-2.5 bg-blue-600 text-white rounded-xl text-[10px] font-bold uppercase tracking-widest shadow-lg shadow-blue-600/20 hover:scale-105 transition-all">Join</button>
        </div>
      </div>
    </div>
  `).join('');
  
  lucide.createIcons();
}

/**
 * Render notifications
 */
function renderNotifications(notifications, containerId = 'notifications-container') {
  const container = document.getElementById(containerId);
  if (!container) return;
  
  if (!notifications || notifications.length === 0) {
    container.innerHTML = `
      <div class="py-10 text-center text-white/20">
        <p class="text-[10px] font-bold uppercase tracking-widest">No notifications</p>
      </div>
    `;
    return;
  }
  
  container.innerHTML = notifications.map(notif => `
    <div onclick="markNotificationRead(${notif.id})" class="p-4 rounded-2xl ${notif.is_read ? 'bg-transparent' : 'bg-blue-600/5 border border-blue-600/10'} hover:bg-white/5 transition-all cursor-pointer group mb-2">
      <div class="flex items-start space-x-4">
        <div class="w-10 h-10 rounded-full bg-blue-600/10 flex items-center justify-center shrink-0 border border-blue-600/20">
          <i data-lucide="${getNotificationIcon(notif.type)}" class="w-5 h-5 text-blue-500"></i>
        </div>
        <div class="flex-1">
          <p class="text-sm ${notif.is_read ? 'text-white/60' : 'text-white font-bold'}">${notif.message}</p>
          <p class="text-[10px] text-white/30 font-bold uppercase tracking-widest mt-1">${formatDate(notif.created_at)}</p>
        </div>
        ${!notif.is_read ? '<div class="w-2 h-2 bg-blue-500 rounded-full mt-2"></div>' : ''}
      </div>
    </div>
  `).join('');
  
  lucide.createIcons();
}

function getNotificationIcon(type) {
  switch(type) {
    case 'POST_LIKED': return 'heart';
    case 'POST_COMMENTED': return 'message-circle';
    case 'CONNECTION_REQUEST': return 'user-plus';
    case 'PROJECT_INVITATION': return 'mail';
    default: return 'bell';
  }
}

/**
 * Render users list (for suggestions)
 */
function renderUsers(users, containerId = 'users-container') {
  const container = document.getElementById(containerId);
  if (!container) return;
  
  if (!users || users.length === 0) {
    container.innerHTML = `
      <div class="col-span-full py-10 text-center text-white/20">
        <p class="text-xs font-bold uppercase tracking-widest">No suggestions found</p>
      </div>
    `;
    return;
  }
  
  container.innerHTML = users.map(user => {
    const avatarSeed = (user.email || 'default').replace("@", "-");
    const avatarUrl = `https://api.dicebear.com/7.x/avataaars/svg?seed=${avatarSeed}`;
    
    return `
      <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 flex flex-col items-center text-center transition-all hover:border-blue-500/20">
        <div class="relative mb-4">
          <div class="absolute -inset-1 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-full blur opacity-20"></div>
          <img src="${avatarUrl}" class="relative w-20 h-20 rounded-full border-2 border-[#161b22] bg-[#0d1117]" alt="${user.first_name}">
        </div>
        <h4 class="font-bold text-white text-sm mb-1">${user.first_name} ${user.last_name}</h4>
        <p class="text-[10px] text-white/40 font-bold uppercase tracking-widest mb-6">${user.role || 'RESEARCHER'}</p>
        
        <button onclick="sendConnectionRequest(${user.id})" class="w-full py-2 bg-blue-600/10 text-blue-500 rounded-xl text-[10px] font-bold border border-blue-600/20 hover:bg-blue-600 hover:text-white transition-all uppercase tracking-widest">Connect</button>
      </div>
    `;
  }).join('');
}

/**
 * Render connections list
 */
function renderConnections(connections, containerId = 'connections-container') {
  const container = document.getElementById(containerId);
  if (!container) return;
  
  if (!connections || connections.length === 0) {
    container.innerHTML = `
      <div class="py-10 text-center text-white/20">
        <p class="text-xs font-bold uppercase tracking-widest">No connections yet</p>
      </div>
    `;
    return;
  }
  
  container.innerHTML = connections.map(conn => {
    const avatarSeed = (conn.email || 'default').replace("@", "-");
    const avatarUrl = `https://api.dicebear.com/7.x/avataaars/svg?seed=${avatarSeed}`;
    
    return `
      <div class="flex items-center space-x-4 p-3 rounded-2xl hover:bg-white/5 transition-all group">
        <img src="${avatarUrl}" class="w-10 h-10 rounded-full border border-white/5 bg-[#0d1117]" alt="${conn.first_name}">
        <div class="flex-1">
          <h5 class="text-xs font-bold text-white">${conn.first_name} ${conn.last_name}</h5>
          <p class="text-[10px] text-white/40 uppercase tracking-widest">${conn.role || 'Member'}</p>
        </div>
        <div class="flex items-center opacity-0 group-hover:opacity-100 transition-all">
          <button onclick="viewUserProfile(${conn.id})" class="p-2 text-white/20 hover:text-blue-500 transition-all" title="View Profile">
            <i data-lucide="external-link" class="w-4 h-4"></i>
          </button>
          <button onclick="removeConnection(${conn.id})" class="p-2 text-white/20 hover:text-red-500 transition-all" title="Remove">
            <i data-lucide="user-minus" class="w-4 h-4"></i>
          </button>
        </div>
      </div>
    `;
  }).join('');
  
  lucide.createIcons();
}


/**
 * Render admin users table
 */
function renderAdminUsers(users, containerId = 'admin-users-container') {
  const container = document.getElementById(containerId);
  if (!container) return;
  
  if (!users || users.length === 0) {
    container.innerHTML = `
      <div class="py-20 text-center text-white/20">
        <i data-lucide="users-2" class="w-12 h-12 mx-auto mb-4 opacity-10"></i>
        <p class="text-[10px] font-bold uppercase tracking-[0.2em]">No Users Records Found</p>
      </div>
    `;
    lucide.createIcons();
    return;
  }
  
  container.innerHTML = `
    <table class="w-full text-left">
      <thead>
        <tr class="text-[10px] font-bold text-white/20 uppercase tracking-[0.2em] border-b border-white/5">
          <th class="px-6 py-4">User Identity</th>
          <th class="px-6 py-4">Current Role</th>
          <th class="px-6 py-4">Status</th>
          <th class="px-6 py-4">Role Management</th>
          <th class="px-6 py-4 text-right">Actions</th>
        </tr>
      </thead>
      <tbody class="divide-y divide-white/5">
        ${users.map(user => {
          const avatarSeed = (user.email || 'default').replace("@", "-");
          const avatarUrl = `https://api.dicebear.com/7.x/avataaars/svg?seed=${avatarSeed}`;
          const roleClass = getRoleBadgeClass(user.role);
          
          return `
            <tr class="hover:bg-white/[0.02] transition-all group">
              <td class="px-6 py-4">
                <div class="flex items-center space-x-3">
                  <img src="${avatarUrl}" class="w-9 h-9 rounded-full border border-white/10 bg-[#0d1117]" alt="${user.first_name}">
                  <div>
                    <h4 class="text-sm font-bold text-white">${user.first_name} ${user.last_name}</h4>
                    <p class="text-[10px] text-white/30">${user.email}</p>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4">
                <span class="px-3 py-1 ${roleClass} text-[9px] font-bold rounded-lg uppercase tracking-widest">
                  ${user.role}
                </span>
              </td>
              <td class="px-6 py-4">
                <div class="flex items-center space-x-2">
                  <span class="w-1.5 h-1.5 ${user.status === 'ACTIVE' ? 'bg-green-500 shadow-[0_0_8px_rgba(34,197,94,0.5)]' : 'bg-orange-500 animate-pulse'} rounded-full"></span>
                  <span class="text-[10px] font-bold text-white/60 uppercase">${user.status || 'ACTIVE'}</span>
                </div>
              </td>
              <td class="px-6 py-4">
                <select onchange="changeUserRole(${user.id}, this.value)" 
                        class="bg-[#0d1117] border border-white/5 rounded-lg px-3 py-1.5 text-xs text-white/70 focus:outline-none focus:ring-1 focus:ring-blue-500/30 transition-all cursor-pointer">
                  <option value="STUDENT" ${user.role === 'STUDENT' ? 'selected' : ''}>STUDENT</option>
                  <option value="TEACHER" ${user.role === 'TEACHER' ? 'selected' : ''}>TEACHER</option>
                  <option value="RESEARCHER" ${user.role === 'RESEARCHER' ? 'selected' : ''}>RESEARCHER</option>
                  <option value="ADMIN" ${user.role === 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                </select>
              </td>
              <td class="px-6 py-4 text-right space-x-2">
                <button onclick="approveUser(${user.id})" 
                        class="px-3 py-1.5 bg-blue-600 text-white text-[9px] font-bold rounded-lg hover:bg-blue-500 transition-all shadow-lg shadow-blue-600/10 uppercase tracking-widest">
                  Approve
                </button>
                <button onclick="banUser(${user.id})" 
                        class="px-3 py-1.5 bg-red-500/10 text-red-500 text-[9px] font-bold rounded-lg border border-red-500/20 hover:bg-red-500 hover:text-white transition-all uppercase tracking-widest">
                  Ban
                </button>
              </td>
            </tr>
          `;
        }).join('')}
      </tbody>
    </table>
  `;
  
  lucide.createIcons();
}

/**
 * Helper for role badge styling
 */
function getRoleBadgeClass(role) {
  switch(role) {
    case 'STUDENT':    return 'bg-blue-500/10 text-blue-500 border border-blue-500/20';
    case 'TEACHER':    return 'bg-purple-500/10 text-purple-500 border border-purple-500/20';
    case 'RESEARCHER': return 'bg-green-500/10 text-green-500 border border-green-500/20';
    case 'ADMIN':      return 'bg-red-500/10 text-red-500 border border-red-500/20';
    default:           return 'bg-white/5 text-white/40 border border-white/10';
  }
}

/**
 * Render project details
 */
function renderProjectDetails(project) {
  const container = document.getElementById('project-details-content');
  if (!container) return;
  
  const tasks = project.tasks || [];
  const members = project.members || [];
  
  container.innerHTML = `
    <div class="grid grid-cols-1 xl:grid-cols-12 gap-8">
        <!-- Main Content Left (Tasks & Description) -->
        <div class="xl:col-span-8 bg-[#161b22] rounded-3xl border border-white/5 shadow-2xl overflow-hidden">
            <div class="p-8 border-b border-white/5 bg-gradient-to-r from-blue-900/10 to-transparent flex justify-between items-start">
                <div>
                    <span class="px-2 py-0.5 bg-blue-500/10 text-blue-400 text-[9px] font-bold rounded uppercase tracking-widest border border-blue-500/20 mb-3 inline-block">${project.type || 'Research'}</span>
                    <h2 class="text-3xl font-bold text-white mb-2">${project.title}</h2>
                    <p class="text-white/50 text-sm">Created on ${formatDate(project.created_at)}</p>
                </div>
                ${project.is_owner ? `
                  <button class="px-4 py-2 bg-white/5 text-white/70 hover:text-white hover:bg-white/10 border border-white/10 rounded-xl text-xs font-bold transition-all">Edit Project</button>
                ` : ''}
            </div>
            
            <div class="p-8">
                <div class="grid grid-cols-2 md:grid-cols-4 gap-8 mb-10 pb-10 border-b border-white/5">
                    <div>
                        <div class="text-[9px] font-bold text-white/30 uppercase tracking-widest mb-1">Status</div>
                        <div class="flex items-center space-x-2">
                            <span class="w-2 h-2 ${project.status === 'OPEN' ? 'bg-green-500 shadow-[0_0_8px_rgba(34,197,94,0.5)]' : 'bg-red-500'} rounded-full"></span>
                            <span class="text-xs font-bold uppercase tracking-widest ${project.status === 'OPEN' ? 'text-green-500' : 'text-red-500'}">${project.status}</span>
                        </div>
                    </div>
                    <div>
                        <div class="text-[9px] font-bold text-white/30 uppercase tracking-widest mb-1">Lead Investigator</div>
                        <div class="text-xs font-bold text-white">${project.owner_name}</div>
                    </div>
                    <div>
                        <div class="text-[9px] font-bold text-white/30 uppercase tracking-widest mb-1">Members</div>
                        <div class="text-xs font-bold text-white">${project.member_count}/${project.max_members}</div>
                    </div>
                    <div>
                        <div class="text-[9px] font-bold text-white/30 uppercase tracking-widest mb-1">Type</div>
                        <div class="text-xs font-bold text-white uppercase tracking-wider">${project.type}</div>
                    </div>
                </div>

                <!-- Description -->
                <div class="mb-12">
                    <h3 class="text-sm font-bold text-white/60 uppercase tracking-widest mb-4">Description</h3>
                    <p class="text-xs text-white/40 leading-relaxed">${project.description}</p>
                </div>

                <!-- Tasks Section -->
                <div class="space-y-6">
                    <div class="flex justify-between items-center">
                        <h3 class="text-sm font-bold text-white/60 uppercase tracking-widest">Project Tasks</h3>
                        <button onclick="showAddTaskModal(${project.id})" class="text-xs text-blue-400 hover:text-white transition-colors font-bold"><i data-lucide="plus" class="w-3 h-3 inline"></i> Add Task</button>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <!-- Pending Column -->
                        <div class="space-y-4">
                            <div class="flex justify-between items-center px-4 py-2 bg-[#0d1117] rounded-xl border border-white/5">
                                <span class="text-[9px] font-bold text-white/40 uppercase tracking-widest">Pending</span>
                                <span class="text-[10px] font-bold text-white/20">${tasks.filter(t => t.status === 'PENDING').length}</span>
                            </div>
                            ${tasks.filter(t => t.status === 'PENDING').map(task => `
                              <div class="p-4 bg-white/5 rounded-2xl border border-white/5 space-y-3 shadow-lg hover:bg-white/10 transition-colors">
                                  <p class="text-xs font-semibold text-white">${task.title}</p>
                                  <div class="flex justify-between items-center">
                                      <span class="text-[8px] text-white/20">${formatDate(task.created_at)}</span>
                                      <button onclick="updateTaskStatus(${project.id}, ${task.id}, 'COMPLETED')" class="text-[9px] font-bold text-blue-400 hover:text-white uppercase">Mark Done</button>
                                  </div>
                              </div>
                            `).join('')}
                        </div>
                        <!-- Completed Column -->
                        <div class="space-y-4 md:col-span-2">
                            <div class="flex justify-between items-center px-4 py-2 bg-[#0d1117] rounded-xl border border-white/5">
                                <span class="text-[9px] font-bold text-green-500 uppercase tracking-widest">Completed</span>
                                <span class="text-[10px] font-bold text-green-500/20">${tasks.filter(t => t.status === 'COMPLETED').length}</span>
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                              ${tasks.filter(t => t.status === 'COMPLETED').map(task => `
                                <div class="p-4 bg-green-500/5 rounded-2xl border border-green-500/10 space-y-3 opacity-60">
                                    <p class="text-xs font-semibold text-green-500 line-through">${task.title}</p>
                                    <div class="flex justify-between items-center">
                                        <span class="text-[8px] text-green-500/30">Completed</span>
                                        <i data-lucide="check-circle" class="w-3 h-3 text-green-500"></i>
                                    </div>
                                </div>
                              `).join('')}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Sidebar (Members, Actions) -->
        <div class="xl:col-span-4 space-y-8">
            <!-- Actions -->
            <div class="grid grid-cols-2 gap-4">
                <button onclick="leaveProject(${project.id})" class="py-3 bg-red-500/10 hover:bg-red-500/20 text-red-500 border border-red-500/20 rounded-2xl text-xs font-bold transition-all uppercase tracking-widest flex justify-center items-center">
                    <i data-lucide="log-out" class="w-4 h-4 mr-2"></i> Leave
                </button>
                <button onclick="showInviteModal(${project.id})" class="py-3 bg-blue-600 hover:bg-blue-500 text-white border border-blue-500/20 rounded-2xl text-xs font-bold transition-all uppercase tracking-widest flex justify-center items-center shadow-lg shadow-blue-600/20">
                    <i data-lucide="user-plus" class="w-4 h-4 mr-2"></i> Invite
                </button>
            </div>

            <!-- Active Members -->
            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <h3 class="text-sm font-bold text-white mb-6 uppercase tracking-widest text-white/60">Team Members (${members.length})</h3>
                <div class="space-y-4 mb-4">
                    ${members.map(member => {
                      const mAvatarSeed = (member.email || 'default').replace("@", "-");
                      const mAvatarUrl = `https://api.dicebear.com/7.x/avataaars/svg?seed=${mAvatarSeed}`;
                      return `
                        <div class="flex items-center justify-between p-2 rounded-xl hover:bg-white/5 transition-all">
                            <div class="flex items-center space-x-3">
                                <img src="${mAvatarUrl}" class="w-8 h-8 rounded-full border border-white/10 bg-[#0d1117]">
                                <div>
                                    <h4 class="text-xs font-bold text-white">${member.first_name} ${member.last_name}</h4>
                                    <p class="text-[8px] text-white/30 uppercase font-bold tracking-widest">${member.role || 'Contributor'}</p>
                                </div>
                            </div>
                            ${member.id === project.owner_id ? '<span class="px-2 py-0.5 bg-blue-500/10 text-blue-500 text-[8px] font-bold rounded uppercase border border-blue-500/20">Lead</span>' : ''}
                        </div>
                      `;
                    }).join('')}
                </div>
            </div>

            <!-- Attachments (Placeholder for dynamic logic later) -->
            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-sm font-bold text-white uppercase tracking-widest text-white/60">Files</h3>
                    <button class="text-xs text-blue-400 hover:text-white transition-colors font-bold"><i data-lucide="upload" class="w-3 h-3 inline"></i></button>
                </div>
                <p class="text-[10px] text-white/20 text-center py-4 uppercase font-bold">No files attached</p>
            </div>
        </div>
    </div>
  `;
  
  lucide.createIcons();
}

/**
 * Render the entire profile page
 */
function renderProfile(user) {
  const container = document.getElementById('profile-content-container');
  if (!container) return;
  
  const avatarSeed = (user.email || 'default').replace("@", "-");
  const avatarUrl = `https://api.dicebear.com/7.x/avataaars/svg?seed=${avatarSeed}`;
  
  const stats = user.stats || {};
  const skills = user.skills || [];
  const certs = user.certifications || [];
  const projects = user.projects || [];
  const posts = user.posts || [];

  container.innerHTML = `
    <!-- Profile Header -->
    <div class="relative bg-[#161b22] rounded-3xl overflow-hidden border border-white/5 shadow-2xl mb-8">
        <div class="h-48 bg-gradient-to-r from-blue-900/40 via-blue-800/20 to-[#161b22] relative">
            <div class="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')] opacity-20"></div>
        </div>

        <div class="px-10 pb-10">
            <div class="relative flex flex-col md:flex-row items-end md:items-center justify-between -mt-20">
                <div class="flex flex-col md:flex-row items-center md:items-end space-y-4 md:space-y-0 md:space-x-8">
                    <div class="relative">
                        <div class="absolute -inset-1 bg-gradient-to-r from-blue-500 to-indigo-500 rounded-full blur opacity-50"></div>
                        <img src="${avatarUrl}" class="relative w-40 h-40 rounded-full border-4 border-[#161b22] bg-[#0d1117] object-cover">
                        <div class="absolute bottom-2 right-2 w-5 h-5 bg-green-500 border-4 border-[#161b22] rounded-full"></div>
                    </div>
                    
                    <div class="pb-2 text-center md:text-left">
                        <div class="flex items-center justify-center md:justify-start space-x-3">
                            <h1 class="text-3xl font-bold text-white">${user.first_name} ${user.last_name}</h1>
                            <span class="px-2 py-0.5 bg-green-500/10 text-green-500 text-[10px] font-bold rounded uppercase tracking-tighter border border-green-500/20">${user.role}</span>
                        </div>
                        <div class="mt-2 flex flex-wrap justify-center md:justify-start items-center gap-4 text-sm text-white/60">
                            <span class="px-2 py-0.5 bg-blue-500/10 text-blue-400 text-[10px] font-bold rounded uppercase tracking-tighter border border-blue-400/20">${user.role}</span>
                            <span>${user.university || 'IGA Casablanca'}</span>
                        </div>
                        <div class="mt-6 flex space-x-3">
                            <a href="${window.IGA_CONFIG?.contextPath || '/MiniLinkedIn'}/pages/edit-profile.jsp" class="px-8 py-2 bg-blue-600 text-white rounded-lg font-bold text-xs hover:bg-blue-500 transition-all shadow-lg shadow-blue-600/20 inline-flex items-center">
                                <i data-lucide="edit-2" class="w-4 h-4 mr-2"></i> Edit Profile
                            </a>
                            <button onclick="shareProfile()" class="px-8 py-2 bg-white/5 border border-white/10 text-white rounded-lg font-bold text-xs hover:bg-white/10 transition-all">SHARE</button>
                        </div>
                    </div>
                </div>

                <!-- Header Stats -->
                <div class="hidden xl:flex space-x-10 px-8 py-6 bg-white/5 border border-white/5 rounded-2xl backdrop-blur-sm">
                    <div class="text-center">
                        <div class="text-xl font-bold text-white">${stats.posts_count || posts.length}</div>
                        <div class="text-[9px] font-bold text-white/40 uppercase tracking-widest mt-1">Posts</div>
                    </div>
                    <div class="text-center">
                        <div class="text-xl font-bold text-white">${stats.connections_count || stats.total_connections || 0}</div>
                        <div class="text-[9px] font-bold text-white/40 uppercase tracking-widest mt-1">Conns</div>
                    </div>
                    <div class="text-center">
                        <div class="text-xl font-bold text-white">${stats.followers_count || 0}</div>
                        <div class="text-[9px] font-bold text-white/40 uppercase tracking-widest mt-1">Followers</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Content Grid -->
    <div class="grid grid-cols-1 xl:grid-cols-12 gap-8">
        <div class="xl:col-span-8 space-y-8">
            <div class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl">
                <h3 class="text-xl font-bold text-white mb-4">About</h3>
                <p class="text-white/60 leading-relaxed">${user.bio || 'This researcher is busy working on groundbreaking discoveries and hasn\'t provided a biography yet.'}</p>
                <div class="mt-6 flex space-x-4">
                    <i data-lucide="globe" class="w-5 h-5 text-white/40 hover:text-white cursor-pointer transition-colors"></i>
                    <i data-lucide="linkedin" class="w-5 h-5 text-white/40 hover:text-white cursor-pointer transition-colors"></i>
                </div>
            </div>

            <div class="bg-[#161b22] rounded-3xl p-8 border border-white/5 shadow-xl">
                <h3 class="text-xl font-bold text-white mb-6">Expertise & Skills</h3>
                <div class="flex flex-wrap gap-3">
                    ${skills.length > 0 ? skills.map(skill => `
                      <span class="px-4 py-2 bg-blue-600/5 text-blue-400 text-xs font-bold rounded-xl border border-blue-600/10 hover:bg-blue-600 hover:text-white transition-all cursor-default">
                        ${skill.name} <span class="ml-2 text-[8px] opacity-40">${skill.level || 'Expert'}</span>
                      </span>
                    `).join('') : '<p class="text-white/20 text-xs italic">No skills listed yet.</p>'}
                </div>
            </div>

            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <h3 class="text-xl font-bold text-white mb-6">Recent Activity</h3>
                <div id="user-posts-container">
                    <!-- This can be populated separately or via renderPosts if containerId passed -->
                </div>
            </div>
        </div>

        <div class="xl:col-span-4 space-y-8">
            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <h3 class="text-lg font-bold text-white mb-6">Credentials</h3>
                <div class="space-y-4">
                    ${certs.length > 0 ? certs.map(cert => `
                      <div class="flex items-start space-x-4 p-3 rounded-2xl hover:bg-white/5 transition-all">
                        <div class="p-2 bg-yellow-500/10 rounded-lg"><i data-lucide="award" class="w-4 h-4 text-yellow-500"></i></div>
                        <div>
                          <h4 class="text-xs font-bold text-white">${cert.title}</h4>
                          <p class="text-[9px] text-white/30 uppercase font-bold tracking-widest mt-1">${cert.issuer}</p>
                        </div>
                      </div>
                    `).join('') : '<p class="text-white/20 text-xs text-center py-4">No certifications</p>'}
                </div>
            </div>

            <div class="bg-[#161b22] rounded-3xl p-6 border border-white/5 shadow-xl">
                <h3 class="text-lg font-bold text-white mb-6">Current Projects</h3>
                <div class="space-y-4">
                    ${projects.length > 0 ? projects.map(proj => `
                      <div class="p-4 bg-white/5 rounded-2xl border border-white/5 hover:border-blue-500/30 transition-all cursor-pointer" onclick="viewProjectDetails(${proj.id})">
                        <h4 class="text-xs font-bold text-white mb-1">${proj.title}</h4>
                        <div class="flex justify-between items-center">
                          <span class="text-[8px] text-blue-400 font-bold uppercase tracking-widest">${proj.status}</span>
                          <span class="text-[8px] text-white/20">${proj.type}</span>
                        </div>
                      </div>
                    `).join('') : '<p class="text-white/20 text-xs text-center py-4">No active projects</p>'}
                </div>
            </div>
        </div>
    </div>
  `;
  
  if (posts.length > 0) {
    renderPosts(posts, 'user-posts-container');
  } else {
    document.getElementById('user-posts-container').innerHTML = '<p class="text-white/20 text-xs text-center py-10 italic uppercase font-bold tracking-widest">No recent activity</p>';
  }
  
  lucide.createIcons();
}

/**
 * Check if current user is post owner
 * 'iga_user_id' is set by header.jsp from the Java HttpSession
 */
function isPostOwner(authorId) {
  const userId = parseInt(sessionStorage.getItem('iga_user_id') || 0);
  return userId > 0 && userId === authorId;
}
