/**
 * Event Handlers - Wire UI elements to API calls
 */
let activeChannelId = null;
let activeChannelName = '';
let allSuggestions = [];
let allProjects = [];

// Context path prefix for all API calls
const CTX = '/MiniLinkedIn';

/**
 * Initialize all event listeners on page load
 */
function initializeEventHandlers() {
  setupPostCreationForm();
  setupProjectCreationForm();
  setupProfileUpdateForm();
  setupSearchHandlers();
  setupConnectionRequestHandlers();
  setupSendMessageForm();
  setupProjectFilters();
  loadInitialPageData();
}

/**
 * Load initial data for current page
 */
function loadInitialPageData() {
  const currentPath = window.location.pathname;
  
  if (currentPath.includes('home.jsp')) {
    loadPosts();
    loadNotifications();
  } else if (currentPath.includes('profile.jsp') && !currentPath.includes('edit')) {
    loadFullProfile();
  } else if (currentPath.includes('edit-profile.jsp')) {
    loadProfileForEditing();
  } else if (currentPath.includes('projects.jsp')) {
    loadProjects();
  } else if (currentPath.includes('project-details.jsp')) {
    loadProjectDetails();
  } else if (currentPath.includes('messages.jsp')) {
    loadConversations();
  } else if (currentPath.includes('notifications.jsp')) {
    loadAllNotifications();
  } else if (currentPath.includes('network.jsp')) {
    loadNetworkPage();
  } else if (currentPath.includes('admin.jsp')) {
    loadAdminDashboard();
  }
}

/**
 * ============ POST ACTIONS ============
 */

function setupPostCreationForm() {
  const form = document.getElementById('create-post-form');
  if (!form) return;
  
  form.onsubmit = async (e) => {
    e.preventDefault();
    
    const content = document.getElementById('post-content')?.value?.trim();
    const type = document.getElementById('post-type')?.value || 'GENERAL';
    const fileInput = document.getElementById('post-file');
    
    if (!content) {
      showToast('Please enter post content', 'error');
      return;
    }
    
    showSpinner(form);
    
    try {
      if (!isAuthenticated()) {
        window.location.href = CTX + '/pages/login.jsp';
        return;
      }
      
      const formData = new FormData();
      formData.append('content', content);
      formData.append('type', type);
      if (fileInput && fileInput.files[0]) {
        formData.append('file', fileInput.files[0]);
      }
      
      const response = await fetch(CTX + '/api/posts/create', {
        method: 'POST',
        body: formData
      });
      
      if (response.ok) {
        showToast('Post created successfully!', 'success');
        form.reset();
        await loadPosts();
      } else if (response.status === 401) {
        window.location.href = CTX + '/pages/login.jsp';
      } else {
        const error = await response.json();
        showToast(error.error || 'Failed to create post', 'error');
      }
    } catch (err) {
      console.error('Error creating post:', err);
      showToast('Error creating post: ' + err.message, 'error');
    } finally {
      hideSpinner(form);
    }
  };
}

async function loadPosts() {
  try {
    if (!isAuthenticated()) {
      window.location.href = CTX + '/pages/login.jsp';
      return;
    }
    
    const response = await fetch(CTX + '/api/posts', { method: 'GET' });
    
    if (response.ok) {
      const data = await response.json();
      const posts = unwrapApiResponse(data, 'posts');
      renderPosts(posts, 'posts-container');
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to load posts', 'error');
    }
  } catch (err) {
    console.error('Error loading posts:', err);
    showToast('Error loading posts', 'error');
  }
}

async function likePost(postId) {
  if (!postId) { showToast('Invalid post', 'error'); return; }
  
  try {
    const response = await fetch(CTX + '/api/posts/like', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ postId: postId })
    });
    
    if (response.ok) {
      showToast('Post liked!', 'success');
      await loadPosts();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to like post', 'error');
    }
  } catch (err) {
    console.error('Error liking post:', err);
    showToast('Error liking post', 'error');
  }
}

function showCommentForm(postId) {
  const modal = document.getElementById('comment-modal');
  if (!modal) { showToast('Comment feature not available', 'info'); return; }
  modal.classList.remove('hidden');
  const form = document.getElementById('comment-form');
  if (form) {
    form.dataset.postId = postId;
    document.getElementById('comment-content').focus();
  }
}

