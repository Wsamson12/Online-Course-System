package hkmu.wadd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/teacher")
public class DeleteController {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/deleteUser")
    public String deleteUser(@RequestParam("username") String username) {
        String deleteRoleSql = "DELETE FROM user_roles WHERE username = ?";
        jdbcTemplate.update(deleteRoleSql, username);
        String deleteUserSql = "DELETE FROM users WHERE username = ?";
        jdbcTemplate.update(deleteUserSql, username);
        return "redirect:/teacher/manage";
    }
}