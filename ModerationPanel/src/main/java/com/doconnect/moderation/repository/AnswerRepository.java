package com.doconnect.moderation.repository;

import com.doconnect.moderation.entity.Answer;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AnswerRepository extends JpaRepository<Answer, Long> {
    List<Answer> findByApprovedTrue();
    List<Answer> findByApprovedFalse();
    }