async function submitComment() {
  const form = document.getElementById('comment-form');
  if (!form) return;
  
  const postId = form.dataset.postId;
  const content = document.getElementById('comment-content')?.value?.trim();
  
  if (!content) { showToast('Please enter a comment', 'error'); return; }
  if (!postId)  { showToast('Invalid post ID', 'error'); return; }
  
  try {
    const response = await fetch(CTX + '/api/posts/comment', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ postId: postId, content: content })
    });
    
    if (response.ok) {
      showToast('Comment added!', 'success');
      form.reset();
      const modal = document.getElementById('comment-modal');
      if (modal) modal.classList.add('hidden');
      await loadPosts();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to add comment', 'error');
    }
  } catch (err) {
    console.error('Error adding comment:', err);
    showToast('Error adding comment', 'error');
  }
}

async function sharePost(postId) {
  if (!postId) { showToast('Invalid post', 'error'); return; }
  
  try {
    const response = await fetch(CTX + '/api/posts/share', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ postId: postId })
    });
    
    if (response.ok) {
      showToast('Post shared!', 'success');
      await loadPosts();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to share post', 'error');
    }
  } catch (err) {
    console.error('Error sharing post:', err);
    showToast('Error sharing post', 'error');
  }
}

async function deletePost(postId) {
  if (!postId) { showToast('Invalid post', 'error'); return; }
  if (!confirm('Are you sure you want to delete this post?')) return;
  
  try {
    const response = await fetch(CTX + '/api/posts/delete', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ postId: postId })
    });
    
    if (response.ok) {
      showToast('Post deleted!', 'success');
      await loadPosts();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to delete post', 'error');
    }
  } catch (err) {
    console.error('Error deleting post:', err);
    showToast('Error deleting post', 'error');
  }
}

/**
 * ============ PROJECT ACTIONS ============
 */

async function loadProjects() {
  try {
    if (!isAuthenticated()) {
      window.location.href = CTX + '/pages/login.jsp';
      return;
    }
    
    const response = await fetch(CTX + '/api/projects', { method: 'GET' });
    
    if (response.ok) {
      const data = await response.json();
      const projects = unwrapApiResponse(data, 'projects');
      allProjects = projects;
      renderProjects(allProjects, 'projects-container');
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to load projects', 'error');
    }
  } catch (err) {
    console.error('Error loading projects:', err);
    showToast('Error loading projects', 'error');
  }
}

function filterProjects(type) {
  document.querySelectorAll('[onclick^="filterProjects"]').forEach(btn => {
    btn.classList.remove('bg-blue-600', 'text-white');
    btn.classList.add('text-white/40');
  });
  if (event && event.currentTarget) {
    event.currentTarget.classList.add('bg-blue-600', 'text-white');
    event.currentTarget.classList.remove('text-white/40');
  }
  const filtered = type === 'ALL' ? allProjects : allProjects.filter(p => p.type === type);
  renderProjects(filtered, 'projects-container');
}

function setupProjectFilters() {
  const searchInput = document.getElementById('project-search');
  const statusFilter = document.getElementById('project-status-filter');
  
  if (searchInput) {
    searchInput.oninput = () => {
      const query = searchInput.value.toLowerCase();
      const filtered = allProjects.filter(p =>
        p.title.toLowerCase().includes(query) ||
        p.description.toLowerCase().includes(query)
      );
      renderProjects(filtered, 'projects-container');
    };
  }
  
  if (statusFilter) {
    statusFilter.onchange = () => {
      const status = statusFilter.value;
      const filtered = status === 'ALL' ? allProjects : allProjects.filter(p => p.status === status);
      renderProjects(filtered, 'projects-container');
    };
  }

  const netSearch = document.getElementById('network-search');
  if (netSearch) {
    netSearch.oninput = () => {
      const query = netSearch.value.toLowerCase();
      const filtered = allSuggestions.filter(u =>
        (u.first_name + ' ' + u.last_name).toLowerCase().includes(query) ||
        (u.role || '').toLowerCase().includes(query)
      );
      renderUsers(filtered, 'suggestions-container');
    };
  }
}

