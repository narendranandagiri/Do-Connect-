package com.doconnect.moderation.repository;

import com.doconnect.moderation.entity.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    List<Comment> findByApprovedTrue();

    List<Comment> findByApprovedFalse(); // Optional but useful
    List<Comment> findByQuestion_Id(Long questionId);

}
