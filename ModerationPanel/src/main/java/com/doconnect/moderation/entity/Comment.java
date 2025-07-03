package com.doconnect.moderation.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;

@Entity
@JsonIgnoreProperties({"user", "question", "answer"})
public class Comment {

    @Id
    private Long id;

    private String content;

    @ManyToOne
    private User user;

    @ManyToOne
    private Question question;

    @ManyToOne
    private Answer answer;

    private Boolean active;
    private Boolean approved = false;

    public Comment() {}

    public Comment(Long id, String content, User user, Question question, Answer answer, Boolean active) {
        this.id = id;
        this.content = content;
        this.user = user;
        this.question = question;
        this.answer = answer;
        this.active = active;
        this.approved = false;
    }

    // Getters and Setters

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Question getQuestion() { return question; }
    public void setQuestion(Question question) { this.question = question; }

    public Answer getAnswer() { return answer; }
    public void setAnswer(Answer answer) { this.answer = answer; }

    public Boolean isActive() { return active; }
    public void setActive(Boolean active) { this.active = active; }

    public Boolean isApproved() { return approved; }
    public void setApproved(Boolean approved) { this.approved = approved; }

    @Transient
    public Long getUserId() {
        return user != null ? user.getId() : null;
    }

    @Transient
    public Long getQuestionId() {
        return question != null ? question.getId() : null;
    }

    @Transient
    public Long getAnswerId() {
        return answer != null ? answer.getId() : null;
    }

    @Transient
    public String getCommentedBy() {
        return user != null ? user.getUsername() : "Anonymous";
    }

	public void deleteAllCommentsForQuestion(Long id2) {
		// TODO Auto-generated method stub
		
	}
}
