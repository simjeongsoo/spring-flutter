package com.sim.flutterspring.repository;

import com.sim.flutterspring.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {

    User findByEmailAndPassword(String email,String password);

}
