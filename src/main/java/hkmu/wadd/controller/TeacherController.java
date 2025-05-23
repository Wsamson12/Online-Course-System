package hkmu.wadd.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TeacherController {

    // @GetMapping("/teacher/dashboard")
    // public String teacherDashboard() {
    //     return "teacher/dashboard"; // Return the view name for the teacher dashboard
    // }

    @GetMapping("/teacher/dashboard")
    public String studentDashboard(Model model, @RequestParam(value = "lang", defaultValue = "en") String lang)  {
        // Get the authenticated user's details
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername(); // Extract username
        } else {
            username = principal.toString(); // Fallback
        }

        // Add the username to the model
        model.addAttribute("username", username);
        model.addAttribute("contextPath", "/hellospringsecurity"); // Add context path

        if ("zh".equals(lang)) {
            return "teacher/dashboard_zh";
        }
        return "teacher/dashboard";// Return the view name for the student dashboard
    }

    @GetMapping("/teacher/addUser")
    public String showAddUserForm(@RequestParam(value = "lang", defaultValue = "en") String lang) {
        // Return the JSP page for adding a user
        if ("zh".equals(lang)) {
            return "teacher/addUser_zh";
        }
        return "teacher/addUser";
    }

}
