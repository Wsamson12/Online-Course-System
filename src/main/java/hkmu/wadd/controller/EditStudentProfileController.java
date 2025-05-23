package hkmu.wadd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("/student")
public class EditStudentProfileController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/edit_profile")
    public String editProfile(Authentication authentication, Model model, @RequestParam(value = "lang", defaultValue = "en") String lang)  {
        System.out.println("Authorities: " + authentication.getAuthorities());
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_STUDENT"))) {
            System.out.println("User lacks ROLE_STUDENT, redirecting to profile");
            return "redirect:/student/profile";
        }

        String username = authentication.getName();
        String sql = "SELECT u.username, u.full_name, u.email, u.phone_number, ur.role " +
                "FROM users u LEFT JOIN user_roles ur ON u.username = ur.username " +
                "WHERE u.username = ?";
        Map<String, Object> user = jdbcTemplate.queryForMap(sql, username);

        model.addAttribute("user", new StudentProfileController.UserProfile(
                (String) user.get("username"),
                (String) user.get("full_name"),
                (String) user.get("email"),
                (String) user.get("phone_number"),
                (String) user.get("role")
        ));
        if ("zh".equals(lang)) {
            return "student/edit_profile_zh";
        }
        return "student/edit_profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam("originalUsername") String originalUsername, // Hidden field for original username
            @RequestParam("username") String username,
            @RequestParam("fullName") String fullName,
            @RequestParam("email") String email,
            @RequestParam("phoneNumber") String phoneNumber,
            @RequestParam(value = "password", required = false) String password, // New password field (optional)
            Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_STUDENT"))) {
            return "redirect:/student/profile";
        }

        // Update users table (including password if provided)
        if (password != null && !password.isEmpty()) {
            String updateUsersSqlWithPassword = "UPDATE users SET username = ?, full_name = ?, email = ?, phone_number = ?, password = ? WHERE username = ?";
            jdbcTemplate.update(updateUsersSqlWithPassword, username, fullName, email, phoneNumber, "{noop}" + password, originalUsername);
        } else {
            String updateUsersSql = "UPDATE users SET username = ?, full_name = ?, email = ?, phone_number = ? WHERE username = ?";
            jdbcTemplate.update(updateUsersSql, username, fullName, email, phoneNumber, originalUsername);
        }

        return "redirect:/student/profile";
    }
}