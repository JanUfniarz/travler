package com.example.travler.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@SuppressWarnings("unused")
@Controller
public class RootController {
    @GetMapping("/")
    public String index() {
        return "index.html";
    }
}
