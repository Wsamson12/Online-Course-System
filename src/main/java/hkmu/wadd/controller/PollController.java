package hkmu.wadd.controller;

import hkmu.wadd.model.*;
import hkmu.wadd.repository.PollOptionRepository;
import hkmu.wadd.repository.PollVoteRepository;
import hkmu.wadd.service.CommentService;
import hkmu.wadd.service.PollService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/polls")
public class PollController {

    private static final Logger logger = LoggerFactory.getLogger(PollController.class);

    @Autowired
    private PollService pollService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private PollVoteRepository pollVoteRepository;

    @Autowired
    private PollOptionRepository pollOptionRepository;

    @GetMapping("/{id}")
    public String showPoll(@PathVariable Long id, Model model) {
        logger.info("Showing poll with ID {}", id);

        if (SecurityContextHolder.getContext().getAuthentication() == null) {
            logger.error("User is not authenticated");
            return "redirect:/login";
        }
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        if (username == null || username.equals("anonymousUser")) {
            logger.error("User is not logged in: username={}", username);
            return "redirect:/login";
        }

        Poll poll = pollService.getPoll(id);
        if (poll == null) {
            logger.error("Poll with ID {} not found", id);
            model.addAttribute("pollId", id);
            return "error";
        }

        PollVote userVote = pollVoteRepository.findByPollIdAndUsername(id, username);
        boolean hasVoted = userVote != null;

        List<Comment> comments = commentService.getAllComments();
        model.addAttribute("poll", poll);
        model.addAttribute("comments", comments); // Updated to "comments"
        model.addAttribute("userVote", userVote != null ? userVote.getOption().getOptionText() : null);
        model.addAttribute("hasVoted", hasVoted);
        return "poll";
    }

    @PostMapping("/{id}/submitVote")
    public String submitVote(@PathVariable Long id, @RequestParam("midterm_date") String selectedDate) {
        logger.info("Submitting vote for poll ID {}: selectedDate={}", id, selectedDate);

        if (SecurityContextHolder.getContext().getAuthentication() == null) {
            logger.error("User is not authenticated");
            return "redirect:/login";
        }
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        if (username == null || username.equals("anonymousUser")) {
            logger.error("User is not logged in: username={}", username);
            return "redirect:/login";
        }

        Poll poll = pollService.getPoll(id);
        if (poll == null) {
            logger.error("Poll with ID {} not found", id);
            return "error";
        }

        PollVote existingVote = pollVoteRepository.findByPollIdAndUsername(id, username);
        if (existingVote != null) {
            logger.warn("User {} has already voted for poll ID {}", username, id);
            return "redirect:/polls/" + id;
        }

        PollOption selectedOption = poll.getOptions().stream()
                .filter(opt -> opt.getOptionText().equals(selectedDate))
                .findFirst()
                .orElse(null);
        if (selectedOption == null) {
            logger.error("Selected option {} not found for poll ID {}", selectedDate, id);
            return "error";
        }

        PollVote vote = new PollVote();
        vote.setPoll(poll);
        vote.setUsername(username);
        vote.setOption(selectedOption);
        pollVoteRepository.save(vote);

        selectedOption.setVotes(selectedOption.getVotes() + 1);
        pollOptionRepository.save(selectedOption);

        return "redirect:/polls/" + id;
    }

    @PostMapping("/{id}/editVote")
    public String editVote(@PathVariable Long id) {
        logger.info("Editing vote for poll ID {}", id);

        if (SecurityContextHolder.getContext().getAuthentication() == null) {
            logger.error("User is not authenticated");
            return "redirect:/login";
        }
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        if (username == null || username.equals("anonymousUser")) {
            logger.error("User is not logged in: username={}", username);
            return "redirect:/login";
        }

        PollVote existingVote = pollVoteRepository.findByPollIdAndUsername(id, username);
        if (existingVote == null) {
            logger.warn("No vote found for user {} in poll ID {}", username, id);
            return "redirect:/polls/" + id;
        }

        PollOption oldOption = existingVote.getOption();
        if (oldOption != null) {
            oldOption.setVotes(oldOption.getVotes() - 1);
            pollOptionRepository.save(oldOption);
        }

        pollVoteRepository.delete(existingVote);

        return "redirect:/polls/" + id;
    }


    @PostMapping("/{id}/submitComment")
    public String submitComment(@PathVariable Long id, @RequestParam("comment") String commentText, Model model) {
        logger.info("Submitting comment for poll ID {}: commentText={}", id, commentText);

        if (SecurityContextHolder.getContext().getAuthentication() == null) {
            logger.error("User is not authenticated");
            return "redirect:/login";
        }
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        if (username == null || username.equals("anonymousUser")) {
            logger.error("User is not logged in: username={}", username);
            return "redirect:/login";
        }

        Poll poll = pollService.getPoll(id);
        if (poll == null) {
            logger.error("Poll with ID {} not found", id);
            model.addAttribute("pollId", id);
            return "error";
        }

        try {
            Comment comment = new Comment();
            comment.setContent(commentText);
            comment.setUsername(username);
            comment.setLectureId(poll.getLectureId());
            commentService.addComment(comment);
            logger.info("Comment saved successfully for poll ID {}", id);
        } catch (Exception e) {
            logger.error("Error saving comment for poll ID {}: {}", id, e.getMessage(), e);
            model.addAttribute("pollId", id);
            return "error";
        }

        return "redirect:/polls/" + id;
    }
}