function setupProjectCreationForm() {
  const form = document.getElementById('create-project-form');
  if (!form) return;
  
  form.onsubmit = async (e) => {
    e.preventDefault();
    
    const title       = document.getElementById('project-title')?.value?.trim();
    const description = document.getElementById('project-description')?.value?.trim();
    const type        = document.getElementById('project-type')?.value || 'ACADEMIC';
    const maxMembers  = document.getElementById('project-max-members')?.value || 10;
    
    if (!title || !description) {
      showToast('Please fill in all required fields', 'error');
      return;
    }
    
    showSpinner(form);
    
    try {
      if (!isAuthenticated()) {
        window.location.href = CTX + '/pages/login.jsp';
        return;
      }
      
      const response = await fetch(CTX + '/api/projects/create', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ title, description, type, max_members: maxMembers })
      });
      
      if (response.ok) {
        showToast('Project created successfully!', 'success');
        form.reset();
        await loadProjects();
      } else if (response.status === 401) {
        window.location.href = CTX + '/pages/login.jsp';
      } else {
        const error = await response.json();
        showToast(error.error || 'Failed to create project', 'error');
      }
    } catch (err) {
      console.error('Error creating project:', err);
      showToast('Error creating project: ' + err.message, 'error');
    } finally {
      hideSpinner(form);
    }
  };
}

async function joinProject(projectId) {
  if (!projectId) { showToast('Invalid project', 'error'); return; }
  
  try {
    const response = await fetch(CTX + '/api/projects/join', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ projectId })
    });
    
    if (response.ok) {
      showToast('Joined project!', 'success');
      await loadProjects();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to join project', 'error');
    }
  } catch (err) {
    console.error('Error joining project:', err);
    showToast('Error joining project', 'error');
  }
}

async function leaveProject(projectId) {
  if (!projectId) { showToast('Invalid project', 'error'); return; }
  if (!confirm('Are you sure you want to leave this project?')) return;
  
  try {
    const response = await fetch(CTX + '/api/projects/leave', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ projectId })
    });
    
    if (response.ok) {
      showToast('Left project', 'success');
      await loadProjects();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to leave project', 'error');
    }
  } catch (err) {
    console.error('Error leaving project:', err);
    showToast('Error leaving project', 'error');
  }
}

function viewProjectDetails(projectId) {
  window.location.href = CTX + '/pages/project-details.jsp?id=' + projectId;
}

async function updateTaskStatus(projectId, taskId, status) {
  try {
    const response = await fetch(CTX + '/api/projects/tasks/update', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ projectId, taskId, status })
    });
    
    if (response.ok) {
      if (typeof window.loadProjectDetails === 'function') window.loadProjectDetails();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    }
  } catch (err) {
    console.error('Error updating task status:', err);
  }
}

async function loadProjectDetails() {
  const params = new URLSearchParams(window.location.search);
  const projectId = params.get('id');
  if (!projectId) { showToast('Invalid project', 'error'); return; }
  
  try {
    const response = await fetch(CTX + '/api/projects/details?projectId=' + projectId, { method: 'GET' });
    
    if (response.ok) {
      const data = await response.json();
      const project = unwrapApiResponse(data, 'project');
      renderProjectDetails(project);
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to load project details', 'error');
    }
  } catch (err) {
    console.error('Error loading project details:', err);
    showToast('Error loading project details', 'error');
  }
}

/**
 * ============ PROFILE ACTIONS ============
 */

function setupProfileUpdateForm() {
  const form = document.getElementById('update-profile-form');
  if (!form) return;
  
  form.onsubmit = async (e) => {
    e.preventDefault();
    
    const firstName = document.getElementById('first-name')?.value?.trim();
    const lastName  = document.getElementById('last-name')?.value?.trim();
    const email     = document.getElementById('email')?.value?.trim();
    const bio       = document.getElementById('bio')?.value?.trim();
    
    if (!firstName || !lastName || !email) {
      showToast('Please fill in all required fields', 'error');
      return;
    }
    if (!isValidEmail(email)) {
      showToast('Please enter a valid email', 'error');
      return;
    }
    
    showSpinner(form);
    
    try {
      if (!isAuthenticated()) {
        window.location.href = CTX + '/pages/login.jsp';
        return;
      }
      
      const response = await fetch(CTX + '/api/profile/update', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ first_name: firstName, last_name: lastName, bio })
      });
      
      if (response.ok) {
        showToast('Profile updated successfully!', 'success');
        setTimeout(() => { window.location.href = CTX + '/pages/profile.jsp'; }, 1500);
      } else if (response.status === 401) {
        window.location.href = CTX + '/pages/login.jsp';
      } else {
        const error = await response.json();
        showToast(error.error || 'Failed to update profile', 'error');
      }
    } catch (err) {
      console.error('Error updating profile:', err);
      showToast('Error updating profile: ' + err.message, 'error');
    } finally {
      hideSpinner(form);
    }
  };
}

