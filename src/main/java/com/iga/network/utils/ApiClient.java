package com.iga.network.utils;

import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import org.json.JSONObject;
import org.json.JSONArray;

/**
 * ApiClient: Centralized HTTP client for all Laravel API calls.
 */
public class ApiClient {

    private static String BASE_URL = "http://localhost:8000/api";
    private static final int TIMEOUT_MS = 15000;

    public static void setBaseUrl(String url) {
        if (url != null && !url.isEmpty()) {
            BASE_URL = url.endsWith("/") ? url.substring(0, url.length() - 1) : url;
        }
    }

    // ─── Core HTTP Methods ─────────────────────────────────────────────────

    public static JSONObject get(String endpoint, String token) throws IOException {
        return request("GET", endpoint, null, token);
    }

    public static JSONObject post(String endpoint, JSONObject body, String token) throws IOException {
        return request("POST", endpoint, body, token);
    }

    public static JSONObject patch(String endpoint, JSONObject body, String token) throws IOException {
        return request("PATCH", endpoint, body, token);
    }

    public static JSONObject delete(String endpoint, String token) throws IOException {
        return request("DELETE", endpoint, null, token);
    }

    // ─── Internal Request Handler ──────────────────────────────────────────

    private static JSONObject request(String method, String endpoint, JSONObject body, String token)
            throws IOException {

        String fullPath = BASE_URL + (endpoint.startsWith("/") ? endpoint : "/" + endpoint);
        URL url = new URL(fullPath);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        // Laravel/Sanctum often requires method spoofing for PATCH/DELETE in some environments
        if (method.equals("PATCH") || method.equals("DELETE")) {
            conn.setRequestMethod("POST");
            conn.setRequestProperty("X-HTTP-Method-Override", method);
        } else {
            conn.setRequestMethod(method);
        }

        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("X-Requested-With", "XMLHttpRequest");
        conn.setConnectTimeout(TIMEOUT_MS);
        conn.setReadTimeout(TIMEOUT_MS);

        if (token != null && !token.isEmpty()) {
            conn.setRequestProperty("Authorization", "Bearer " + token);
        }

        if (body != null && (method.equals("POST") || method.equals("PATCH"))) {
            conn.setDoOutput(true);
            byte[] input = body.toString().getBytes(StandardCharsets.UTF_8);
            conn.setRequestProperty("Content-Length", String.valueOf(input.length));
            try (OutputStream os = conn.getOutputStream()) {
                os.write(input);
            }
        }

        int statusCode = conn.getResponseCode();
        InputStream is = (statusCode >= 200 && statusCode < 400)
                ? conn.getInputStream()
                : conn.getErrorStream();

        StringBuilder sb = new StringBuilder();
        if (is != null) {
            try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                String line;
                while ((line = br.readLine()) != null) sb.append(line);
            }
        }

        conn.disconnect();

        String responseBody = sb.toString().trim();
        JSONObject result = new JSONObject();
        result.put("statusCode", statusCode);

        JSONObject dataObj = new JSONObject();
        if (!responseBody.isEmpty()) {
            try {
                if (responseBody.startsWith("[")) {
                    dataObj.put("items", new JSONArray(responseBody));
                } else if (responseBody.startsWith("{")) {
                    dataObj = new JSONObject(responseBody);
                } else {
                    dataObj.put("message", responseBody);
                }
            } catch (Exception e) {
                dataObj.put("message", "Failed to parse response: " + e.getMessage());
                dataObj.put("rawData", responseBody);
            }
        } else {
            dataObj.put("message", "Empty response from server");
        }
        
