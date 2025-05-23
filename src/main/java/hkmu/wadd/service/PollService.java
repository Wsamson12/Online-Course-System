package hkmu.wadd.service;

import hkmu.wadd.model.Lecture;
import hkmu.wadd.model.Poll;
import hkmu.wadd.model.PollOption;
import hkmu.wadd.repository.LectureRepository;
import hkmu.wadd.repository.PollRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import jakarta.transaction.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class PollService {

    private static final Logger logger = LoggerFactory.getLogger(PollService.class);

    @Autowired
    private PollRepository pollRepository;

    @Autowired
    private LectureRepository lectureRepository;

    @PostConstruct
    @Transactional
    public void init() {
        try {
            logger.info("Initializing hardcoded poll");

            // Ensure a lecture exists
            Lecture lecture = new Lecture();
            lecture.setTitle("Test Lecture");
            lecture.setNotesUrl("http://example.com/notes.pdf");
            lectureRepository.save(lecture);
            logger.info("Lecture saved with ID: {}", lecture.getId());

            // Create poll and link to lecture
            Poll poll = new Poll("Which date do you prefer for the mid-term test?");
            poll.setLectureId(lecture.getId());
            List<PollOption> options = new ArrayList<>();
            options.add(new PollOption("3/3", poll));
            options.add(new PollOption("5/3", poll));
            options.add(new PollOption("7/3", poll));
            options.add(new PollOption("9/3", poll));
            poll.setOptions(options);
            pollRepository.save(poll);
            logger.info("Poll saved with ID: {}", poll.getId());
        } catch (Exception e) {
            logger.error("Failed to initialize poll: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to initialize poll", e);
        }
    }

    public Poll getPoll(Long id) {
        return pollRepository.findById(id).orElse(null);
    }

    public List<Poll> getAllPolls() {
        return pollRepository.findAll();
    }
}