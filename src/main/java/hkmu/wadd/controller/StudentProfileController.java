package hkmu.wadd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("/student")
public class StudentProfileController {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/profile")
    public String showProfile(Authentication authentication, Model model, @RequestParam(value = "lang", defaultValue = "en") String lang) {
        String username = authentication.getName();
        String sql = "SELECT u.username, u.full_name, u.email, u.phone_number, ur.role " +
                "FROM users u LEFT JOIN user_roles ur ON u.username = ur.username " +
                "WHERE u.username = ?";
        Map<String, Object> user = jdbcTemplate.queryForMap(sql, username);

        model.addAttribute("user", new UserProfile(
                (String) user.get("username"),
                (String) user.get("full_name"),
                (String) user.get("email"),
                (String) user.get("phone_number"),
                (String) user.get("role")
        ));

        // Return the appropriate view based on language
        if ("zh".equals(lang)) {
            return "student/profile_zh";
        }
        return "student/profile";

    }

    @GetMapping("/student/dashboard")
    public String showDashboard(Authentication authentication, Model model) {
        model.addAttribute("username", authentication.getName());
        return "student/dashboard";
    }

    public static class UserProfile {
        private String username;
        private String fullName;
        private String email;
        private String phoneNumber;
        private String role;

        public UserProfile(String username, String fullName, String email, String phoneNumber, String role) {
            this.username = username;
            this.fullName = fullName;
            this.email = email;
            this.phoneNumber = phoneNumber;
            this.role = role;
        }

        public String getUsername() { return username; }
        public String getFullName() { return fullName; }
        public String getEmail() { return email; }
        public String getPhoneNumber() { return phoneNumber; }
        public String getRole() { return role; }
    }
}