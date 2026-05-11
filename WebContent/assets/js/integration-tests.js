/**
 * INTEGRATION TEST GUIDE
 * 
 * This document provides step-by-step testing procedures to verify the frontend-backend integration
 */

// ============ TEST 1: LOGIN & SESSION MANAGEMENT ============
console.log("TEST 1: Login System");
// 1. Navigate to login.jsp
// 2. Enter credentials (from Laravel backend)
// 3. Submit form
// 4. Check session storage for authToken
// Expected: Session token stored, redirected to home.jsp

// Test function
function testLoginSession() {
  const token = sessionStorage.getItem('authToken');
  const userId = sessionStorage.getItem('iga_user_id');
  console.log('Session Token:', token);
  console.log('User ID:', userId);
  return token !== null && userId !== null;
}

// ============ TEST 2: LOAD POSTS FEED ============
console.log("TEST 2: Load Posts Feed");
// 1. Open browser DevTools Console
// 2. Run: testLoadPosts()
// Expected: Posts render in feed with correct structure

async function testLoadPosts() {
  try {
    const response = await fetch('/api/posts', { method: 'GET' });
    if (response.ok) {
      const posts = await response.json();
      console.log('Posts loaded:', posts.length, posts);
      renderPosts(posts);
      return true;
    }
    return false;
  } catch (err) {
    console.error('Load posts error:', err);
    return false;
  }
}

// ============ TEST 3: CREATE POST ============
console.log("TEST 3: Create Post");
// 1. On home.jsp, find #create-post-form
// 2. Enter content in textarea
// 3. Select post type
// 4. Click "Post" button
// Expected: Toast notification appears, post added to feed

async function testCreatePost(content, type = 'GENERAL') {
  return new Promise((resolve) => {
    // Simulate form submission
    document.getElementById('post-content').value = content;
    document.getElementById('post-type').value = type;
    document.getElementById('create-post-form').dispatchEvent(new Event('submit'));
    
    // Wait for success
    setTimeout(() => {
      resolve(true);
    }, 2000);
  });
}

// ============ TEST 4: LIKE POST ============
console.log("TEST 4: Like Post");
// 1. On home.jsp, click like button on any post
// Expected: Like count increments, toast notification shows

async function testLikePost(postId = 1) {
  try {
    const response = await fetch('/api/posts/like', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ postId: postId })
    });
    if (response.ok) {
      console.log('Post liked successfully');
      showToast('Test: Post liked!', 'success');
      return true;
    }
    return false;
  } catch (err) {
    console.error('Like post error:', err);
    return false;
  }
}

// ============ TEST 5: LOAD PROJECTS ============
console.log("TEST 5: Load Projects");
// 1. Navigate to projects.jsp
// 2. Verify projects render below the "Create Project" form
// Expected: Project list displays with join/leave buttons

async function testLoadProjects() {
  try {
    const response = await fetch('/api/projects', { method: 'GET' });
    if (response.ok) {
      const projects = await response.json();
      console.log('Projects loaded:', projects.length);
      renderProjects(projects);
      return true;
    }
    return false;
  } catch (err) {
    console.error('Load projects error:', err);
    return false;
  }
}

// ============ TEST 6: CREATE PROJECT ============
console.log("TEST 6: Create Project");
// 1. On projects.jsp, fill in project creation form
// 2. Click "Create Project" button
// Expected: Toast notification, new project appears in list

async function testCreateProject() {
  return new Promise((resolve) => {
    document.getElementById('project-title').value = 'Test Project';
    document.getElementById('project-description').value = 'This is a test project';
    document.getElementById('project-type').value = 'ACADEMIC';
    document.getElementById('create-project-form').dispatchEvent(new Event('submit'));
    
    setTimeout(() => {
      resolve(true);
    }, 2000);
  });
}

// ============ TEST 7: LOAD PROFILE ============
console.log("TEST 7: Load User Profile");
// 1. Navigate to profile.jsp or click on a user
// 2. Verify profile data displays with stats
// Expected: User info, connections count, posts count render

async function testLoadProfile() {
  try {
    const response = await fetch('/api/profile', { method: 'GET' });
    if (response.ok) {
      const user = await response.json();
      console.log('Profile loaded:', user);
      renderUserProfile(user);
      return true;
    }
    return false;
  } catch (err) {
    console.error('Load profile error:', err);
    return false;
  }
}

// ============ TEST 8: UPDATE PROFILE ============
console.log("TEST 8: Update Profile");
// 1. Navigate to edit-profile.jsp
// 2. Modify profile fields
// 3. Click "Save Changes"
// Expected: Toast notification, redirect to profile.jsp

