package hkmu.wadd.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "poll_votes")
public class PollVote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "poll_id")
    private Poll poll;

    @Column(name = "username")
    private String username;

    @ManyToOne
    @JoinColumn(name = "option_id")
    private PollOption option;

    public PollVote() {}
}