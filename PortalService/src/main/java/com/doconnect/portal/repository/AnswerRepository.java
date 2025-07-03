package com.doconnect.portal.repository;

import com.doconnect.portal.entity.Answer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnswerRepository extends JpaRepository<Answer, Long> {

    List<Answer> findByApprovedTrue();     // For admin view
    List<Answer> findByApprovedFalse();    // For moderation queue

    List<Answer> findByQuestion_Id(Long questionId); // ✅ Corrected
}
