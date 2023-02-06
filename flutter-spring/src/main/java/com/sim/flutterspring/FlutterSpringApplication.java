package com.sim.flutterspring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.CrossOrigin;

@SpringBootApplication
@CrossOrigin
public class FlutterSpringApplication {

    public static void main(String[] args) {
        SpringApplication.run(FlutterSpringApplication.class, args);
    }

}
