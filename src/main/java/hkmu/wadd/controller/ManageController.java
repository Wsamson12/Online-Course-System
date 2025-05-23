package hkmu.wadd.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/teacher")
public class ManageController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/manage")
    public String showManage(Authentication authentication, Model model, @RequestParam(value = "lang", defaultValue = "en") String lang) {
        System.out.println("Authorities: " + authentication.getAuthorities());
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_TEACHER"))) {
            System.out.println("User lacks ROLE_TEACHER, redirecting to manage");
            return "redirect:/teacher/manage";
        }

        String sql = "SELECT u.username, u.full_name, u.email, u.phone_number, ur.role " +
                "FROM users u LEFT JOIN user_roles ur ON u.username = ur.username";
        List<Map<String, Object>> users = jdbcTemplate.queryForList(sql);

        model.addAttribute("users", users);
        if ("zh".equals(lang)) {
            return "teacher/manage_zh";
        }
        return "teacher/manage";
    }

    @GetMapping("/editdata")
    public String showEditData(Authentication authentication, @RequestParam("username") String username,
                               Model model, HttpSession session, @RequestParam(value = "lang", defaultValue = "en") String lang) {
        System.out.println("Authorities: " + authentication.getAuthorities());
        if (!authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_TEACHER"))) {
            System.out.println("User lacks ROLE_TEACHER, redirecting to manage");
            return "redirect:/teacher/editdata";
        }

        String sql = "SELECT u.username, u.full_name, u.email, u.phone_number, ur.role " +
                "FROM users u LEFT JOIN user_roles ur ON u.username = ur.username " +
                "WHERE u.username = ?";
        Map<String, Object> user = jdbcTemplate.queryForMap(sql, username);

        model.addAttribute("user", user);
        session.setAttribute("editingUsername", username); // Store original username in session
        if ("zh".equals(lang)) {
            return "teacher/editdata_zh";
        }
        return "teacher/editdata";
    }

    @PostMapping("/editdata")
    public String updateUser(
            @RequestParam("username") String username,
            @RequestParam("full_name") String fullName,
            @RequestParam("email") String email,
            @RequestParam("phone_number") String phoneNumber,
            @RequestParam("role") String role,
            @RequestParam(value = "password", required = false) String password,
            Model model,
            HttpSession session) {
        String oldUsername = (String) session.getAttribute("editingUsername"); // Retrieve original username
        if (oldUsername == null) {
            throw new IllegalStateException("No username found in session");
        }

        try {
            System.out.println("Updating user from: " + oldUsername + " to: " + username +
                    " with full_name: " + fullName + ", email: " + email + ", phone_number: " + phoneNumber +
                    ", role: " + role + ", password: " + (password != null ? "provided" : "not provided"));

            // Check if the new username is already taken (if changed)
            if (!oldUsername.equals(username)) {
                String checkUsernameSql = "SELECT COUNT(*) FROM users WHERE username = ?";
                int usernameCount = jdbcTemplate.queryForObject(checkUsernameSql, Integer.class, username);
                if (usernameCount > 0) {
                    throw new Exception("Username '" + username + "' is already taken");
                }
            }

            // Step 1: Delete the old user_roles entry if it exists and username changes
            String checkRoleSql = "SELECT COUNT(*) FROM user_roles WHERE username = ?";
            int roleCount = jdbcTemplate.queryForObject(checkRoleSql, Integer.class, oldUsername);
            if (roleCount > 0 && !oldUsername.equals(username)) {
                String deleteRoleSql = "DELETE FROM user_roles WHERE username = ?";
                jdbcTemplate.update(deleteRoleSql, oldUsername);
            }

            // Step 2: Update the users table
            int rowsAffected;
            if (password != null && !password.isEmpty()) {
                String updateUserSql = "UPDATE users SET username = ?, full_name = ?, email = ?, phone_number = ?, password = ? WHERE username = ?";
                rowsAffected = jdbcTemplate.update(updateUserSql, username, fullName, email, phoneNumber, password, oldUsername);
            } else {
                String updateUserSql = "UPDATE users SET username = ?, full_name = ?, email = ?, phone_number = ? WHERE username = ?";
                rowsAffected = jdbcTemplate.update(updateUserSql, username, fullName, email, phoneNumber, oldUsername);
            }

            if (rowsAffected == 0) {
                throw new Exception("No user found with username: " + oldUsername);
            }

            // Step 3: Update or insert the role in user_roles
            if (roleCount > 0 && oldUsername.equals(username)) {
                // If username didn’t change, just update the role
                String updateRoleSql = "UPDATE user_roles SET role = ? WHERE username = ?";
                jdbcTemplate.update(updateRoleSql, role, username);
            } else {
                // If username changed or no role existed, insert a new role
                String insertRoleSql = "INSERT INTO user_roles (username, role) VALUES (?, ?)";
                jdbcTemplate.update(insertRoleSql, username, role);
            }

            System.out.println("User updated successfully: " + username);
            session.removeAttribute("editingUsername"); // Clean up session
            return "redirect:/teacher/manage";
        } catch (Exception e) {
            System.out.println("Error updating user: " + e.getMessage());
            model.addAttribute("error", "Error updating user: " + e.getMessage());
            String sql = "SELECT u.username, u.full_name, u.email, u.phone_number, ur.role " +
                    "FROM users u LEFT JOIN user_roles ur ON u.username = ur.username " +
                    "WHERE u.username = ?";
            try {
                Map<String, Object> user = jdbcTemplate.queryForMap(sql, oldUsername);
                model.addAttribute("user", user);
            } catch (Exception ex) {
                Map<String, Object> fallbackUser = Map.of(
                        "username", username,
                        "full_name", fullName,
                        "email", email,
                        "phone_number", phoneNumber,
                        "role", role
                );
                model.addAttribute("user", fallbackUser);
            }
            return "teacher/editdata";
        }
    }

    @PostMapping("/deleteUser")
    public String deleteUser(@RequestParam("username") String username) {
        String deleteRoleSql = "DELETE FROM user_roles WHERE username = ?";
        jdbcTemplate.update(deleteRoleSql, username);

        String deleteUserSql = "DELETE FROM users WHERE username = ?";
        jdbcTemplate.update(deleteUserSql, username);

        return "redirect:/teacher/manage";
    }

    @PostMapping("/addUser")
    public String addUser(@RequestParam("username") String username,
                          @RequestParam("fullName") String fullName,
                          @RequestParam("email") String email,
                          @RequestParam("phoneNumber") String phoneNumber,
                          @RequestParam("role") String role,
                          @RequestParam("password") String password) {
        try {
            // Prefix the password with {noop}
            String nooppassword = "{noop}" + password;

            // Insert the user into the `users` table
            String insertUserSql = "INSERT INTO users (username, full_name, email, phone_number, password) VALUES (?, ?, ?, ?, ?)";
            jdbcTemplate.update(insertUserSql, username, fullName, email, phoneNumber, nooppassword);

            // Insert the role into the `user_roles` table
            String insertRoleSql = "INSERT INTO user_roles (username, role) VALUES (?, ?)";
            jdbcTemplate.update(insertRoleSql, username, role);

            return "redirect:/teacher/manage";

        } catch (Exception e) {
            System.out.println("Error adding user: " + e.getMessage());
            return "redirect:/teacher/addUser?error=true";
        }
    }

}