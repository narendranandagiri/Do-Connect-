package com.doconnect.portal.service;

import com.doconnect.portal.dto.*;
import com.doconnect.portal.entity.*;
import com.doconnect.portal.exception.QuestionNotFoundException;
import com.doconnect.portal.exception.UserNotFoundException;
import com.doconnect.portal.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PortalService {

    @Autowired private PortalRepository portalRepository;
    @Autowired private QuestionRepository questionRepository;
    @Autowired private AnswerRepository answerRepository;
    @Autowired private CommentRepository commentRepository;
    @Autowired private AppSettingRepository appSettingRepository;
    
    // ============================================================================
    // 🧍 USER AUTH
    // ============================================================================

    public boolean emailExists(String email) {
        return portalRepository.findByEmail(email).isPresent();
    }

    public User register(User user) {
        if (emailExists(user.getEmail())) {
            throw new IllegalArgumentException("This email is already registered.");
        }
        return portalRepository.save(user);
    }

    public User login(String username, String password) {
        User user = portalRepository.findByUsername(username)
                .orElseThrow(() -> new UserNotFoundException("User not found with username: " + username));
        if (!user.getPassword().equals(password)) {
            throw new UserNotFoundException("Invalid password");
        }
        return user;
    }

    // ============================================================================
    // ❓ QUESTION / ANSWER LOGIC
    // ============================================================================

    public Question askQuestion(Long userId, Question question) {
        User user = getUserById(userId);
        question.setUser(user);
        question.setApproved(false);
        return questionRepository.save(question);
    }

    public List<Question> searchQuestions(String query) {
        return questionRepository.findByTitleContainingIgnoreCaseOrContentContainingIgnoreCase(query, query);
    }

    public Answer answerQuestion(Long userId, Long questionId, Answer answer) {
        User user = getUserById(userId);
        Question question = getQuestionById(questionId);

        if (answer.getContent() == null || answer.getContent().trim().isEmpty()) {
            throw new IllegalArgumentException("Answer content cannot be empty.");
        }

        if (answer.getContent().length() > 1000) {
            throw new IllegalArgumentException("Answer is too long.");
        }

        answer.setUser(user);
        answer.setQuestion(question);
        answer.setApproved(false);
        return answerRepository.save(answer);
    }

    public Comment commentOnAnswer(Long userId, Long answerId, Comment comment) {
        // ✅ Check if admin has disabled commenting
        if (!isCommentingEnabled()) {
            throw new IllegalStateException("Commenting is currently disabled by the administrator.");
        }

        User user = getUserById(userId);
        Answer answer = getAnswerById(answerId);
        comment.setUser(user);
        comment.setAnswer(answer);
        comment.setApproved(false);
        return commentRepository.save(comment);
    }

    
    public Answer likeAnswer(Long answerId) {
        Answer answer = getAnswerById(answerId);
        answer.setLikes(answer.getLikes() + 1);
        return answerRepository.save(answer);
    }

    public Answer editAnswer(Long userId, Long answerId, String newContent) {
        Answer answer = getAnswerById(answerId);
        if (!answer.getUser().getId().equals(userId)) {
            throw new SecurityException("You can only edit your own answers.");
        }
        if (newContent == null || newContent.trim().isEmpty()) {
            throw new IllegalArgumentException("Answer content cannot be empty.");
        }
        answer.setContent(newContent);
        return answerRepository.save(answer);
    }

    // ============================================================================
    // 🧑‍💼 MODERATION SERVICES (RETURN DTOs)
    // ============================================================================

    public List<UserDTO> getAllUsers() {
        return portalRepository.findAll().stream().map(this::mapToUserDTO).toList();
    }

    public List<QuestionDTO> getApprovedQuestions() {
        return questionRepository.findByApprovedTrue().stream().map(this::mapToQuestionDTO).toList();
    }

    public List<QuestionDTO> getUnapprovedQuestions() {
        return questionRepository.findByApprovedFalse().stream().map(this::mapToQuestionDTO).toList();
    }

    public List<AnswerDTO> getApprovedAnswers() {
        return answerRepository.findByApprovedTrue().stream().map(this::mapToAnswerDTO).toList();
    }

    public List<AnswerDTO> getUnapprovedAnswers() {
        return answerRepository.findByApprovedFalse().stream().map(this::mapToAnswerDTO).toList();
    }

    public List<CommentDTO> getAllComments() {
        return commentRepository.findAll().stream().map(this::mapToCommentDTO).toList();
    }

    // ============================================================================
    // 🔧 MODERATION ACTIONS (APPROVE / UNAPPROVE / DEACTIVATE)
    // ============================================================================

    public void deactivateUser(Long userId) {
        User user = getUserById(userId);
        user.setActive(false);
        portalRepository.save(user);
    }

    public void activateUser(Long userId) {
        User user = getUserById(userId);
        user.setActive(true);
        portalRepository.save(user);
    }

    public void approveQuestion(Long id) {
        Question q = getQuestionById(id);
        q.setApproved(true);
        questionRepository.save(q);
    }

    public void unapproveQuestion(Long id) {
        Question q = getQuestionById(id);
        q.setApproved(false);
        questionRepository.save(q);
    }

    public void resolveQuestion(Long id) {
        Question q = getQuestionById(id);
        q.setResolved(true);
        questionRepository.save(q);
    }

    public void deactivateQuestion(Long id) {
        Question q = getQuestionById(id);
        q.setActive(false);
        questionRepository.save(q);
    }

    public void approveAnswer(Long id) {
        Answer a = getAnswerById(id);
        a.setApproved(true);
        answerRepository.save(a);
    }

    public void unapproveAnswer(Long id) {
        Answer a = getAnswerById(id);
        a.setApproved(false);
        answerRepository.save(a);
    }

    public void deactivateAnswer(Long id) {
        Answer a = getAnswerById(id);
        a.setActive(false);
        answerRepository.save(a);
    }

    public void approveComment(Long id) {
        Comment c = getCommentById(id);
        c.setApproved(true);
        commentRepository.save(c);
    }

    public void unapproveComment(Long id) {
        Comment c = getCommentById(id);
        c.setApproved(false);
        commentRepository.save(c);
    }

    public void deactivateComment(Long id) {
        Comment c = getCommentById(id);
        c.setActive(false);
        commentRepository.save(c);
    }
    public void deleteComment(Long id) {
        commentRepository.deleteById(id);
    }

    // ============================================================================
    // 🔎 GET BY ID HELPERS
    // ============================================================================

    public User getUserById(Long id) {
        return portalRepository.findById(id).orElseThrow(() -> new UserNotFoundException("User not found: " + id));
    }

    public Question getQuestionById(Long id) {
        return questionRepository.findById(id).orElseThrow(() -> new QuestionNotFoundException("Question not found: " + id));
    }

    public Answer getAnswerById(Long id) {
        return answerRepository.findById(id).orElseThrow(() -> new QuestionNotFoundException("Answer not found: " + id));
    }

    public Comment getCommentById(Long id) {
        return commentRepository.findById(id).orElseThrow(() -> new QuestionNotFoundException("Comment not found: " + id));
    }

    // ============================================================================
    // 🧰 MAPPING HELPERS (ENTITY → DTO)
    // ============================================================================

    private UserDTO mapToUserDTO(User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        dto.setActive(user.isActive());
        return dto;
    }

    private QuestionDTO mapToQuestionDTO(Question q) {
        QuestionDTO dto = new QuestionDTO();
        dto.setId(q.getId());
        dto.setTitle(q.getTitle());
        dto.setContent(q.getContent());
        dto.setTopic(q.getTopic());
        dto.setResolved(q.isResolved());
        dto.setApproved(q.isApproved());
        dto.setActive(q.isActive());

        // ✅ FIXED: Get user from entity and extract id + name
        if (q.getUser() != null) {
            dto.setUserId(q.getUser().getId());
            dto.setPostedBy(q.getUser().getUsername()); // or getName() based on your User entity
        }

        return dto;
    }


    private AnswerDTO mapToAnswerDTO(Answer a) {
        AnswerDTO dto = new AnswerDTO();
        dto.setContent(a.getContent());
        dto.setApproved(a.isApproved());
        dto.setQuestionId(a.getQuestionId());
        dto.setUserId(a.getUserId());
        return dto;
    }

    private CommentDTO mapToCommentDTO(Comment c) {
        CommentDTO dto = new CommentDTO();
        dto.setId(c.getId());
        dto.setContent(c.getContent());
        dto.setApproved(c.isApproved());
        dto.setCommentedBy(c.getUser().getUsername());
        return dto;
    }

    public List<QuestionDTO> getAllQuestions() {
        return questionRepository.findAll()
                .stream()
                .map(this::mapToQuestionDTO)
                .toList();
    }

    public List<AnswerDTO> getAllAnswers() {
        return answerRepository.findAll()
                .stream()
                .map(this::mapToAnswerDTO)
                .toList();
    }
    public List<CommentDTO> getUnapprovedComments() {
        return commentRepository.findByApprovedFalse()
                .stream()
                .map(this::mapToCommentDTO)
                .toList();
    }

public boolean isCommentingEnabled() {
    return Boolean.parseBoolean(
        appSettingRepository.findById("comments_enabled")
            .map(AppSetting::getValue)
            .orElse("true")
    );
}

public void setCommentingEnabled(boolean enabled) {
    appSettingRepository.save(new AppSetting("comments_enabled", String.valueOf(enabled)));
}



}
