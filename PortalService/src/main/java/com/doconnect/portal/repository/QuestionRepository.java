package com.doconnect.portal.repository;

import com.doconnect.portal.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {

    List<Question> findByApprovedTrue();
    List<Question> findByApprovedFalse();
    
    // ✅ Search support
    List<Question> findByTitleContainingIgnoreCaseOrContentContainingIgnoreCase(String title, String content);

    // Optional if needed for resolved questions
    List<Question> findByResolvedTrue();
}
