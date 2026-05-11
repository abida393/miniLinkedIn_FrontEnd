package com.iga.network.models;

/**
 * Skill Model: Represents a professional skill associated with a profile.
 */
public class Skill {
    private int id;
    private int profileId;
    private String name;
    private String level; // Beginner, Intermediate, Expert
    private String createdAt;
    private String updatedAt;

    public Skill() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getProfileId() { return profileId; }
    public void setProfileId(int profileId) { this.profileId = profileId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public String getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(String updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "Skill{" +
                "id=" + id +
                ", profileId=" + profileId +
                ", name='" + name + '\'' +
                ", level='" + level + '\'' +
                ", createdAt='" + createdAt + '\'' +
                ", updatedAt='" + updatedAt + '\'' +
                '}';
    }
}
