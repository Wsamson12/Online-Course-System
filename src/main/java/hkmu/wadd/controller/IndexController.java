package hkmu.wadd.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.security.core.Authentication;

@Controller
public class IndexController {



    // @GetMapping("/")
    // public String index() {
    //     // Check if the user is already authenticated
    //     Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    //     if (authentication != null && authentication.isAuthenticated() && !authentication.getName().equals("anonymousUser")) {
    //         return "redirect:/guestbook"; // Redirect to guestbook if authenticated
    //     }

    //     return "index";
    // }

    // @GetMapping("/mainpage")
    // public String mainpage() {
    //     return "redirect:/guestbook";
    // }

    @GetMapping("/login")
    public String login(@RequestParam(value = "lang", defaultValue = "en") String lang) {
        if ("zh".equals(lang)) {
            return "login_zh";
        }
        return "login";
    }

    // @GetMapping("/register")
    // public String register() {
    //     return "register";
    // }
}