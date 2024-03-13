package com.example.travler.controllers;

import com.example.travler.services.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@SuppressWarnings("unused")
@RestController
@RequestMapping(path = "v1/login")
public class LoginController {

    public record LoginData(String login, String password) {}

    private final LoginService service;

    @Autowired
    public LoginController(LoginService service) {
        this.service = service;
    }

    @PostMapping(path = "auth")
    public Map<String, Object> login(@RequestBody LoginData data) {
        boolean auth = service.authorizationPassed(data.login(), data.password());
        return new HashMap<>() {{
            put("status", auth);
            put("message", auth ? "Authorization passed" : "Authorization failed");
        }};
    }

    @PostMapping(path = "{command}")
    public Map<String, Object> register(
            @PathVariable String command,
            @RequestBody LoginData data
    ) {
        boolean success = false;
        switch (command) {
            case "auth":
                success = service.authorizationPassed(data.login(), data.password());
                break;
            case "register":
                success = service.register(data.login(), data.password());
                break;
            default:
                break;
        }
        boolean finalSuccess = success;
        return new HashMap<>() {{
            put("status", finalSuccess);
            put("message", command + " " + (finalSuccess ? "passed" : "failed"));
        }};
    }

}
