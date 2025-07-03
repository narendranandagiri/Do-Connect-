package com.doconnect.portal.entity;

import jakarta.persistence.*;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String content;
    private String topic;

    private boolean approved = false;
    private boolean resolved = false;
    private boolean active = true;

    @ManyToOne
    @JsonManagedReference
    private User user;

    @OneToMany(mappedBy = "question")
    @JsonManagedReference
    private List<Answer> answers;

    public Question() {}

    public Question(String title, String content, String topic, User user) {
        this.title = title;
        this.content = content;
        this.topic = topic;
        this.user = user;
    }

    // ======= Getters and Setters =======

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getTopic() { return topic; }
    public void setTopic(String topic) { this.topic = topic; }

    public boolean isApproved() { return approved; }
    public void setApproved(boolean approved) { this.approved = approved; }

    public boolean isResolved() { return resolved; }
    public void setResolved(boolean resolved) { this.resolved = resolved; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public List<Answer> getAnswers() { return answers; }
    public void setAnswers(List<Answer> answers) { this.answers = answers; }

    // ======= Transient DTO Mapping =======

    @Transient
    public Long getUserId() {
        return user != null ? user.getId() : null;
    }
}
