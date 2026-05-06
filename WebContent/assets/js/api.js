/**
 * IGA Network — Frontend API Client
 * Fully synchronized with the IGA Network Platform API documentation (v1.0)
 */

const API = (() => {
  const BASE = (window.IGA_CONFIG && window.IGA_CONFIG.apiBaseUrl) || 'http://localhost:8000/api';

  function getToken() {
    return sessionStorage.getItem('iga_token') || '';
  }

  function headers(extra = {}) {
    const h = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...extra
    };
    const token = getToken();
    if (token) h['Authorization'] = `Bearer ${token}`;
    return h;
  }

  async function request(method, endpoint, body = null) {
    const opts = { 
        method: (method === 'PATCH' || method === 'DELETE') ? 'POST' : method, 
        headers: headers() 
    };
    
    // Method Spoofing for Laravel
    if (method === 'PATCH' || method === 'DELETE') {
        opts.headers['X-HTTP-Method-Override'] = method;
    }
    
    if (body) opts.body = JSON.stringify(body);
    
    try {
      const res = await fetch(BASE + (endpoint.startsWith('/') ? endpoint : '/' + endpoint), opts);
      
      // Handle 204 No Content
      if (res.status === 204) return { ok: true, status: 204, data: {} };
      
      const data = await res.json().catch(() => ({}));
      return { ok: res.ok, status: res.status, data };
    } catch (err) {
      console.error('API Network Error:', err);
      return { ok: false, status: 0, data: {}, error: err.message };
    }
  }

  return {
    init(token) {
      if (token) sessionStorage.setItem('iga_token', token);
    },

    // ── 1. Authentication Endpoints ──
    register: (data) => request('POST', '/register', data),
    login: (email, password) => request('POST', '/login', { email, password }),
    logout: () => request('POST', '/logout'),
    getUser: () => request('GET', '/user'),

    // ── 2. Profile Endpoints ──
    getProfile: () => request('GET', '/profile'),
    getPublicProfile: (userId) => request('GET', `/profile/${userId}`),
    updateProfile: (data) => request('POST', '/profile/update', data),
    generateAiBio: () => request('POST', '/profile/ai-bio'),
    addSkill: (name, level) => request('POST', '/profile/skills', { name, level }),
    removeSkill: (id) => request('DELETE', `/profile/skills/${id}`),
    addExperience: (data) => request('POST', '/profile/experiences', data),
    updateExperience: (id, data) => request('PATCH', `/profile/experiences/${id}`, data),
    removeExperience: (id) => request('DELETE', `/profile/experiences/${id}`),
    addPublication: (data) => request('POST', '/profile/publications', data),
    removePublication: (id) => request('DELETE', `/profile/publications/${id}`),
    addCertification: (data) => request('POST', '/profile/certifications', data),
    updateCertification: (id, data) => request('PATCH', `/profile/certifications/${id}`, data),
    removeCertification: (id) => request('DELETE', `/profile/certifications/${id}`),

    // ── 3. Post Endpoints ──
    getPosts: (page = 1, perPage = 15, type = '') => 
        request('GET', `/posts?page=${page}&per_page=${perPage}${type ? '&type=' + type : ''}`),
    createPost: (data) => request('POST', '/posts', data),
    likePost: (id) => request('POST', `/posts/${id}/like`),
    commentPost: (id, content) => request('POST', `/posts/${id}/comment`, { content }),
    sharePost: (id) => request('POST', `/posts/${id}/share`),
    deletePost: (id) => request('DELETE', `/posts/${id}`),
    aiAssist: (prompt, type) => request('POST', '/ai/assist-post', { prompt, type }),

    // ── 4. Network Endpoints ──
    getNetwork: () => request('GET', '/network'),
    getConnections: (page = 1) => request('GET', `/network/connections?page=${page}`),
    getSuggestions: (limit = 5) => request('GET', `/network/suggestions?limit=${limit}`),
    searchUsers: (q, type = '') => request('GET', `/network/search?q=${encodeURIComponent(q)}${type ? '&type=' + type : ''}`),
    sendRequest: (userId) => request('POST', `/network/request/${userId}`),
    acceptRequest: (userId) => request('POST', `/network/accept/${userId}`),
    removeConnection: (userId) => request('DELETE', `/network/remove/${userId}`),

    // ── 5. Chat Endpoints ──
    getChannels: (page = 1) => request('GET', `/chat/channels?page=${page}`),
    createChannel: (data) => request('POST', '/chat/channels', data),
    getMessages: (channelId, page = 1, limit = 50) => 
        request('GET', `/chat/channels/${channelId}/messages?page=${page}&limit=${limit}`),
    sendMessage: (channelId, content) => request('POST', `/chat/channels/${channelId}/messages`, { content }),
    startPrivateChat: (userId) => request('POST', `/chat/private/${userId}`),

    // ── 6. Project Endpoints ──
    getProjects: (page = 1, status = '', type = '') =>
      request('GET', `/projects?page=${page}${status ? '&status=' + status : ''}${type ? '&type=' + type : ''}`),
    getProject: (id) => request('GET', `/projects/${id}`),
    getProjectMembers: (id) => request('GET', `/projects/${id}/members`),
    createProject: (data) => request('POST', '/projects', data),
    joinProject: (id) => request('POST', `/projects/${id}/join`),
    leaveProject: (id) => request('POST', `/projects/${id}/leave`),
    acceptProjectInvite: (id) => request('POST', `/projects/${id}/invite/accept`),
    declineProjectInvite: (id) => request('POST', `/projects/${id}/invite/decline`),
    deleteProject: (id) => request('DELETE', `/projects/${id}`),
    
    // ── 7. Project Tasks ──
    getTasks: (projectId, status = '') => request('GET', `/projects/${projectId}/tasks${status ? '?status=' + status : ''}`),
    addTask: (projectId, title, assignedTo = null) => request('POST', `/projects/${projectId}/tasks`, { title, assigned_to: assignedTo }),
    updateTask: (projectId, taskId, data) => request('PATCH', `/projects/${projectId}/tasks/${taskId}`, data),
    deleteTask: (projectId, taskId) => request('DELETE', `/projects/${projectId}/tasks/${taskId}`),

    // ── 8. Notifications ──
    getNotifications: (page = 1, isRead = '') => request('GET', `/notifications?page=${page}${isRead !== '' ? '&is_read=' + isRead : ''}`),
    markRead: (id) => request('POST', `/notifications/${id}/read`),
    markAllRead: () => request('POST', '/notifications/read-all'),
    clearAll: () => request('DELETE', '/notifications'),

    // ── 9. Reports ──
    submitReport: (data) => request('POST', '/report', data),

    // ── 10. Admin Endpoints ──
    getStats: () => request('GET', '/admin/stats'),
    getActivity: (page = 1) => request('GET', `/admin/activity?page=${page}`),
    getAdminUsers: (page = 1, role = '', status = '') =>
      request('GET', `/admin/users?page=${page}${role ? '&role=' + role : ''}${status ? '&status=' + status : ''}`),
    getPendingUsers: (page = 1) => request('GET', `/admin/pending-users?page=${page}`),
    approveUser: (id) => request('POST', `/admin/users/${id}/approve`),
    rejectUser: (id) => request('POST', `/admin/users/${id}/reject`),
    toggleUserStatus: (id) => request('POST', `/admin/users/${id}/toggle-status`),
    deleteUser: (id) => request('DELETE', `/admin/users/${id}`),
    changeRole: (id, role) => request('PATCH', `/admin/users/${id}/role`, { role }),
    warnUser: (id, message) => request('POST', `/admin/users/${id}/warn`, { message }),
    banUser: (id) => request('POST', `/admin/users/${id}/ban`),
    getAdminPosts: (page = 1) => request('GET', '/admin/posts?page=' + page),
    deleteAdminPost: (id) => request('DELETE', '/admin/posts/' + id),
    getReports: (page = 1, status = '', type = '') => 
        request('GET', `/admin/reports?page=${page}${status ? '&status=' + status : ''}${type ? '&type=' + type : ''}`),
    resolveReport: (id, action, notes = '') => request('POST', `/admin/reports/${id}/resolve`, { action, notes }),
  };
})();
