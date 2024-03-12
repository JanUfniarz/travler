package com.example.travler.repositories;

import com.example.travler.entities.User;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


@Repository
public interface LoginRepository extends JpaRepository<User, Long> {
    Optional<User> findFirstByLogin(String login);
}
