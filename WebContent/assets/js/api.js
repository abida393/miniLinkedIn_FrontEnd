/**
 * IGA Network — Local API Wrapper
 * Interacts with the Java Proxy Servlets (/api/...)
 */

const API = (() => {
	const BASE = '/MiniLinkedIn/api';
  async function localRequest(method, endpoint, body = null) {
    const isJsonEndpoint = endpoint.includes('/update') || endpoint.includes('/create') || endpoint.includes('/ai') || endpoint.includes('/submit');
    
    const opts = { method: method };
    
    if (body) {
      if (method === 'POST' && !isJsonEndpoint) {
        // Send as form-encoded for servlets using request.getParameter
        const params = new URLSearchParams();
        for (const key in body) params.append(key, body[key]);
        opts.body = params;
        opts.headers = { 'Accept': 'application/json' };
      } else {
        // Send as JSON for servlets using request.getReader
        opts.body = JSON.stringify(body);
        opts.headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        };
      }
    } else {
      opts.headers = { 'Accept': 'application/json' };
    }
    
    try {
      const url = BASE + (endpoint.startsWith('/') ? endpoint : '/' + endpoint);
      const res = await fetch(url, opts);
      const data = await res.json().catch(() => ({}));
      return { ok: res.ok, status: res.status, data };
    } catch (err) {
      console.error('API Local Error:', err);
      return { ok: false, status: 0, data: {}, error: err.message };
    }
  }

  return {
    // ── Authentication ──
    login: (email, password) => localRequest('POST', '/login', { email, password }),
    logout: () => localRequest('POST', '/logout'),
    
    // ── Profile ──
    getProfile: () => localRequest('GET', '/profile'),
    updateProfile: (data) => localRequest('POST', '/profile/update', data),
    
    // ── Network ──
    getNetwork: () => localRequest('GET', '/network/stats'),
    getSuggestions: () => localRequest('GET', '/network/suggestions'),
    getConnections: () => localRequest('GET', '/network/connections'),
    sendRequest: (userId) => localRequest('POST', '/network/request', { userId }),
    acceptRequest: (userId) => localRequest('POST', '/network/accept', { userId }),
    removeConnection: (userId) => localRequest('POST', '/network/remove', { userId }),
    
    // ── Posts ──
    getPosts: (type = '') => localRequest('GET', `/posts${type ? '?type=' + type : ''}`),
    createPost: (data) => localRequest('POST', '/posts/create', data),
    likePost: (postId) => localRequest('POST', '/posts/like', { postId }),
    
    // ── Projects ──
    getProjects: (status = '', type = '') => 
        localRequest('GET', `/projects?status=${status}&type=${type}`),
    getProject: (id) => localRequest('GET', `/projects/${id}`),
    joinProject: (projectId) => localRequest('POST', '/projects/join', { projectId }),
    leaveProject: (projectId) => localRequest('POST', '/projects/leave', { projectId }),
    
    // ── Notifications ──
    getNotifications: () => localRequest('GET', '/notifications'),
    markRead: (notificationId) => localRequest('POST', '/notifications/read', { notificationId }),
    markAllRead: () => localRequest('POST', '/notifications/read-all'),
    
    // ── Chat ──
    getChannels: () => localRequest('GET', '/chat/channels'),
    getMessages: (channelId) => localRequest('GET', `/chat/channels/messages?channelId=${channelId}`),
    sendMessage: (channelId, content) => localRequest('POST', `/chat/channels/messages`, { channelId, content })
  };
})();
