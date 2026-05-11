package com.iga.network.models;

import org.json.JSONObject;
import org.json.JSONArray;

/**
 * Post Model: Represents a user post/feed item.
 */
public class Post {
    private int id;
    private String content;
    private String type;
    private String fileUrl;
    private String linkUrl;
    private int authorId;
    private String authorName;
    private int likes;
    private int comments;
    private String createdAt;

    public Post() {}

    public Post(int id, String content, String type, int authorId, String authorName) {
        this.id = id;
        this.content = content;
        this.type = type;
        this.authorId = authorId;
        this.authorName = authorName;
    }

    /**
     * Factory method to create a Post from a JSONObject.
     */
    public static Post fromJson(JSONObject json) {
        if (json == null) return null;
        Post post = new Post();
        post.setId(json.optInt("id", 0));
        post.setContent(json.optString("content", ""));
        post.setType(json.optString("type", "GENERAL"));
        post.setFileUrl(json.optString("file_url", ""));
        post.setLinkUrl(json.optString("link_url", ""));
        post.setAuthorId(json.optInt("author_id", 0));
        post.setAuthorName(json.optString("author_name", ""));
        post.setLikes(json.optInt("likes_count", 0));
        post.setComments(json.optInt("comments_count", 0));
        post.setCreatedAt(json.optString("created_at", ""));
        return post;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getFileUrl() { return fileUrl; }
    public void setFileUrl(String fileUrl) { this.fileUrl = fileUrl; }

    public String getLinkUrl() { return linkUrl; }
    public void setLinkUrl(String linkUrl) { this.linkUrl = linkUrl; }

    public int getAuthorId() { return authorId; }
    public void setAuthorId(int authorId) { this.authorId = authorId; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }

    public int getComments() { return comments; }
    public void setComments(int comments) { this.comments = comments; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    /**
     * Convert to JSON for response
     */
    public JSONObject toJson() {
        JSONObject json = new JSONObject();
        json.put("id", id);
        json.put("content", content);
        json.put("type", type);
        json.put("file_url", fileUrl);
        json.put("link_url", linkUrl);
        json.put("author_id", authorId);
        json.put("author_name", authorName);
        json.put("likes_count", likes);
        json.put("comments_count", comments);
        json.put("created_at", createdAt);
        return json;
    }
}
