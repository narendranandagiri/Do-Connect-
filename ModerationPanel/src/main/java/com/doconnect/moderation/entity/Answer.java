package com.doconnect.moderation.entity;


import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;

@Entity
public class Answer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String content;
    private int likes;

    private boolean approved;
    private boolean active;
    private boolean resolved = false;

    @ManyToOne
    private User user;

    @ManyToOne
    @JsonBackReference
    private Question question;

    public Answer() {}

    public Answer(Long id, String content, int likes, User user, Question question, boolean approved, boolean active) {
        this.id = id;
        this.content = content;
        this.likes = likes;
        this.user = user;
        this.question = question;
        this.approved = approved;
        this.active = active;
    }

    // Getters and Setters

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }

    public boolean isApproved() { return approved; }
    public void setApproved(boolean approved) { this.approved = approved; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public boolean isResolved() { return resolved; }
    public void setResolved(boolean resolved) { this.resolved = resolved; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Question getQuestion() { return question; }
    public void setQuestion(Question question) { this.question = question; }

    // Transient helper methods

    @Transient
    public Long getUserId() {
        return user != null ? user.getId() : null;
    }

    @Transient
    public Long getQuestionId() {
        return question != null ? question.getId() : null;
    }

    @Transient
    public String getAnsweredBy() {
        return user != null ? user.getUsername() : "Anonymous";
    }

    // Optional alias for content if used in JSP
    @Transient
    public String getText() {
        return content;
    }


}