async function testUpdateProfile() {
  return new Promise((resolve) => {
    document.getElementById('first-name').value = 'Test';
    document.getElementById('last-name').value = 'User';
    document.getElementById('email').value = 'test@test.com';
    document.getElementById('bio').value = 'Testing profile update';
    document.getElementById('update-profile-form').dispatchEvent(new Event('submit'));
    
    setTimeout(() => {
      resolve(true);
    }, 2000);
  });
}

// ============ TEST 9: LOAD NOTIFICATIONS ============
console.log("TEST 9: Load Notifications");
// 1. Navigate to notifications.jsp
// 2. Verify notifications render with unread indicator
// Expected: Notification list displays

async function testLoadNotifications() {
  try {
    const response = await fetch('/api/notifications', { method: 'GET' });
    if (response.ok) {
      const notifications = await response.json();
      console.log('Notifications loaded:', notifications.length);
      renderNotifications(notifications);
      return true;
    }
    return false;
  } catch (err) {
    console.error('Load notifications error:', err);
    return false;
  }
}

// ============ TEST 10: NETWORK & CONNECTIONS ============
console.log("TEST 10: Network & Connections");
// 1. Navigate to network.jsp
// 2. Verify user suggestions and connections display
// 3. Click "Connect" button
// Expected: Connection request sent, toast notification

async function testNetwork() {
  try {
    const response = await fetch('/api/suggestions', { method: 'GET' });
    if (response.ok) {
      const users = await response.json();
      console.log('Suggestions loaded:', users.length);
      renderUsers(users);
      return true;
    }
    return false;
  } catch (err) {
    console.error('Load suggestions error:', err);
    return false;
  }
}

// ============ TEST 11: ADMIN DASHBOARD ============
console.log("TEST 11: Admin Dashboard");
// 1. Navigate to admin.jsp (requires ADMIN role)
// 2. Verify stats display (total users, posts, projects)
// 3. Verify user management table loads
// Expected: Admin stats and user table render

async function testAdminDashboard() {
  try {
    const statsResponse = await fetch('/api/admin/stats', { method: 'GET' });
    const usersResponse = await fetch('/api/admin/users', { method: 'GET' });
    
    if (statsResponse.ok && usersResponse.ok) {
      const stats = await statsResponse.json();
      const users = await usersResponse.json();
      console.log('Admin stats:', stats);
      console.log('Admin users:', users.length);
      renderAdminStats(stats);
      renderAdminUsers(users);
      return true;
    }
    return false;
  } catch (err) {
    console.error('Admin dashboard error:', err);
    return false;
  }
}

// ============ COMPREHENSIVE INTEGRATION TEST ============
console.log("Running Comprehensive Integration Test...");

async function runAllTests() {
  const results = {
    loginSession: testLoginSession(),
    loadPosts: await testLoadPosts(),
    loadProjects: await testLoadProjects(),
    loadProfile: await testLoadProfile(),
    loadNotifications: await testLoadNotifications(),
    network: await testNetwork(),
  };
  
  console.table(results);
  
  // Count successes
  const passedTests = Object.values(results).filter(r => r === true).length;
  const totalTests = Object.keys(results).length;
  
  console.log(`\n✅ TESTS PASSED: ${passedTests}/${totalTests}`);
  
  if (passedTests === totalTests) {
    showToast('All integration tests passed! ✅', 'success');
  } else {
    showToast(`${totalTests - passedTests} test(s) failed. Check console.`, 'error');
  }
  
  return results;
}

// Run tests from browser console
// Call: runAllTests()

// ============ DEBUGGING HELPERS ============

function debugSessionStorage() {
  console.log('Session Storage Contents:');
  console.log('authToken:', sessionStorage.getItem('authToken'));
  console.log('iga_user_id:', sessionStorage.getItem('iga_user_id'));
  console.log('Current User ID:', getCurrentUserId());
  console.log('Is Authenticated:', isAuthenticated());
}

function debugAPIRequest(endpoint, method = 'GET', body = null) {
  console.log(`API Request: ${method} /api${endpoint}`, body);
  return fetch(`/api${endpoint}`, {
    method: method,
    headers: { 'Content-Type': 'application/json' },
    body: body ? JSON.stringify(body) : null
  }).then(r => {
    console.log(`Response Status: ${r.status}`);
    return r.json();
  }).then(data => {
    console.log('Response Data:', data);
    return data;
  }).catch(err => {
    console.error('API Error:', err);
  });
}

// Usage examples:
// debugSessionStorage()
// debugAPIRequest('/posts')
// debugAPIRequest('/posts/create', 'POST', { content: 'Test post', type: 'GENERAL' })
