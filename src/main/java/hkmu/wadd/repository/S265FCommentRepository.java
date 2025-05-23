package hkmu.wadd.repository;

import hkmu.wadd.model.Comment;
import hkmu.wadd.model.S265Fcomment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface S265FCommentRepository extends JpaRepository<S265Fcomment, Long> {
}