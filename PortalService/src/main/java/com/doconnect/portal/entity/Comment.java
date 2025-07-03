package com.doconnect.portal.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;

@Entity
@JsonIgnoreProperties({"user", "question", "answer"})
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String content;

    private boolean approved = false;
    private boolean active = true;

    @ManyToOne
    private User user;

    @ManyToOne
    private Question question;

    @ManyToOne
    private Answer answer;

    public Comment() {}

    public Comment(Long id, String content, User user, Question question, Answer answer,
                   boolean approved, boolean active) {
        this.id = id;
        this.content = content;
        this.user = user;
        this.question = question;
        this.answer = answer;
        this.approved = approved;
        this.active = active;
    }

    // ======= Getters and Setters =======

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public boolean isApproved() { return approved; }
    public void setApproved(boolean approved) { this.approved = approved; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Question getQuestion() { return question; }
    public void setQuestion(Question question) { this.question = question; }

    public Answer getAnswer() { return answer; }
    public void setAnswer(Answer answer) { this.answer = answer; }

    // ======= Transient DTO Mapping =======

    @Transient
    public String getCommentedBy() {
        return user != null ? user.getUsername() : null;
    }

    @Transient
    public Long getUserId() {
        return user != null ? user.getId() : null;
    }
}
