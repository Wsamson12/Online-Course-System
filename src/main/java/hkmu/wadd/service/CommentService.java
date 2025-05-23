package hkmu.wadd.service;

import hkmu.wadd.model.*;
import hkmu.wadd.repository.CommentRepository;
import hkmu.wadd.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct; // Use jakarta
import jakarta.transaction.Transactional; // Use jakarta

import java.util.List;

@Service
public class CommentService {

    private static final Logger logger = LoggerFactory.getLogger(CommentService.class);

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private UserRepository userRepository;

    @PostConstruct
    @Transactional
    public void init() {
        try {
            User user = new User();
            user.setUsername("user");
            user.setPassword("{noop}password");
            user.setFullName("Test User");
            user.setEmail("user@example.com");
            user.setPhoneNumber("1234567890");
            userRepository.save(user);
            logger.info("User saved: {}", user.getUsername());
        } catch (Exception e) {
            logger.error("Failed to initialize user: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to initialize user", e);
        }
    }

    public void addComment(Comment comment) {
        commentRepository.save(comment);
    }

    public List<Comment> getAllComments() {
        return commentRepository.findAll();
    }
}