package com.doconnect.moderation.entity;

import java.util.List;

import com.doconnect.moderation.dto.QuestionDTO;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

@Entity
@JsonIgnoreProperties({"answers"}) // Optional
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String content;
    private String topic;

    private boolean approved;
    private boolean resolved;
    private boolean active;

    @ManyToOne
    private User user;

    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Answer> answers;

    public Question() {}

    public Question(Long id, String title, String content, String topic, User user,
                    Boolean approved, Boolean active, Boolean resolved) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.topic = topic;
        this.user = user;
        this.approved = approved;
        this.active = active;
        this.resolved = resolved;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getTopic() { return topic; }
    public void setTopic(String topic) { this.topic = topic; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public boolean isApproved() { return approved; }
    public void setApproved(boolean approved) { this.approved = approved; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public boolean isResolved() { return resolved; }
    public void setResolved(boolean resolved) { this.resolved = resolved; }

    @Transient
    public Long getUserId() {
        return user != null ? user.getId() : null;
    }

    @Transient
    public String getPostedBy() {
        return user != null ? user.getUsername() : "Unknown";
    }

	public QuestionDTO getById(Long id2) {
		// TODO Auto-generated method stub
		return null;
	}

	public void delete(Long id2) {
		// TODO Auto-generated method stub
		
	}
}


