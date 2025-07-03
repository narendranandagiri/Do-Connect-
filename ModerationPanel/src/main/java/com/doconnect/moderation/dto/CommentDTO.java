package com.doconnect.moderation.dto;

public class CommentDTO {
    private Long id;
    private String content;
    private String commentedBy;
    private boolean approved;

    // Getters and Setters
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public String getCommentedBy() {
        return commentedBy;
    }
    public void setCommentedBy(String commentedBy) {
        this.commentedBy = commentedBy;
    }

    public boolean isApproved() {
        return approved;
    }
    public void setApproved(boolean approved) {
        this.approved = approved;
    }
}
