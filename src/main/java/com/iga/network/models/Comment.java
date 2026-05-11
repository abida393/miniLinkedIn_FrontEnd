package com.iga.network.models;

import org.json.JSONObject;

/**
 * Comment Model: Represents a comment on a post.
 */
public class Comment {
    private int id;
    private int postId;
    private int authorId;
    private String authorName;
    private String content;
    private String createdAt;

    public Comment() {}

    public Comment(int id, int postId, int authorId, String authorName, String content) {
        this.id = id;
        this.postId = postId;
        this.authorId = authorId;
        this.authorName = authorName;
        this.content = content;
    }

    public static Comment fromJson(JSONObject json) {
        if (json == null) return null;
        Comment comment = new Comment();
        comment.setId(json.optInt("id", 0));
        comment.setPostId(json.optInt("post_id", 0));
        comment.setAuthorId(json.optInt("author_id", 0));
        comment.setAuthorName(json.optString("author_name", ""));
        comment.setContent(json.optString("content", ""));
        comment.setCreatedAt(json.optString("created_at", ""));
        return comment;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }

    public int getAuthorId() { return authorId; }
    public void setAuthorId(int authorId) { this.authorId = authorId; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public JSONObject toJson() {
        JSONObject json = new JSONObject();
        json.put("id", id);
        json.put("post_id", postId);
        json.put("author_id", authorId);
        json.put("author_name", authorName);
        json.put("content", content);
        json.put("created_at", createdAt);
        return json;
    }
}
