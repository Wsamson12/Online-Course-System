package hkmu.wadd.repository;

import hkmu.wadd.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, String> {
}