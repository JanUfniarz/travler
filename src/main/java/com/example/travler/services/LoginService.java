package com.example.travler.services;

import com.example.travler.entities.User;
import com.example.travler.repositories.LoginRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.atomic.AtomicBoolean;

@Service
public class LoginService {
    LoginRepository repository;

    @Autowired
    public LoginService(LoginRepository loginRepository) {
        this.repository = loginRepository;
    }

    public boolean authorizationPassed(String login, String password) {
        User user = repository.findFirstByLogin(login).orElse(null);
        return user != null && user.getPassword().equals(password);
    }

    public boolean register(String login, String password) {
        AtomicBoolean res = new AtomicBoolean(true);
        repository.findFirstByLogin(login)
                .ifPresentOrElse(
                        ig -> res.set(false),
                        () -> repository.save(new User(login, password))
                );
        return res.get();
    }
}
