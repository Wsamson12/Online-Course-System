package hkmu.wadd.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = "comments")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "lecture_id")
    private Long lectureId;

    @Column(name = "username")
    private String username;

    @Column(name = "content")
    private String content;

    public Comment() {}

    public Comment(String content) {
        this.content = content;
    }
}