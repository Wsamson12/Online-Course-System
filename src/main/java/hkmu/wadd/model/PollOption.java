package hkmu.wadd.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "poll_options")
public class PollOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "poll_id")
    private Poll poll;

    @Column(name = "option_text")
    private String optionText;

    private int votes;

    public PollOption() {}

    public PollOption(String optionText, Poll poll) {
        this.optionText = optionText;
        this.poll = poll;
        this.votes = 0;
    }
}