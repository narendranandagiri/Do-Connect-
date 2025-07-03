package com.doconnect.portal.controller;

import com.doconnect.portal.dto.*;
import com.doconnect.portal.entity.*;
import com.doconnect.portal.repository.AnswerRepository;
import com.doconnect.portal.repository.CommentRepository;
import com.doconnect.portal.repository.QuestionRepository;
import com.doconnect.portal.service.PortalService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/portal")
public class PortalController {

    @Autowired
    private PortalService portalService;
    
    @Autowired
    private AnswerRepository answerRepository;

    @Autowired
    private QuestionRepository questionRepository;
   
    @Autowired
    
    private CommentRepository commentRepository;
    // ============================================================================
    // 👥 USER AUTHENTICATION & REGISTRATION
    // ============================================================================

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "portal-signup";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String confirmPassword,
                           Model model) {

        // ✅ Check if passwords match
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "portal-signup";
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);  // ⚠️ No encryption used

        try {
            portalService.register(user);
            return "redirect:/portal/login";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("username", username);
            model.addAttribute("email", email);
            return "portal-signup";
        }
    }


    @GetMapping("/login")
    public String showLoginForm() {
        return "portal-signin";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, Model model, HttpSession session) {
        try {
            User user = portalService.login(username, password);
            session.setAttribute("portalUser", user);
            model.addAttribute("user", user);
            return "redirect:/portal/userDashboard/" + user.getId();
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "portal-signin";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/portal/login";
    }

    // ============================================================================
    // 👤 USER DASHBOARD
    // ============================================================================

    @GetMapping("/userDashboard/{userId}")
    public String showDashboard(@PathVariable Long userId, Model model, HttpSession session) {
        User portalUser = (User) session.getAttribute("portalUser");
        if (portalUser == null || !portalUser.getId().equals(userId)) {
            return "redirect:/portal/login";
        }
        User user = portalService.getUserById(userId);
        model.addAttribute("user", user);
        return "portal-home";
    }

    // ============================================================================
    // ❓ USER QUESTIONS & ANSWERS
    // ============================================================================

    @GetMapping("/{userId}/questions/ask")
    public String showAskQuestionForm(@PathVariable Long userId, Model model, HttpSession session) {
        if (!isValidSession(userId, session)) return "redirect:/portal/login";
        model.addAttribute("userId", userId);
        model.addAttribute("question", new Question());
        return "ask-question";
    }

    @PostMapping("/{userId}/questions")
    public String askQuestion(@PathVariable Long userId, @ModelAttribute Question question, HttpSession session) {
        if (!isValidSession(userId, session)) return "redirect:/portal/login";
        portalService.askQuestion(userId, question);
        return "redirect:/portal/userDashboard/" + userId;
    }

    @GetMapping("/questionSearch")
    public String searchQuestions(@RequestParam(value = "query", required = false) String query, Model model, HttpSession session) {
        if (!isUserLoggedIn(session)) return "redirect:/portal/login";
        List<Question> questions = (query != null && !query.trim().isEmpty()) ?
                portalService.searchQuestions(query) : List.of();
        model.addAttribute("questions", questions);
        model.addAttribute("query", query);
        model.addAttribute("user", session.getAttribute("portalUser"));
        return "questionSearchResults";
    }

    @GetMapping("/questions/{questionId}")
    public String showQuestionDetails(@PathVariable Long questionId, Model model, HttpSession session) {
        if (!isUserLoggedIn(session)) return "redirect:/portal/login";
        model.addAttribute("question", portalService.getQuestionById(questionId));
        model.addAttribute("answer", new Answer());
        model.addAttribute("user", session.getAttribute("portalUser"));
        
        model.addAttribute("commentsEnabled", portalService.isCommentingEnabled());
// ✅ add this
        return "answer-thread";
    }
    @PostMapping("/answers/delete/by-question/{questionId}")
    public ResponseEntity<Void> deleteAnswersByQuestion(@PathVariable Long questionId) {
        List<Answer> answers = answerRepository.findByQuestion_Id(questionId);
        answers.forEach(a -> answerRepository.deleteById(a.getId()));
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{userId}/questions/{questionId}/answers")
    public String answerQuestion(@PathVariable Long userId, @PathVariable Long questionId,
                                 @ModelAttribute Answer answer, HttpSession session, Model model) {
        if (!isValidSession(userId, session)) return "redirect:/portal/login";
        try {
            portalService.answerQuestion(userId, questionId, answer);
            return "redirect:/portal/questions/" + questionId;
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("question", portalService.getQuestionById(questionId));
            model.addAttribute("answer", answer);
            model.addAttribute("user", session.getAttribute("portalUser"));
            return "answer-thread";
        }
    }

    @PostMapping("/answers/{answerId}/like")
    public String likeAnswer(@PathVariable Long answerId, @RequestParam Long questionId, HttpSession session) {
        if (!isUserLoggedIn(session)) return "redirect:/portal/login";
        portalService.likeAnswer(answerId);
        return "redirect:/portal/questions/" + questionId;
    }

    @GetMapping("/{userId}/answers/{answerId}/comments/add")
    public String showCommentForm(@PathVariable Long userId, @PathVariable Long answerId, Model model, HttpSession session) {
        if (!isValidSession(userId, session)) return "redirect:/portal/login";
        model.addAttribute("comment", new Comment());
        model.addAttribute("answerId", answerId);
        model.addAttribute("questionId", portalService.getAnswerById(answerId).getQuestion().getId());
        model.addAttribute("userId", userId);
        return "addComment";
    }

    @PostMapping("/{userId}/answers/{answerId}/comments")
    public String commentOnAnswer(@PathVariable Long userId,
                                  @PathVariable Long answerId,
                                  @ModelAttribute Comment comment,
                                  @RequestParam Long questionId,
                                  HttpSession session) {

        if (!isValidSession(userId, session)) return "redirect:/portal/login";

        // ✅ Use service method directly
        if (!portalService.isCommentingEnabled()) {
            return "redirect:/portal/questions/" + questionId + "?error=commentsDisabled";
        }

        if (comment.getContent() == null || comment.getContent().trim().isEmpty()) {
            return "redirect:/portal/" + userId + "/answers/" + answerId + "/comments/add?questionId=" + questionId;
        }

        portalService.commentOnAnswer(userId, answerId, comment);
        return "redirect:/portal/questions/" + questionId;
    }
    @GetMapping("/settings/comments/enabled")
    @ResponseBody
    public boolean isCommentingEnabled() {
        return portalService.isCommentingEnabled();
    }
    @CrossOrigin(origins = "*") // or restrict to "http://localhost:8082"
    @PutMapping("/settings/comments/enabled")
    public ResponseEntity<Void> updateCommentingEnabled(@RequestParam boolean enabled) {
        portalService.setCommentingEnabled(enabled);
        return ResponseEntity.ok().build();
    }


    @GetMapping("/questionList")
    public String showAllQuestions(Model model, HttpSession session) {
        if (!isUserLoggedIn(session)) return "redirect:/portal/login";
        model.addAttribute("questions", portalService.getAllQuestions());

        model.addAttribute("user", session.getAttribute("portalUser"));
        return "questions";
    }
   
    @PostMapping("/answers/delete/{id}")
    public ResponseEntity<Void> deleteAnswerById(@PathVariable Long id) {
        answerRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }



    // ============================================================================
    // 🧑‍💼 USER MODERATION APIs (used by admin)
    // ============================================================================

    @GetMapping("/users")
    @ResponseBody
    public List<UserDTO> getAllUsers() {
        return portalService.getAllUsers();
    }


    @PutMapping("/users/{id}/deactivate")
    public void deactivateUser(@PathVariable Long id) {
        portalService.deactivateUser(id);
    }

    @PutMapping("/users/{id}/activate")
    public void activateUser(@PathVariable Long id) {
        portalService.activateUser(id);
    }

    // ============================================================================
    // ❓ QUESTION MODERATION APIs
    // ============================================================================

    @GetMapping("/questions")
    @ResponseBody
    public List<QuestionDTO> getAllQuestions() {
        return portalService.getAllQuestions(); // Make sure this method exists in service
    }

    @GetMapping("/questions/approved")
    @ResponseBody
    public List<QuestionDTO> getApprovedQuestions() {
        return portalService.getApprovedQuestions();
    }

    @GetMapping("/questions/unapproved")
    @ResponseBody
    public List<QuestionDTO> getUnapprovedQuestions() {
        return portalService.getUnapprovedQuestions();
    }
    @PutMapping("/questions/{id}/approve")
    public void approveQuestion(@PathVariable Long id) {
        portalService.approveQuestion(id);
    }

    @PutMapping("/questions/{id}/unapprove")
    public void unapproveQuestion(@PathVariable Long id) {
        portalService.unapproveQuestion(id);
    }

    @PutMapping("/questions/{id}/deactivate")
    public void deactivateQuestion(@PathVariable Long id) {
        portalService.deactivateQuestion(id);
    }

    @PutMapping("/questions/{id}/resolve")
    public void resolveQuestion(@PathVariable Long id) {
        portalService.resolveQuestion(id);
    }  
    @PostMapping("/questions/delete/{id}")
    public ResponseEntity<Void> deleteQuestion(@PathVariable Long id) {
        questionRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }


    // ============================================================================
    // 💬 ANSWER MODERATION APIs
    // ============================================================================

    @GetMapping("/answers")
    @ResponseBody
    public List<AnswerDTO> getAllAnswers() {
        return portalService.getAllAnswers();
    }

    @GetMapping("/answers/approved")
    @ResponseBody
    public List<AnswerDTO> getApprovedAnswers() {
        return portalService.getApprovedAnswers();
    }


    @GetMapping("/answers/unapproved")
    @ResponseBody
    public List<AnswerDTO> getUnapprovedAnswers() {
        return portalService.getUnapprovedAnswers();
    }

    @PutMapping("/answers/{id}/approve")
    public void approveAnswer(@PathVariable Long id) {
        portalService.approveAnswer(id);
    }

    @PutMapping("/answers/{id}/unapprove")
    public void unapproveAnswer(@PathVariable Long id) {
        portalService.unapproveAnswer(id);
    }

    @PutMapping("/answers/{id}/deactivate")
    public void deactivateAnswer(@PathVariable Long id) {
        portalService.deactivateAnswer(id);
    }
    
    // ============================================================================
    // 💭 COMMENT MODERATION APIs
    // ============================================================================

    @GetMapping("/comments")
    @ResponseBody
    public List<CommentDTO> getAllComments() {
        return portalService.getAllComments();
    }

    @PutMapping("/comments/{id}/approve")
    public void approveComment(@PathVariable Long id) {
        portalService.approveComment(id);
    }

    @PutMapping("/comments/{id}/unapprove")
    public void unapproveComment(@PathVariable Long id) {
        portalService.unapproveComment(id);
    }

    @PutMapping("/comments/{id}/deactivate")
    public void deactivateComment(@PathVariable Long id) {
        portalService.deactivateComment(id);
    }
    @PostMapping("/comments/delete/by-question/{questionId}")
    public ResponseEntity<Void> deleteByQuestion(@PathVariable Long questionId) {
        List<Comment> comments = commentRepository.findByQuestionId(questionId);
        comments.forEach(c -> commentRepository.deleteById(c.getId()));
        return ResponseEntity.ok().build();
    }

     

    // ============================================================================
    // ✍️ ANSWER EDITING
    // ============================================================================

    @GetMapping("/{userId}/answers/{answerId}/edit")
    public String showEditAnswerForm(@PathVariable Long userId, @PathVariable Long answerId, Model model, HttpSession session) {
        if (!isValidSession(userId, session)) return "redirect:/portal/login";

        Answer answer = portalService.getAnswerById(answerId);
        if (!answer.getUser().getId().equals(userId)) {
            model.addAttribute("error", "You can only edit your own answers.");
            model.addAttribute("question", answer.getQuestion());
            return "answer-thread";
        }

        model.addAttribute("answer", answer);
        model.addAttribute("questionId", answer.getQuestion().getId());
        model.addAttribute("user", session.getAttribute("portalUser"));
        return "editAnswer";
    }

    @PostMapping("/{userId}/answers/{answerId}/edit")
    public String editAnswer(@PathVariable Long userId, @PathVariable Long answerId,
                             @RequestParam String content, HttpSession session, Model model) {
        if (!isValidSession(userId, session)) return "redirect:/portal/login";
        try {
            portalService.editAnswer(userId, answerId, content);
            return "redirect:/portal/questions/" + portalService.getAnswerById(answerId).getQuestion().getId();
        } catch (IllegalArgumentException | SecurityException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("answer", portalService.getAnswerById(answerId));
            model.addAttribute("questionId", portalService.getAnswerById(answerId).getQuestion().getId());
            model.addAttribute("user", session.getAttribute("portalUser"));
            return "editAnswer";
        }
    }

    // ============================================================================
    // 🔐 Session Utilities
    // ============================================================================

    private boolean isValidSession(Long userId, HttpSession session) {
        User user = (User) session.getAttribute("portalUser");
        return user != null && user.getId().equals(userId);
    }

    private boolean isUserLoggedIn(HttpSession session) {
        return session.getAttribute("portalUser") != null;
    }
}
