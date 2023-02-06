package com.sim.flutterspring.entity;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
//@NoArgsConstructor
@Data
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer id;

    public String email;
    public String password;

    public User() {
    }

    @Builder
    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }
}