async function loadProfileForEditing() {
  try {
    if (!isAuthenticated()) {
      window.location.href = CTX + '/pages/login.jsp';
      return;
    }
    
    const response = await fetch(CTX + '/api/profile', { method: 'GET' });
    
    if (response.ok) {
      const data = await response.json();
      const user = unwrapApiResponse(data, 'user');
      
      if (document.getElementById('first-name')) document.getElementById('first-name').value = user.first_name || '';
      if (document.getElementById('last-name'))  document.getElementById('last-name').value  = user.last_name  || '';
      if (document.getElementById('email'))      document.getElementById('email').value      = user.email      || '';
      
      const bioField = document.getElementById('bio') || document.getElementById('bio-input');
      if (bioField) bioField.value = user.bio || user.profile?.biography || '';
      
      loadSkillsForEditing();
      loadExperiencesForEditing();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to load profile', 'error');
    }
  } catch (err) {
    console.error('Error loading profile:', err);
    showToast('Error loading profile', 'error');
  }
}
window.loadEditProfileData = loadProfileForEditing;

async function loadSkillsForEditing() {
  try {
    const response = await fetch(CTX + '/api/profile', { method: 'GET' });
    if (response.ok) {
      const data = await response.json();
      const profile = data.profile || (data.data ? data.data.profile : null);
      const skills  = profile ? profile.skills || [] : [];
      
      const container = document.getElementById('skills-list');
      if (!container) return;
      
      if (skills.length === 0) {
        container.innerHTML = '<p class="text-white/20 text-[10px] uppercase font-bold tracking-widest py-4">No skills added yet</p>';
        return;
      }
      
      container.innerHTML = skills.map(function(skill) {
        return '<span class="px-4 py-2 bg-blue-600/10 text-blue-400 border border-blue-600/20 rounded-full text-xs font-bold flex items-center gap-2">' +
          skill.name + ' <span class="opacity-40 text-[9px]">' + (skill.level || 'Expert') + '</span>' +
          '<button onclick="removeSkill(' + skill.id + ')" class="ml-1 hover:text-red-400 transition-colors">' +
            '<i data-lucide="x" class="w-3 h-3"></i>' +
          '</button>' +
        '</span>';
      }).join('');
      
      lucide.createIcons();
    }
  } catch (err) {
    console.error('Error loading skills:', err);
  }
}

async function loadExperiencesForEditing() {
  try {
    const response = await fetch(CTX + '/api/profile', { method: 'GET' });
    if (response.ok) {
      const data = await response.json();
      const profile     = data.profile || (data.data ? data.data.profile : null);
      const experiences = profile ? profile.experiences || [] : [];
      
      const container = document.getElementById('experiences-list');
      if (!container) return;
      
      if (experiences.length === 0) {
        container.innerHTML = '<p class="text-white/20 text-[10px] uppercase font-bold tracking-widest py-4">No experience records found</p>';
        return;
      }
      
      container.innerHTML = experiences.map(function(exp) {
        return '<div class="bg-[#0d1117] border border-white/5 rounded-2xl p-4 mb-3 flex justify-between items-start group">' +
          '<div>' +
            '<h4 class="font-bold text-white text-sm">' + exp.title + '</h4>' +
            '<p class="text-white/40 text-xs">' + (exp.organization || exp.company) + '</p>' +
            '<p class="text-white/20 text-[10px] mt-1">' + exp.start_date + ' - ' + (exp.end_date || 'Present') + '</p>' +
            '<span class="inline-block mt-2 px-2 py-0.5 bg-blue-500/10 text-blue-400 text-[8px] font-bold rounded uppercase border border-blue-500/20">' + (exp.type || 'Full-time') + '</span>' +
          '</div>' +
          '<button onclick="deleteExperience(' + exp.id + ')" class="text-white/10 hover:text-red-500 transition-all p-2 bg-white/5 rounded-lg">' +
            '<i data-lucide="trash-2" class="w-4 h-4"></i>' +
          '</button>' +
        '</div>';
      }).join('');
      
      lucide.createIcons();
    }
  } catch (err) {
    console.error('Error loading experiences:', err);
  }
}

async function removeSkill(skillId) {
  if (!confirm('Are you sure you want to remove this skill?')) return;
  
  try {
    const response = await fetch(CTX + '/api/profile/skills/remove', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ skillId })
    });
    
    if (response.ok) {
      showToast('Skill removed', 'success');
      await loadSkillsForEditing();
    } else {
      showToast('Failed to remove skill', 'error');
    }
  } catch (err) {
    console.error('Error removing skill:', err);
  }
}

