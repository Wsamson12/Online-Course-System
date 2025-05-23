package hkmu.wadd.controller;

import hkmu.wadd.model.S265F;
import hkmu.wadd.model.S265Fcomment;
import hkmu.wadd.service.S265FCommentService;
import hkmu.wadd.service.S265FService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class S265_student_Controller {

    private static final Logger logger = LoggerFactory.getLogger(S265_student_Controller.class);

    @Autowired
    private S265FCommentService s265FCommentService;

    @Autowired
    private S265FService s265FService;

    @GetMapping("/student/S265F")
    public String showS265FPage(Model model, @RequestParam(value = "lang", defaultValue = "en") String lang) {
        logger.info("Accessed /student/S265F endpoint");
        List<S265F> files = s265FService.getAllFiles();
        model.addAttribute("files", files);

        // Fetch all comments and add to model
        List<S265Fcomment> comments = s265FCommentService.findAll();
        model.addAttribute("comments", comments);

        if ("zh".equals(lang)) {
            return "student/S265F_zh";
        }
        return "student/S265F";
    }

    @PostMapping("/student/S265F/CsubmitComment")
    public String submitComment(@RequestParam("comment") String content, Model model) {
        // Get the currently logged-in username
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = userDetails.getUsername();

        // Create a new comment
        S265Fcomment comment = new S265Fcomment();
        comment.setUsername(username);
        comment.setContent(content);

        // Save the comment to the database
        s265FCommentService.save(comment);

        // Redirect back to the S265F page to refresh comments
        return "redirect:/student/S265F";
    }
}