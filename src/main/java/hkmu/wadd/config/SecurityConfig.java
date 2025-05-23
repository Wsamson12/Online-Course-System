package hkmu.wadd.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import javax.sql.DataSource;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Autowired
    private DataSource dataSource;

    @Bean
    public UserDetailsService jdbcUserDetailsService() {
        String usersByUsernameQuery
                = "SELECT username, password, true FROM users WHERE username=?";
        String authsByUsernameQuery
                = "SELECT username, role FROM user_roles WHERE username=?";
        JdbcUserDetailsManager users = new JdbcUserDetailsManager(dataSource);
        users.setUsersByUsernameQuery(usersByUsernameQuery);
        users.setAuthoritiesByUsernameQuery(authsByUsernameQuery);
        return users;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http)
            throws Exception {
                http
                .authorizeHttpRequests(authorize -> authorize
                    .requestMatchers("/register", "/login").permitAll()
                    .requestMatchers("/teacher/**").hasRole("TEACHER")
                    .requestMatchers("/student/**").hasRole("STUDENT")
                    .requestMatchers("/polls/**").authenticated()
                        .requestMatchers("/teacher/addcourse").hasRole("TEACHER")
                    .anyRequest().permitAll()
                )
                .formLogin(form -> form
                    .loginPage("/login") // Render login page
                    .defaultSuccessUrl("/default", true) // Redirect to role-based handler
                    .failureUrl("/login?error")
                    .usernameParameter("username")
                    .passwordParameter("password")
                    .permitAll()
                )
                .logout(logout -> logout
                    .logoutUrl("/logout")
                    // .logoutSuccessUrl("/HelloSpringSecurity/login?logout") // Redirect to login page after logout
                    .logoutSuccessUrl("/login?logout") // Redirect to login page after logout
                    .invalidateHttpSession(true)
                    .deleteCookies("JSESSIONID")
                )
                .rememberMe(remember -> remember
                        .key("uniqueAndSecret")
                        .tokenValiditySeconds(86400)
                        .rememberMeParameter("remember-me")
                )
                .httpBasic(withDefaults())
                .csrf(csrf -> csrf.disable()); // Disable CSRF protection


        return http.build();
    }
}