async function deleteExperience(expId) {
  if (!confirm('Are you sure you want to delete this experience record?')) return;
  
  try {
    const response = await fetch(CTX + '/api/profile/experiences/delete', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ expId })
    });
    
    if (response.ok) {
      showToast('Experience deleted', 'success');
      await loadExperiencesForEditing();
    } else {
      showToast('Failed to delete experience', 'error');
    }
  } catch (err) {
    console.error('Error deleting experience:', err);
  }
}

function viewUserProfile(userId) {
  window.location.href = CTX + '/pages/profile.jsp?id=' + userId;
}

/**
 * ============ NOTIFICATION ACTIONS ============
 */

async function loadAllNotifications() {
  try {
    if (!isAuthenticated()) {
      window.location.href = CTX + '/pages/login.jsp';
      return;
    }
    
    const response = await fetch(CTX + '/api/notifications', { method: 'GET' });
    
    if (response.ok) {
      const data          = await response.json();
      const notifications = unwrapApiResponse(data, 'notifications');
      const unreadCount   = notifications.filter(n => !n.is_read).length;
      const dot           = document.getElementById('nav-notif-dot');
      if (dot) { unreadCount > 0 ? dot.classList.remove('hidden') : dot.classList.add('hidden'); }
      const containerId = document.getElementById('notifications-list') ? 'notifications-list' : 'notifications-dropdown';
      renderNotifications(notifications, containerId);
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to load notifications', 'error');
    }
  } catch (err) {
    console.error('Error loading notifications:', err);
    showToast('Error loading notifications', 'error');
  }
}

async function loadNotifications() {
  try {
    if (!isAuthenticated()) return;
    
    const response = await fetch(CTX + '/api/notifications', { method: 'GET' });
    
    if (response.ok) {
      const data          = await response.json();
      const notifications = unwrapApiResponse(data, 'notifications');
      const unreadCount   = notifications.filter(n => !n.is_read).length;
      const dot           = document.getElementById('nav-notif-dot');
      if (dot) { unreadCount > 0 ? dot.classList.remove('hidden') : dot.classList.add('hidden'); }
      const container = document.getElementById('notifications-dropdown');
      if (container) renderNotifications(notifications, 'notifications-dropdown');
    }
  } catch (err) {
    console.error('Error loading notifications:', err);
  }
}

async function markNotificationRead(notificationId) {
  try {
    const response = await fetch(CTX + '/api/notifications/read', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ notificationId })
    });
    
    if (response.ok) {
      if (document.getElementById('notifications-list')) await loadAllNotifications();
      await loadNotifications();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    }
  } catch (err) {
    console.error('Error marking notification as read:', err);
  }
}

/**
 * ============ NETWORK/CONNECTION ACTIONS ============
 */

async function loadNetworkPage() {
  try {
    if (!isAuthenticated()) {
      window.location.href = CTX + '/pages/login.jsp';
      return;
    }
    
    const response = await fetch(CTX + '/api/network/suggestions', { method: 'GET' });
    
    if (response.ok) {
      const data  = await response.json();
      const users = unwrapApiResponse(data, 'suggestions');
      allSuggestions = users;
      renderUsers(allSuggestions, 'suggestions-container');
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    }
    
    const connResponse = await fetch(CTX + '/api/network/connections', { method: 'GET' });
    
    if (connResponse.ok) {
      const connData    = await connResponse.json();
      const connections = unwrapApiResponse(connData, 'connections');
      renderConnections(connections, 'connections-list');
      const countEl = document.getElementById('connections-count');
      if (countEl) countEl.textContent = connections.length + ' Total';
    }
  } catch (err) {
    console.error('Error loading network page:', err);
    showToast('Error loading network page', 'error');
  }
}

function filterNetwork(role) {
  document.querySelectorAll('[onclick^="filterNetwork"]').forEach(btn => {
    btn.classList.remove('bg-blue-600', 'text-white');
    btn.classList.add('text-white/40');
  });
  if (event && event.currentTarget) {
    event.currentTarget.classList.add('bg-blue-600', 'text-white');
    event.currentTarget.classList.remove('text-white/40');
  }
  const filtered = role === 'ALL' ? allSuggestions : allSuggestions.filter(u => u.role === role);
  renderUsers(filtered, 'suggestions-container');
}

function setupConnectionRequestHandlers() {}

