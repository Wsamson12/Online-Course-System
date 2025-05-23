package hkmu.wadd.controller;

// Removed incorrect logger import
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class LoginController {
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    // @GetMapping("/default")
    // public String redirectAfterLogin() {
    //     // Get the authenticated user's roles
    //     Collection<? extends GrantedAuthority> authorities =
    //             SecurityContextHolder.getContext().getAuthentication().getAuthorities();

    //     // Check roles and redirect accordingly
    //     for (GrantedAuthority authority : authorities) {
    //         if (authority.getAuthority().equals("ROLE_TEACHER")) {
    //             return "redirect:/teacher/dashboard"; // Redirect to teacher page
    //         } else if (authority.getAuthority().equals("ROLE_STUDENT")) {
    //             return "redirect:/student/dashboard"; // Redirect to student page
    //         }
    //     }

    //     // Default fallback (shouldn't happen if roles are properly assigned)
    //     return "redirect:/";
    // }


    @GetMapping("/default")
    public String redirectAfterLogin() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();
    
        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            logger.info("Logged in user: {}", userDetails.getUsername());
            // Avoid logging password in production
            logger.info("Stored password: {}", userDetails.getPassword());
    
            for (GrantedAuthority authority : authentication.getAuthorities()) {
                logger.info("Role: {}", authority.getAuthority());
                if (authority.getAuthority().equals("ROLE_TEACHER")) {
                    logger.info("Redirecting {} to teacher dashboard", authentication.getName());

                    return "redirect:/teacher/dashboard";
                } else if (authority.getAuthority().equals("ROLE_STUDENT")) {
                    logger.info("Redirecting {} to student dashboard", authentication.getName());

                    return "redirect:/student/dashboard";
                }
            }
        } else {
            logger.warn("Principal is not UserDetails: {}", principal);
        }
        return "redirect:/"; // Default redirect if no specific role matches
    }






}