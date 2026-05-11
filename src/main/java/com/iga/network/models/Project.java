package com.iga.network.models;

import org.json.JSONObject;
import org.json.JSONArray;

/**
 * Project Model: Represents a project.
 */
public class Project {
    private int id;
    private String title;
    private String description;
    private String type;
    private String status;
    private int ownerId;
    private String ownerName;
    private int maxMembers;
    private int memberCount;
    private String requiredSkills;
    private String createdAt;

    public Project() {}

    public Project(int id, String title, String description, String type, String status) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.type = type;
        this.status = status;
    }

    /**
     * Factory method to create a Project from a JSONObject.
     */
    public static Project fromJson(JSONObject json) {
        if (json == null) return null;
        Project project = new Project();
        project.setId(json.optInt("id", 0));
        project.setTitle(json.optString("title", ""));
        project.setDescription(json.optString("description", ""));
        project.setType(json.optString("type", "ACADEMIC"));
        project.setStatus(json.optString("status", "OPEN"));
        project.setOwnerId(json.optInt("owner_id", 0));
        project.setOwnerName(json.optString("owner_name", ""));
        project.setMaxMembers(json.optInt("max_members", 0));
        project.setMemberCount(json.optInt("member_count", 0));
        project.setRequiredSkills(json.optString("required_skills", ""));
        project.setCreatedAt(json.optString("created_at", ""));
        return project;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getOwnerId() { return ownerId; }
    public void setOwnerId(int ownerId) { this.ownerId = ownerId; }

    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }

    public int getMaxMembers() { return maxMembers; }
    public void setMaxMembers(int maxMembers) { this.maxMembers = maxMembers; }

    public int getMemberCount() { return memberCount; }
    public void setMemberCount(int memberCount) { this.memberCount = memberCount; }

    public String getRequiredSkills() { return requiredSkills; }
    public void setRequiredSkills(String requiredSkills) { this.requiredSkills = requiredSkills; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    /**
     * Convert to JSON for response
     */
    public JSONObject toJson() {
        JSONObject json = new JSONObject();
        json.put("id", id);
        json.put("title", title);
        json.put("description", description);
        json.put("type", type);
        json.put("status", status);
        json.put("owner_id", ownerId);
        json.put("owner_name", ownerName);
        json.put("max_members", maxMembers);
        json.put("member_count", memberCount);
        json.put("required_skills", requiredSkills);
        json.put("created_at", createdAt);
        return json;
    }
}