async function sendConnectionRequest(userId) {
  if (!userId) { showToast('Invalid user', 'error'); return; }
  
  try {
    const response = await fetch(CTX + '/api/network/request', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ userId })
    });
    
    if (response.ok) {
      showToast('Connection request sent!', 'success');
      await loadNetworkPage();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      const error = await response.json();
      showToast(error.error || 'Failed to send connection request', 'error');
    }
  } catch (err) {
    console.error('Error sending connection request:', err);
    showToast('Error sending connection request', 'error');
  }
}

async function acceptConnectionRequest(userId) {
  if (!userId) { showToast('Invalid user', 'error'); return; }
  
  try {
    const response = await fetch(CTX + '/api/network/accept', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ userId })
    });
    
    if (response.ok) {
      showToast('Connection accepted!', 'success');
      await loadNetworkPage();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to accept connection request', 'error');
    }
  } catch (err) {
    console.error('Error accepting connection request:', err);
    showToast('Error accepting connection request', 'error');
  }
}

async function removeConnection(userId) {
  if (!userId) { showToast('Invalid user', 'error'); return; }
  if (!confirm('Are you sure you want to remove this connection?')) return;
  
  try {
    const response = await fetch(CTX + '/api/network/remove', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ userId })
    });
    
    if (response.ok) {
      showToast('Connection removed', 'success');
      await loadNetworkPage();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to remove connection', 'error');
    }
  } catch (err) {
    console.error('Error removing connection:', err);
    showToast('Error removing connection', 'error');
  }
}

/**
 * ============ MESSAGE/CHAT ACTIONS ============
 */

async function loadConversations() {
  try {
    if (!isAuthenticated()) {
      window.location.href = CTX + '/pages/login.jsp';
      return;
    }
    
    const response = await fetch(CTX + '/api/chat/channels', { method: 'GET' });
    
    if (response.ok) {
      const data     = await response.json();
      const channels = unwrapApiResponse(data, 'channels');
      renderConversations(channels, 'conversations-container');
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    }
  } catch (err) {
    console.error('Error loading conversations:', err);
  }
}

function renderConversations(channels, containerId) {
  const container = document.getElementById(containerId);
  if (!container) return;
  
  if (!channels || channels.length === 0) {
    container.innerHTML = '<div class="flex flex-col items-center justify-center py-20 text-white/10"><p class="text-[10px] font-bold uppercase tracking-widest">No active chats</p></div>';
    return;
  }
  
  container.innerHTML = channels.map(function(channel) {
    return '<div onclick="loadChatHistory(' + channel.id + ', \'' + channel.name + '\')" class="flex items-center space-x-4 p-4 rounded-2xl hover:bg-white/5 transition-all cursor-pointer group">' +
      '<div class="w-12 h-12 rounded-full bg-blue-600/10 flex items-center justify-center border border-blue-600/20 group-hover:scale-105 transition-all">' +
        '<i data-lucide="' + (channel.is_private ? 'user' : 'users') + '" class="w-6 h-6 text-blue-500"></i>' +
      '</div>' +
      '<div class="flex-1 min-w-0">' +
        '<h4 class="text-sm font-bold text-white truncate">' + channel.name + '</h4>' +
        '<p class="text-[10px] text-white/30 truncate">' + (channel.description || 'Click to open chat') + '</p>' +
      '</div>' +
    '</div>';
  }).join('');
  
  lucide.createIcons();
}

async function loadChatHistory(channelId, channelName) {
  activeChannelId   = channelId;
  activeChannelName = channelName;
  
  const messagesContainer = document.getElementById('chat-messages');
  const chatHeader        = document.getElementById('chat-header');
  
  if (chatHeader) {
    chatHeader.innerHTML =
      '<div class="flex items-center space-x-4">' +
        '<div class="w-10 h-10 rounded-full bg-blue-600/10 flex items-center justify-center border border-blue-600/20">' +
          '<i data-lucide="users" class="w-5 h-5 text-blue-500"></i>' +
        '</div>' +
        '<div>' +
          '<h3 class="text-sm font-bold text-white">' + channelName + '</h3>' +
          '<p class="text-[10px] text-white/30 font-bold uppercase tracking-widest mt-0.5">Active Channel</p>' +
        '</div>' +
      '</div>';
    lucide.createIcons();
  }
  
  if (messagesContainer) {
    messagesContainer.innerHTML = '<p class="text-center text-white/20 py-10">Loading messages...</p>';
  }
  
  try {
    const response = await fetch(CTX + '/api/chat/channels/messages?channelId=' + channelId, { method: 'GET' });
    
    if (response.ok) {
      const data     = await response.json();
      const messages = unwrapApiResponse(data, 'messages');
      renderChatMessages(messages, 'chat-messages');
    }
  } catch (err) {
    console.error('Error loading chat history:', err);
  }
}

