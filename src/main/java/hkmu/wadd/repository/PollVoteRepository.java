package hkmu.wadd.repository;

import hkmu.wadd.model.PollVote;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PollVoteRepository extends JpaRepository<PollVote, Long> {
    PollVote findByPollIdAndUsername(Long pollId, String username);
}