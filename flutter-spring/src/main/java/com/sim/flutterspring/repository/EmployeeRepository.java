package com.sim.flutterspring.repository;

import com.sim.flutterspring.entity.EmployeeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeRepository extends JpaRepository<EmployeeEntity, Integer> {

    public boolean existsByFirstNameAndLastName(String firstName, String lastName);

    public boolean existsById(int id);

}
