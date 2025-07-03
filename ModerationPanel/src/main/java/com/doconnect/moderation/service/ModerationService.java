package com.doconnect.moderation.service;

import com.doconnect.moderation.dto.*;
import com.doconnect.moderation.entity.Admin;
import com.doconnect.moderation.entity.Answer;
import com.doconnect.moderation.entity.Question;
import com.doconnect.moderation.repository.AdminUserRepository;
import com.doconnect.moderation.repository.AnswerRepository;
import com.doconnect.moderation.repository.CommentRepository;
import com.doconnect.moderation.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
public class ModerationService {

    @Autowired
    private AdminUserRepository adminUserRepository;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private AnswerRepository answerRepository;

    @Autowired
    private CommentRepository commentRepository;

    // =============================
    // ✅ Admin Authentication
    // =============================

    public boolean authenticateAdmin(String username, String password) {
        Admin admin = adminUserRepository.findByUsername(username);
        return admin != null && admin.getPassword().equals(password);
    }

    public String registerAdmin(Admin admin) {
        if (adminUserRepository.findByEmail(admin.getEmail()) != null) {
            return "Email already exists";
        }
        adminUserRepository.save(admin);
        return null;
    }

    // =============================
    // ✅ User Management
    // =============================

    public List<UserDTO> getAllUsers() {
        try {
            ResponseEntity<UserDTO[]> response = restTemplate.getForEntity("http://localhost:8081/portal/users", UserDTO[].class);
            return Arrays.asList(Objects.requireNonNullElse(response.getBody(), new UserDTO[0]));
        } catch (RestClientException e) {
            System.err.println("❌ Error fetching users: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    public void deactivateUser(Long userId) {
        try {
            restTemplate.put("http://localhost:8081/portal/users/" + userId + "/deactivate", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error deactivating user: " + e.getMessage());
        }
    }

    public void activateUser(Long userId) {
        try {
            restTemplate.put("http://localhost:8081/portal/users/" + userId + "/activate", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error activating user: " + e.getMessage());
        }
    }

    // =============================
    // ✅ Question Management
    // =============================

    public List<QuestionDTO> getAllQuestions() {
        try {
            ResponseEntity<QuestionDTO[]> response = restTemplate.getForEntity("http://localhost:8081/portal/questions", QuestionDTO[].class);
            return Arrays.asList(Objects.requireNonNullElse(response.getBody(), new QuestionDTO[0]));
        } catch (RestClientException e) {
            System.err.println("❌ Error fetching questions: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    public QuestionDTO getQuestionById(Long id) {
        try {
            return restTemplate.getForObject("http://localhost:8081/portal/questions/" + id, QuestionDTO.class);
        } catch (Exception e) {
            System.err.println("❌ Error fetching question with ID: " + id + " - " + e.getMessage());
            return null;
        }
    }

    public List<Question> getApprovedQuestions() {
        return questionRepository.findByApprovedTrue();
    }

    public List<Question> getUnapprovedQuestions() {
        return questionRepository.findByApprovedFalse();
    }

    public List<Question> getResolvedQuestions() {
        return questionRepository.findByResolvedTrue();
    }

    public void approveQuestion(Long questionId) {
        try {
            restTemplate.put("http://localhost:8081/portal/questions/" + questionId + "/approve", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error approving question: " + e.getMessage());
        }
    }

    public void unapproveQuestion(Long questionId) {
        try {
            restTemplate.put("http://localhost:8081/portal/questions/" + questionId + "/unapprove", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error unapproving question: " + e.getMessage());
        }
    }

    public void resolveQuestion(Long questionId) {
        try {
            restTemplate.put("http://localhost:8081/portal/questions/" + questionId + "/resolve", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error resolving question: " + e.getMessage());
        }
    }

    public void deactivateQuestion(Long questionId) {
        try {
            restTemplate.put("http://localhost:8081/portal/questions/" + questionId + "/deactivate", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error deactivating question: " + e.getMessage());
        }
    }

    public void deleteQuestion(Long id) {
        try {
            restTemplate.postForLocation("http://localhost:8081/portal/questions/delete/" + id, null);
        } catch (Exception e) {
            System.err.println("❌ Error deleting question: " + e.getMessage());
        }
    }

    public void deleteAllAnswersForQuestion(Long questionId) {
        try {
            restTemplate.postForLocation("http://localhost:8081/portal/answers/delete/by-question/" + questionId, null);
        } catch (Exception e) {
            System.err.println("❌ Error deleting answers: " + e.getMessage());
        }
    }

    public void deleteAllCommentsForQuestion(Long questionId) {
        try {
            restTemplate.postForLocation("http://localhost:8081/portal/comments/delete/by-question/" + questionId, null);
        } catch (Exception e) {
            System.err.println("❌ Error deleting comments: " + e.getMessage());
        }
    }

    // =============================
    // ✅ Answer Management
    // =============================

    public List<AnswerDTO> getAllAnswers() {
        try {
            ResponseEntity<AnswerDTO[]> response = restTemplate.getForEntity("http://localhost:8081/portal/answers", AnswerDTO[].class);
            return Arrays.asList(Objects.requireNonNullElse(response.getBody(), new AnswerDTO[0]));
        } catch (RestClientException e) {
            System.err.println("❌ Error fetching answers: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    public List<Answer> getApprovedAnswers() {
        return answerRepository.findByApprovedTrue();
    }

    public List<Answer> getUnapprovedAnswers() {
        return answerRepository.findByApprovedFalse();
    }

    public void approveAnswer(Long answerId) {
        try {
            restTemplate.put("http://localhost:8081/portal/answers/" + answerId + "/approve", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error approving answer: " + e.getMessage());
        }
    }

    public void unapproveAnswer(Long answerId) {
        try {
            restTemplate.put("http://localhost:8081/portal/answers/" + answerId + "/unapprove", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error unapproving answer: " + e.getMessage());
        }
    }

    public void deleteAnswer(Long id) {
        try {
            restTemplate.postForLocation("http://localhost:8081/portal/answers/delete/" + id, null);
        } catch (Exception e) {
            System.err.println("❌ Error deleting answer: " + e.getMessage());
        }
    }

    // =============================
    // ✅ Comment Management
    // =============================

    public List<CommentDTO> getAllComments() {
        try {
            ResponseEntity<CommentDTO[]> response = restTemplate.getForEntity("http://localhost:8081/portal/comments", CommentDTO[].class);
            return Arrays.asList(Objects.requireNonNullElse(response.getBody(), new CommentDTO[0]));
        } catch (RestClientException e) {
            System.err.println("❌ Error fetching comments: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    public void approveComment(Long commentId) {
        try {
            restTemplate.put("http://localhost:8081/portal/comments/" + commentId + "/approve", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error approving comment: " + e.getMessage());
        }
    }

    public void unapproveComment(Long commentId) {
        try {
            restTemplate.put("http://localhost:8081/portal/comments/" + commentId + "/unapprove", null);
        } catch (RestClientException e) {
            System.err.println("❌ Error unapproving comment: " + e.getMessage());
        }
    }

    public void deleteComment(Long commentId) {
        try {
            restTemplate.postForLocation("http://localhost:8081/portal/comments/delete/" + commentId, null);
        } catch (Exception e) {
            System.err.println("❌ Error deleting comment: " + e.getMessage());
        }
    }
}
