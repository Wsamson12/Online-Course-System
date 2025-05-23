package hkmu.wadd.service;

import hkmu.wadd.model.S265Fcomment;
import hkmu.wadd.model.User;
import hkmu.wadd.repository.S265FCommentRepository;
import hkmu.wadd.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import java.util.List;

@Service
public class S265FCommentService {

    private static final Logger logger = LoggerFactory.getLogger(S265FCommentService.class);

    @Autowired
    private S265FCommentRepository s265FCommentRepository;

    // Save a new comment
    @Transactional
    public void save(S265Fcomment comment) {
        s265FCommentRepository.save(comment);
        logger.info("Comment saved for user: {}", comment.getUsername());
    }

    // Retrieve all comments
    public List<S265Fcomment> findAll() {
        return s265FCommentRepository.findAll();
    }

    @Transactional
public void deleteComment(Long commentId) {
    s265FCommentRepository.deleteById(commentId);
    logger.info("Deleted comment with id: {}", commentId);
}
}