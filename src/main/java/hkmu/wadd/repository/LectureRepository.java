package hkmu.wadd.repository;

import hkmu.wadd.model.Lecture;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LectureRepository extends JpaRepository<Lecture, Long> {
}