function renderChatMessages(messages, containerId) {
  const container = document.getElementById(containerId);
  if (!container) return;
  
  if (!messages || messages.length === 0) {
    container.innerHTML = '<div class="flex flex-col items-center justify-center h-full text-white/10 italic"><p>No messages yet. Start the conversation!</p></div>';
    return;
  }
  
  const currentUserId = getCurrentUserId();
  
  container.innerHTML = messages.map(function(msg) {
    const isMe = msg.user_id === currentUserId;
    return '<div class="flex ' + (isMe ? 'justify-end' : 'justify-start') + ' mb-6">' +
      '<div class="max-w-[70%]">' +
        '<div class="flex items-center space-x-2 mb-2 ' + (isMe ? 'flex-row-reverse space-x-reverse' : '') + '">' +
          '<span class="text-[10px] font-bold text-white/40 uppercase tracking-widest">' + (msg.user_name || 'User') + '</span>' +
          '<span class="text-[8px] text-white/20">' + formatDate(msg.created_at) + '</span>' +
        '</div>' +
        '<div class="p-4 rounded-2xl ' + (isMe ? 'bg-blue-600 text-white rounded-tr-none' : 'bg-[#161b22] text-white/80 border border-white/5 rounded-tl-none shadow-xl') + ' text-sm leading-relaxed">' +
          msg.content +
        '</div>' +
      '</div>' +
    '</div>';
  }).join('');
  
  container.scrollTop = container.scrollHeight;
}

function setupSendMessageForm() {
  const form  = document.getElementById('send-message-form');
  const input = document.getElementById('message-input');
  if (!form || !input) return;
  
  form.onsubmit = async (e) => {
    e.preventDefault();
    const content = input.value.trim();
    if (!activeChannelId) { showToast('Select a conversation first', 'info'); return; }
    if (!content) return;
    await sendChatMessage(activeChannelId, content);
  };
  
  input.onkeydown = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      form.dispatchEvent(new Event('submit'));
    }
  };
}

async function sendChatMessage(channelId, content) {
  try {
    const response = await fetch(CTX + '/api/chat/channels/messages', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ channelId, content })
    });
    
    if (response.ok) {
      const input = document.getElementById('message-input');
      if (input) input.value = '';
      await loadChatHistory(activeChannelId, activeChannelName);
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    }
  } catch (err) {
    console.error('Error sending message:', err);
    showToast('Failed to send message', 'error');
  }
}

/**
 * ============ SEARCH ACTIONS ============
 */

function setupSearchHandlers() {
  const searchInput = document.getElementById('search-input');
  if (!searchInput) return;
  
  let searchTimeout;
  searchInput.oninput = (e) => {
    clearTimeout(searchTimeout);
    const query = e.target.value.trim();
    if (query.length < 2) return;
    searchTimeout = debounce(() => { searchUsers(query); }, 300);
  };
}

async function searchUsers(query) {
  if (!query || query.length < 2) { showToast('Enter at least 2 characters', 'error'); return; }
  
  try {
    const response = await fetch(CTX + '/api/network/search?q=' + encodeURIComponent(query), { method: 'GET' });
    
    if (response.ok) {
      const data  = await response.json();
      const users = Array.isArray(data) ? data : data.users || [];
      renderUsers(users, 'search-results-container');
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Search failed', 'error');
    }
  } catch (err) {
    console.error('Error searching users:', err);
    showToast('Error searching users', 'error');
  }
}

/**
 * ============ ADMIN ACTIONS ============
 */

async function loadAdminDashboard() {
  try {
    if (!isAuthenticated()) {
      window.location.href = CTX + '/pages/login.jsp';
      return;
    }
    
    const statsResponse = await fetch(CTX + '/api/admin/stats', { method: 'GET' });
    if (statsResponse.ok) {
      const stats = await statsResponse.json();
      renderAdminStats(stats);
    }
    
    const usersResponse = await fetch(CTX + '/api/admin/users', { method: 'GET' });
    if (usersResponse.ok) {
      const data  = await usersResponse.json();
      const users = unwrapApiResponse(data, 'users');
      renderAdminUsers(users, 'admin-users-container');
    } else if (usersResponse.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to load admin data', 'error');
    }
  } catch (err) {
    console.error('Error loading admin dashboard:', err);
    showToast('Error loading admin dashboard', 'error');
  }
}

