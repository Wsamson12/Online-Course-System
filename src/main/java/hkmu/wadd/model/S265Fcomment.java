package hkmu.wadd.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name = " S265Fcomments")
public class S265Fcomment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;



    @Column(name = "username")
    private String username;

    @Column(name = "content")
    private String content;

    public S265Fcomment() {}

    public S265Fcomment(String content) {
        this.content = content;
    }
}
