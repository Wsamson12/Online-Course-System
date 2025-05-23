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
@RequestMapping("/teacher")
public class EditProfileController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/edit_profile")
    public String editProfile(Authentication authentication, Model model, @RequestParam(value = "lang", defaultValue = "en") String lang)  {
        System.out.println("Authorities: " + authentication.getAuthorities());
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_TEACHER"))) {
            System.out.println("User lacks ROLE_TEACHER, redirecting to profile");
            return "redirect:/teacher/profile";
        }

        String username = authentication.getName();
        String sql = "SELECT u.username, u.full_name, u.email, u.phone_number, ur.role " +
                "FROM users u LEFT JOIN user_roles ur ON u.username = ur.username " +
                "WHERE u.username = ?";
        Map<String, Object> user = jdbcTemplate.queryForMap(sql, username);

        model.addAttribute("user", new TeacherProfileController.UserProfile(
                (String) user.get("username"),
                (String) user.get("full_name"),
                (String) user.get("email"),
                (String) user.get("phone_number"),
                (String) user.get("role")
        ));
        if ("zh".equals(lang)) {
            return "teacher/edit_profile_zh";
        }
        return "teacher/edit_profile";    }

    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam("originalUsername") String originalUsername, // Hidden field for original username
            @RequestParam("username") String username,
            @RequestParam("fullName") String fullName,
            @RequestParam("email") String email,
            @RequestParam("phoneNumber") String phoneNumber,
            @RequestParam("role") String role,
            @RequestParam(value = "password", required = false) String password, // New password field (optional)
            Authentication authentication) {
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_TEACHER"))) {
            return "redirect:/teacher/profile";
        }

        // Update users table (including password if provided)
        if (password != null && !password.isEmpty()) {
            String updateUsersSqlWithPassword = "UPDATE users SET username = ?, full_name = ?, email = ?, phone_number = ?, password = ? WHERE username = ?";
            jdbcTemplate.update(updateUsersSqlWithPassword, username, fullName, email, phoneNumber, "{noop}" + password, originalUsername);
        } else {
            String updateUsersSql = "UPDATE users SET username = ?, full_name = ?, email = ?, phone_number = ? WHERE username = ?";
            jdbcTemplate.update(updateUsersSql, username, fullName, email, phoneNumber, originalUsername);
        }

        // Update user_roles table
        String updateRolesSql = "UPDATE user_roles SET username = ?, role = ? WHERE username = ?";
        jdbcTemplate.update(updateRolesSql, username, role, originalUsername);

        return "redirect:/teacher/profile";
    }
}