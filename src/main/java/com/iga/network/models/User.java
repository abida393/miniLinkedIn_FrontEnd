package com.iga.network.models;

import org.json.JSONObject;

/**
 * User Model: Represents a user in the IGA Network.
 */
public class User {
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String role;

    public User() {}

    public User(int id, String firstName, String lastName, String email, String role) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.role = role;
    }

    /**
     * Factory method to create a User from a JSONObject.
     */
    public static User fromJson(JSONObject json) {
        if (json == null) return null;
        User user = new User();
        user.setId(json.optInt("id", 0));
        user.setFirstName(json.optString("first_name", ""));
        user.setLastName(json.optString("last_name", ""));
        user.setEmail(json.optString("email", ""));
        user.setRole(json.optString("role", ""));
        return user;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getFullName() {
        return firstName + " " + lastName;
    }
}
