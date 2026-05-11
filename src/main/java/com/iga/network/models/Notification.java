package com.iga.network.models;

import org.json.JSONObject;

/**
 * Notification Model: Represents a user notification.
 */
public class Notification {
    private int id;
    private String type;
    private int userId;
    private int relatedId;
    private String relatedType;
    private String message;
    private boolean isRead;
    private String createdAt;

    public Notification() {}

    public Notification(int id, String type, int userId, String message) {
        this.id = id;
        this.type = type;
        this.userId = userId;
        this.message = message;
    }

    /**
     * Factory method to create a Notification from a JSONObject.
     */
    public static Notification fromJson(JSONObject json) {
        if (json == null) return null;
        Notification notif = new Notification();
        notif.setId(json.optInt("id", 0));
        notif.setType(json.optString("type", ""));
        notif.setUserId(json.optInt("user_id", 0));
        notif.setRelatedId(json.optInt("related_id", 0));
        notif.setRelatedType(json.optString("related_type", ""));
        notif.setMessage(json.optString("message", ""));
        notif.setRead(json.optBoolean("is_read", false));
        notif.setCreatedAt(json.optString("created_at", ""));
        return notif;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getRelatedId() { return relatedId; }
    public void setRelatedId(int relatedId) { this.relatedId = relatedId; }

    public String getRelatedType() { return relatedType; }
    public void setRelatedType(String relatedType) { this.relatedType = relatedType; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean isRead) { this.isRead = isRead; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    /**
     * Convert to JSON for response
     */
    public JSONObject toJson() {
        JSONObject json = new JSONObject();
        json.put("id", id);
        json.put("type", type);
        json.put("user_id", userId);
        json.put("related_id", relatedId);
        json.put("related_type", relatedType);
        json.put("message", message);
        json.put("is_read", isRead);
        json.put("created_at", createdAt);
        return json;
    }
}
