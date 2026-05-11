/**
 * Utility Functions - Toast Notifications, Validation, Helpers
 */

/**
 * Show toast notification
 * @param {string} message - Message to display
 * @param {string} type - 'success', 'error', 'info', 'warning'
 * @param {number} duration - Duration in milliseconds (default: 3000)
 */
function showToast(message, type = 'info', duration = 3000) {
  const toastContainer = document.getElementById('toast-container') || createToastContainer();
  
  const toast = document.createElement('div');
  toast.className = `toast toast-${type}`;
  toast.innerHTML = message;
  
  // Add styles inline
  toast.style.cssText = `
    padding: 12px 20px;
    margin-bottom: 10px;
    border-radius: 4px;
    color: white;
    font-size: 14px;
    animation: slideIn 0.3s ease-in;
    cursor: pointer;
  `;
  
  // Set background color based on type
  const colors = {
    success: '#10b981',
    error: '#ef4444',
    warning: '#f59e0b',
    info: '#3b82f6'
  };
  toast.style.backgroundColor = colors[type] || colors.info;
  
  toastContainer.appendChild(toast);
  
  // Auto remove after duration
  setTimeout(() => {
    toast.style.animation = 'slideOut 0.3s ease-out';
    setTimeout(() => toast.remove(), 300);
  }, duration);
  
  // Manual close on click
  toast.addEventListener('click', () => {
    toast.style.animation = 'slideOut 0.3s ease-out';
    setTimeout(() => toast.remove(), 300);
  });
}

/**
 * Create toast container if it doesn't exist
 */
function createToastContainer() {
  const container = document.createElement('div');
  container.id = 'toast-container';
  container.style.cssText = `
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 9999;
    max-width: 400px;
  `;
  document.body.appendChild(container);
  return container;
}

/**
 * Validate email format
 */
function isValidEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

/**
 * Validate password strength
 */
function isValidPassword(password) {
  return password && password.length >= 6;
}

/**
 * Validate URL format
 */
function isValidUrl(url) {
  try {
    new URL(url);
    return true;
  } catch (e) {
    return false;
  }
}

/**
 * Format date to readable string
 */
function formatDate(dateString) {
  if (!dateString) return '';
  const date = new Date(dateString);
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  });
}

/**
 * Truncate text to specified length
 */
function truncateText(text, length = 100) {
  if (!text) return '';
  return text.length > length ? text.substring(0, length) + '...' : text;
}

/**
 * Show loading spinner
 */
function showSpinner(element) {
  if (!element) return;
  element.innerHTML = `
    <div style="text-align: center; padding: 20px;">
      <div class="spinner" style="
        border: 4px solid #f3f3f3;
        border-top: 4px solid #3b82f6;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        animation: spin 1s linear infinite;
        margin: 0 auto;
      "></div>
      <p style="margin-top: 10px; color: #666;">Loading...</p>
    </div>
  `;
}

/**
 * Hide loading spinner
 */
function hideSpinner(element) {
  if (!element) return;
  element.innerHTML = '';
}

/**
 * Debounce function for search/input
 */
function debounce(func, delay = 300) {
  let timeoutId;
  return function(...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func.apply(this, args), delay);
  };
}

/**
 * Get session storage value
 */
function getSessionValue(key) {
  return sessionStorage.getItem(key);
}

/**
 * Set session storage value
 */
function setSessionValue(key, value) {
  sessionStorage.setItem(key, value);
}

/**
 * Check if user is authenticated
 */
function isAuthenticated() {
  // 'authToken' is set by header.jsp from the Java HttpSession on every page load
  return sessionStorage.getItem('authToken') !== null;
}

/**
 * Redirect to login if not authenticated
 */
function requireAuth() {
  if (!isAuthenticated()) {
    window.location.href = '/pages/login.jsp';
  }
}

/**
 * Add CSS animation styles if not already added
 */
function addAnimationStyles() {
  if (document.getElementById('animation-styles')) return;
  
  const style = document.createElement('style');
  style.id = 'animation-styles';
  style.innerHTML = `
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
    @keyframes slideIn {
      from { transform: translateX(400px); opacity: 0; }
      to { transform: translateX(0); opacity: 1; }
    }
    @keyframes slideOut {
      from { transform: translateX(0); opacity: 1; }
      to { transform: translateX(400px); opacity: 0; }
    }
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
  `;
  document.head.appendChild(style);
}

// Initialize animation styles on page load
document.addEventListener('DOMContentLoaded', addAnimationStyles);

/**
 * Unwrap the ApiClient response envelope.
 * Handles: direct array, {data: [...]}, {data: {items: [...]}},
 *          {data: {data: [...]}}, {statusCode, data: {...}}
 * @param {*} data - The raw JSON response
 * @param {string} [fallbackKey] - Optional key to check for (e.g. 'posts', 'users')
 * @returns {Array|Object} - The unwrapped data
 */
function unwrapApiResponse(data, fallbackKey) {
    if (Array.isArray(data)) return data;
    if (!data || typeof data !== 'object') return [];

    // ApiClient envelope: {statusCode, data: {...}}
    var inner = data;
    if (inner.statusCode !== undefined && inner.data !== undefined) {
        inner = inner.data;
    }

    // Laravel pagination or direct array: {data: [...]}
    if (Array.isArray(inner)) return inner;
    if (Array.isArray(inner.data)) return inner.data;
    if (Array.isArray(inner.items)) return inner.items;
    if (fallbackKey && Array.isArray(inner[fallbackKey])) return inner[fallbackKey];

    // Single object (e.g., profile, project details) — return as-is
    return inner;
}
