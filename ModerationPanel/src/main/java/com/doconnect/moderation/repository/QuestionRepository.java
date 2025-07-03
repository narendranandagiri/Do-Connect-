package com.doconnect.moderation.repository;

import com.doconnect.moderation.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {

    List<Question> findByApprovedTrue();     // ✅ Fixed
    List<Question> findByApprovedFalse();    // ✅ Fixed
    List<Question> findByResolvedTrue();     // ✅ Already Correct
}
