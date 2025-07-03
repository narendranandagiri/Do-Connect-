package com.doconnect.moderation.controller;

import com.doconnect.moderation.dto.QuestionDTO;
import com.doconnect.moderation.entity.Admin;
import com.doconnect.moderation.service.ModerationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/moderation")
public class ModerationController {

    @Autowired
    private ModerationService moderationService;

    // 🔒 Track deleted questions (optional history)
    private List<QuestionDTO> deletedQuestions = new ArrayList<>();

    // ================================
    // 🔐 Admin Login & Registration
    // ================================
    @GetMapping("/login")
    public String showLoginPage() {
        return "adminlogin";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        if (moderationService.authenticateAdmin(username, password)) {
            session.setAttribute("moderator", username);
            return "redirect:/moderation/dashboard";
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "adminlogin";
        }
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "adminregister";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String confirmPassword,
                           @RequestParam String email,
                           Model model) {

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            return "adminregister";
        }

        Admin admin = new Admin(username, password, email);
        String error = moderationService.registerAdmin(admin);

        if (error != null) {
            model.addAttribute("error", error);
            return "adminregister";
        }

        model.addAttribute("message", "Registration successful. Please login.");
        return "redirect:/moderation/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/moderation/login";
    }

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session) {
        if (session.getAttribute("moderator") == null) {
            return "redirect:/moderation/login";
        }
        return "admindashboard";
    }

    // ================================
    // 👥 User Management
    // ================================
    @GetMapping("/users")
    public String showUsers(Model model) {
        model.addAttribute("users", moderationService.getAllUsers());
        return "manageusers";
    }

    @PostMapping("/users/deactivate/{id}")
    public String deactivateUser(@PathVariable Long id) {
        moderationService.deactivateUser(id);
        return "redirect:/moderation/users";
    }

    @PostMapping("/users/activate/{id}")
    public String activateUser(@PathVariable Long id) {
        moderationService.activateUser(id);
        return "redirect:/moderation/users";
    }

    // ================================
    // ❓ Question Management
    // ================================
    @GetMapping("/questions")
    public String manageQuestions(Model model, HttpSession session) {
        if (session.getAttribute("moderator") == null) {
            return "redirect:/moderation/login";
        }
        model.addAttribute("approvedQuestions", moderationService.getApprovedQuestions());
        model.addAttribute("unapprovedQuestions", moderationService.getUnapprovedQuestions());
        model.addAttribute("resolvedQuestions", moderationService.getResolvedQuestions());
        return "managequestions";
    }

    @PostMapping("/questions/approve/{id}")
    public String approveQuestion(@PathVariable Long id) {
        moderationService.approveQuestion(id);
        return "redirect:/moderation/questions";
    }

    @PostMapping("/questions/unapprove/{id}")
    public String unapproveQuestion(@PathVariable Long id) {
        moderationService.unapproveQuestion(id);
        return "redirect:/moderation/questions";
    }

    @PostMapping("/questions/resolve/{id}")
    public String resolveQuestion(@PathVariable Long id) {
        moderationService.resolveQuestion(id);
        return "redirect:/moderation/questions";
    }

    @PostMapping("/questions/deactivate/{id}")
    public String deactivateQuestion(@PathVariable Long id) {
        moderationService.deactivateQuestion(id);
        return "redirect:/moderation/questions";
    }

    @PostMapping("/questions/delete/{id}")
    public String deleteQuestion(@PathVariable Long id) {
        QuestionDTO question = moderationService.getQuestionById(id);
        moderationService.deleteAllAnswersForQuestion(id);
        moderationService.deleteAllCommentsForQuestion(id);
        moderationService.deleteQuestion(id);
        deletedQuestions.add(question); // Save in deleted archive
        return "redirect:/moderation/questions";
    }

    // ================================
    // 💬 Answer Management
    // ================================
    @GetMapping("/answers")
    public String manageAnswers(Model model, HttpSession session) {
        if (session.getAttribute("moderator") == null) {
            return "redirect:/moderation/login";
        }
        model.addAttribute("approvedAnswers", moderationService.getApprovedAnswers());
        model.addAttribute("unapprovedAnswers", moderationService.getUnapprovedAnswers());
        return "manageanswers";
    }

    @PostMapping("/answers/approve/{id}")
    public String approveAnswer(@PathVariable Long id) {
        moderationService.approveAnswer(id);
        return "redirect:/moderation/answers";
    }

    @PostMapping("/answers/unapprove/{id}")
    public String unapproveAnswer(@PathVariable Long id) {
        moderationService.unapproveAnswer(id);
        return "redirect:/moderation/answers";
    }

    @PostMapping("/answers/delete/{id}")
    public String deleteAnswer(@PathVariable Long id) {
        moderationService.deleteAnswer(id);
        return "redirect:/moderation/answers";
    }

    // ================================
    // 💭 Comment Management
    // ================================
    @GetMapping("/comments")
    public String manageComments(Model model, HttpSession session) {
        if (session.getAttribute("moderator") == null) {
            return "redirect:/moderation/login";
        }

        model.addAttribute("approvedComments", moderationService.getAllComments().stream()
            .filter(comment -> comment.isApproved()).toList());

        model.addAttribute("unapprovedComments", moderationService.getAllComments().stream()
            .filter(comment -> !comment.isApproved()).toList());

        return "managecomments";
    }

    @PostMapping("/comments/approve/{id}")
    public String approveComment(@PathVariable Long id) {
        moderationService.approveComment(id);
        return "redirect:/moderation/comments";
    }

    @PostMapping("/comments/unapprove/{id}")
    public String unapproveComment(@PathVariable Long id) {
        moderationService.unapproveComment(id);
        return "redirect:/moderation/comments";
    }

    @PostMapping("/comments/delete/{id}")
    public String deleteComment(@PathVariable Long id) {
        moderationService.deleteComment(id);
        return "redirect:/moderation/comments";
    }
}
