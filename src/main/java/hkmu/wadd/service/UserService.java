package hkmu.wadd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hkmu.wadd.model.User;
import hkmu.wadd.repository.UserRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void registerUser(User user, String role) {
        // Hash the password before saving
        user.setPassword("{noop}" + user.getPassword());

        // Save the user
        userRepository.save(user);

        // Save the role in the `user_roles` table
        entityManager
            .createNativeQuery("INSERT INTO user_roles (username, role) VALUES (?, ?)")
            .setParameter(1, user.getUsername())
            .setParameter(2, role)
            .executeUpdate();
    }
}
