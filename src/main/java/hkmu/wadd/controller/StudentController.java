package hkmu.wadd.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class StudentController {

    // @GetMapping("/student/dashboard")
    // public String studentDashboard(Model model) {
    //      // Add the username to the model
    //      model.addAttribute("username", username);
    //     return "student/dashboard"; // Return the view name for the student dashboard
    // }

    @GetMapping("/student/dashboard")
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

        // return "student/dashboard"; // Return the view name for the student dashboard
    
    // Return the appropriate view based on language
    if ("zh".equals(lang)) {
        return "student/dashboard_zh";
    }
    return "student/dashboard";
    }

    

}