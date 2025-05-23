package hkmu.wadd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import hkmu.wadd.model.User;
import hkmu.wadd.service.UserService;
import jakarta.servlet.http.HttpServletRequest;


@Controller
public class RegisterController {

    
    
    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, @RequestParam("role") String role,  HttpServletRequest request) {
        userService.registerUser(user, role);

 // Print user details to the terminal
 System.out.println("Registering user: " + user.getUsername());
 System.out.println("Full Name: " + user.getFullName());
 System.out.println("Email: " + user.getEmail());
 System.out.println("Phone Number: " + user.getPhoneNumber());
 System.out.println("Role: " + role);
 System.out.println("Password: " + user.getPassword()); // Do not print the actual password for security reasons





        return "redirect:/login";
    }
}