function renderAdminStats(stats) {
  const container = document.getElementById('admin-stats-container');
  if (!container) return;
  
  container.innerHTML =
    '<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:16px;margin-bottom:24px;">' +
      '<div style="background:white;border:1px solid #e5e7eb;border-radius:8px;padding:16px;text-align:center;">' +
        '<p style="margin:0;color:#999;font-size:12px;text-transform:uppercase;">Total Users</p>' +
        '<p style="margin:8px 0 0 0;font-size:28px;font-weight:bold;color:#3b82f6;">' + (stats.total_users || 0) + '</p>' +
      '</div>' +
      '<div style="background:white;border:1px solid #e5e7eb;border-radius:8px;padding:16px;text-align:center;">' +
        '<p style="margin:0;color:#999;font-size:12px;text-transform:uppercase;">Total Posts</p>' +
        '<p style="margin:8px 0 0 0;font-size:28px;font-weight:bold;color:#10b981;">' + (stats.total_posts || 0) + '</p>' +
      '</div>' +
      '<div style="background:white;border:1px solid #e5e7eb;border-radius:8px;padding:16px;text-align:center;">' +
        '<p style="margin:0;color:#999;font-size:12px;text-transform:uppercase;">Total Projects</p>' +
        '<p style="margin:8px 0 0 0;font-size:28px;font-weight:bold;color:#f59e0b;">' + (stats.total_projects || 0) + '</p>' +
      '</div>' +
      '<div style="background:white;border:1px solid #e5e7eb;border-radius:8px;padding:16px;text-align:center;">' +
        '<p style="margin:0;color:#999;font-size:12px;text-transform:uppercase;">Active Users</p>' +
        '<p style="margin:8px 0 0 0;font-size:28px;font-weight:bold;color:#8b5cf6;">' + (stats.active_users || 0) + '</p>' +
      '</div>' +
    '</div>';
}

async function changeUserRole(userId, newRole) {
  try {
    const response = await fetch(CTX + '/api/admin/users/role', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ userId, role: newRole })
    });
    
    if (response.ok) {
      showToast('User role updated!', 'success');
      await loadAdminDashboard();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to update user role', 'error');
    }
  } catch (err) {
    console.error('Error updating user role:', err);
    showToast('Error updating user role', 'error');
  }
}

async function approveUser(userId) {
  try {
    const response = await fetch(CTX + '/api/admin/users/approve', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ userId })
    });
    
    if (response.ok) {
      showToast('User approved!', 'success');
      await loadAdminDashboard();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to approve user', 'error');
    }
  } catch (err) {
    console.error('Error approving user:', err);
    showToast('Error approving user', 'error');
  }
}

async function banUser(userId) {
  if (!confirm('Are you sure you want to ban this user?')) return;
  
  try {
    const response = await fetch(CTX + '/api/admin/users/ban', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ userId })
    });
    
    if (response.ok) {
      showToast('User banned!', 'success');
      await loadAdminDashboard();
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to ban user', 'error');
    }
  } catch (err) {
    console.error('Error banning user:', err);
    showToast('Error banning user', 'error');
  }
}

function getCurrentUserId() {
  return parseInt(sessionStorage.getItem('iga_user_id') || getSessionValue('userId') || 0);
}

async function loadFullProfile() {
  try {
    const response = await fetch(CTX + '/api/profile', { method: 'GET' });
    if (response.ok) {
      const data = await response.json();
      const user = unwrapApiResponse(data);
      renderProfile(user);
    } else if (response.status === 401) {
      window.location.href = CTX + '/pages/login.jsp';
    } else {
      showToast('Failed to load profile', 'error');
    }
  } catch (err) {
    console.error('Error loading profile:', err);
    showToast('Error loading profile', 'error');
  }
}

function shareProfile() {
  const url = window.location.origin + window.location.pathname;
  if (navigator.clipboard) {
    navigator.clipboard.writeText(url).then(() => {
      showToast('Profile link copied!', 'success');
    }).catch(err => {
      showToast('Press Ctrl+C to copy: ' + url, 'info');
    });
  } else {
    showToast('Copy: ' + url, 'info');
  }
}

/**
 * Initialize on page load
 */
document.addEventListener('DOMContentLoaded', () => {
  initializeEventHandlers();
});