        result.put("data", dataObj);
        return result;
    }

    // ─── 1. Authentication ──────────────────────────────────────────────────

    public static JSONObject register(JSONObject userData) throws IOException {
        return post("/register", userData, null);
    }

    public static JSONObject login(String email, String password) throws IOException {
        JSONObject body = new JSONObject();
        body.put("email", email);
        body.put("password", password);
        return post("/login", body, null);
    }

    public static JSONObject getCurrentUser(String token) throws IOException {
        return get("/user", token);
    }

    public static JSONObject logout(String token) throws IOException {
        return post("/logout", null, token);
    }

    // ─── 2. Profile ────────────────────────────────────────────────────────

    public static JSONObject getProfile(String token) throws IOException {
        return get("/profile", token);
    }

    public static JSONObject getPublicProfile(String token, int userId) throws IOException {
        return get("/profile/" + userId, token);
    }

    public static JSONObject updateProfile(String token, JSONObject data) throws IOException {
        return post("/profile/update", data, token);
    }

    public static JSONObject generateAiBio(String token) throws IOException {
        return post("/profile/ai-bio", null, token);
    }

    public static JSONObject addSkill(String token, String name, String level) throws IOException {
        JSONObject body = new JSONObject();
        body.put("name", name);
        body.put("level", level);
        return post("/profile/skills", body, token);
    }

    public static JSONObject removeSkill(String token, int skillId) throws IOException {
        return delete("/profile/skills/" + skillId, token);
    }

    public static JSONObject addExperience(String token, JSONObject data) throws IOException {
        return post("/profile/experiences", data, token);
    }

    public static JSONObject updateExperience(String token, int expId, JSONObject data) throws IOException {
        return patch("/profile/experiences/" + expId, data, token);
    }

    public static JSONObject deleteExperience(String token, int expId) throws IOException {
        return delete("/profile/experiences/" + expId, token);
    }

    public static JSONObject addCertification(String token, JSONObject data) throws IOException {
        return post("/profile/certifications", data, token);
    }

    public static JSONObject updateCertification(String token, int certId, JSONObject data) throws IOException {
        return patch("/profile/certifications/" + certId, data, token);
    }

    public static JSONObject removeCertification(String token, int certId) throws IOException {
        return delete("/profile/certifications/" + certId, token);
    }

    // ─── 3. Posts ──────────────────────────────────────────────────────────

    public static JSONObject getPosts(String token, int page, String type) throws IOException {
        String endpoint = "/posts?page=" + page;
        if (type != null && !type.isEmpty()) endpoint += "&type=" + type;
        return get(endpoint, token);
    }

    public static JSONObject createPost(String token, JSONObject data) throws IOException {
        return post("/posts", data, token);
    }

    public static JSONObject toggleLike(String token, int postId) throws IOException {
        return post("/posts/" + postId + "/like", null, token);
    }

    public static JSONObject addComment(String token, int postId, String content) throws IOException {
        JSONObject body = new JSONObject();
        body.put("content", content);
        return post("/posts/" + postId + "/comment", body, token);
    }

    public static JSONObject sharePost(String token, int postId) throws IOException {
        return post("/posts/" + postId + "/share", null, token);
    }

    public static JSONObject deletePost(String token, int postId) throws IOException {
        return delete("/posts/" + postId, token);
    }

    // ─── 4. Network ────────────────────────────────────────────────────────

    public static JSONObject getNetworkStats(String token) throws IOException {
        return get("/network", token);
    }

    public static JSONObject getConnections(String token, int page) throws IOException {
        return get("/network/connections?page=" + page, token);
    }

    public static JSONObject getSuggestions(String token, int limit) throws IOException {
        return get("/network/suggestions?limit=" + limit, token);
    }

    public static JSONObject searchUsers(String token, String query, String roleFilter) throws IOException {
        String endpoint = "/network/search?q=" + URLEncoder.encode(query, "UTF-8");
        if (roleFilter != null) endpoint += "&type=" + roleFilter;
        return get(endpoint, token);
    }

    public static JSONObject sendConnectionRequest(String token, int userId) throws IOException {
        return post("/network/request/" + userId, null, token);
    }

    public static JSONObject acceptConnectionRequest(String token, int userId) throws IOException {
        return post("/network/accept/" + userId, null, token);
    }

    public static JSONObject removeConnection(String token, int userId) throws IOException {
        return delete("/network/remove/" + userId, token);
    }

    // ─── 5. Projects ───────────────────────────────────────────────────────

    public static JSONObject getProjects(String token, int page, String status, String type) throws IOException {
        String endpoint = "/projects?page=" + page;
        if (status != null) endpoint += "&status=" + status;
        if (type != null) endpoint += "&type=" + type;
        return get(endpoint, token);
    }

    public static JSONObject createProject(String token, JSONObject data) throws IOException {
        return post("/projects", data, token);
    }

    public static JSONObject getProjectDetails(String token, int projectId) throws IOException {
        return get("/projects/" + projectId, token);
    }

    public static JSONObject getProjectMembers(String token, int projectId) throws IOException {
        return get("/projects/" + projectId + "/members", token);
    }

    public static JSONObject joinProject(String token, int projectId) throws IOException {
        return post("/projects/" + projectId + "/join", null, token);
    }

    public static JSONObject leaveProject(String token, int projectId) throws IOException {
        return post("/projects/" + projectId + "/leave", null, token);
    }

    public static JSONObject acceptProjectInvite(String token, int projectId) throws IOException {
        return post("/projects/" + projectId + "/invite/accept", null, token);
    }

    public static JSONObject declineProjectInvite(String token, int projectId) throws IOException {
        return post("/projects/" + projectId + "/invite/decline", null, token);
    }

    public static JSONObject getProjectTasks(String token, int projectId) throws IOException {
        return get("/projects/" + projectId + "/tasks", token);
    }

    public static JSONObject createProjectTask(String token, int projectId, JSONObject data) throws IOException {
        return post("/projects/" + projectId + "/tasks", data, token);
    }

    public static JSONObject updateProjectTask(String token, int projectId, int taskId, JSONObject data) throws IOException {
        return patch("/projects/" + projectId + "/tasks/" + taskId, data, token);
    }

    public static JSONObject deleteProjectTask(String token, int projectId, int taskId) throws IOException {
        return delete("/projects/" + projectId + "/tasks/" + taskId, token);
    }

    public static JSONObject inviteToProject(String token, int projectId, int userId) throws IOException {
        return post("/projects/" + projectId + "/invite/" + userId, null, token);
    }

    public static JSONObject approveMember(String token, int projectId, int userId) throws IOException {
        return post("/projects/" + projectId + "/members/" + userId + "/approve", null, token);
    }

    public static JSONObject rejectMember(String token, int projectId, int userId) throws IOException {
        return post("/projects/" + projectId + "/members/" + userId + "/reject", null, token);
    }

    // ─── 6. Notifications ──────────────────────────────────────────────────

    public static JSONObject getNotifications(String token, int page, String isRead) throws IOException {
        String endpoint = "/notifications?page=" + page;
        if (isRead != null) endpoint += "&is_read=" + isRead;
        return get(endpoint, token);
    }

    public static JSONObject markNotificationRead(String token, int id) throws IOException {
        return post("/notifications/" + id + "/read", null, token);
    }

    public static JSONObject markAllNotificationsRead(String token) throws IOException {
        return post("/notifications/read-all", null, token);
    }

    public static JSONObject clearAllNotifications(String token) throws IOException {
        return delete("/notifications", token);
    }

    // ─── 7. Admin ──────────────────────────────────────────────────────────

    public static JSONObject getAdminStats(String token) throws IOException {
        return get("/admin/stats", token);
    }

    public static JSONObject getAdminUsers(String token, int page, String role, String status) throws IOException {
        String endpoint = "/admin/users?page=" + page;
        if (role != null) endpoint += "&role=" + role;
        if (status != null) endpoint += "&status=" + status;
        return get(endpoint, token);
    }

    public static JSONObject approveUser(String token, int userId) throws IOException {
        return post("/admin/users/" + userId + "/approve", null, token);
    }

    public static JSONObject banUser(String token, int userId) throws IOException {
        return post("/admin/users/" + userId + "/ban", null, token);
    }

    public static JSONObject resolveReport(String token, int reportId, String action, String notes) throws IOException {
        JSONObject body = new JSONObject();
        body.put("action", action);
        if (notes != null) body.put("notes", notes);
        return post("/admin/reports/" + reportId + "/resolve", body, token);
    }

    public static JSONObject changeUserRole(String token, int userId, String role) throws IOException {
        JSONObject body = new JSONObject();
        body.put("role", role);
        return patch("/admin/users/" + userId + "/role", body, token);
    }

    public static JSONObject getAdminActivity(String token, int page, String dateFrom, String dateTo) throws IOException {
        String endpoint = "/admin/activity?page=" + page;
        if (dateFrom != null) endpoint += "&date_from=" + dateFrom;
        if (dateTo != null) endpoint += "&date_to=" + dateTo;
        return get(endpoint, token);
    }

    public static JSONObject getPendingUsers(String token, int page) throws IOException {
        return get("/admin/pending-users?page=" + page, token);
    }

    public static JSONObject rejectUser(String token, int userId) throws IOException {
        return post("/admin/users/" + userId + "/reject", null, token);
    }

    public static JSONObject toggleUserStatus(String token, int userId) throws IOException {
        return post("/admin/users/" + userId + "/toggle-status", null, token);
    }

    public static JSONObject deleteUser(String token, int userId) throws IOException {
        return delete("/admin/users/" + userId, token);
    }

    public static JSONObject sendWarning(String token, int userId, String message) throws IOException {
        JSONObject body = new JSONObject();
        body.put("message", message);
        return post("/admin/users/" + userId + "/warn", body, token);
    }

    public static JSONObject getAdminPosts(String token, int page) throws IOException {
        return get("/admin/posts?page=" + page, token);
    }

    public static JSONObject deleteAdminPost(String token, int postId) throws IOException {
        return delete("/admin/posts/" + postId, token);
    }

    public static JSONObject getReports(String token, int page, String status, String type) throws IOException {
        String endpoint = "/admin/reports?page=" + page;
        if (status != null) endpoint += "&status=" + status;
        if (type != null) endpoint += "&type=" + type;
        return get(endpoint, token);
    }

    // ─── 8. Chat ───────────────────────────────────────────────────────────

    public static JSONObject startPrivateChat(String token, int otherUserId) throws IOException {
        return post("/chat/private/" + otherUserId, null, token);
    }

    public static JSONObject sendMessage(String token, int channelId, String content) throws IOException {
        JSONObject body = new JSONObject();
        body.put("content", content);
        return post("/chat/channels/" + channelId + "/messages", body, token);
    }

    public static JSONObject createChannel(String token, JSONObject data) throws IOException {
        return post("/chat/channels", data, token);
    }

    // ─── 9. Miscellaneous ──────────────────────────────────────────────────

    public static JSONObject addPublication(String token, JSONObject data) throws IOException {
        return post("/profile/publications", data, token);
    }

    public static JSONObject deletePublication(String token, String id) throws IOException {
        return delete("/profile/publications/" + id, token);
    }

    public static JSONObject submitReport(String token, JSONObject data) throws IOException {
        return post("/report", data, token);
    }

    public static JSONObject aiAssistPost(String token, JSONObject data) throws IOException {
        return post("/ai/assist-post", data, token);
    }
}
