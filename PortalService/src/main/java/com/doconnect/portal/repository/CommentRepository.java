package com.doconnect.portal.repository;

import com.doconnect.portal.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    // Optional but helpful if you want filtered comment views
    List<Comment> findByApprovedTrue();
    List<Comment> findByApprovedFalse();
	List<Comment> findByQuestionId(Long questionId);
}
