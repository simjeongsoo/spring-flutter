package com.sim.flutterspring.repository;

import com.sim.flutterspring.entity.Authority;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthorityRepository extends JpaRepository<Authority,String> {
}
