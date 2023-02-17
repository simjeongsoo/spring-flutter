package com.sim.flutterspring.service;

import com.sim.flutterspring.entity.EmployeeEntity;
import com.sim.flutterspring.model.Employee;
import com.sim.flutterspring.repository.EmployeeRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    @Autowired
    public EmployeeService(EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }

    /**
     * 전체 목록 조회
     * */
    public List<Employee> getAllEmployees() {
        try {
            List<EmployeeEntity> employees = employeeRepository.findAll();
            List<Employee> customEmployees = new ArrayList<>();

            employees.stream().forEach(e -> {
                Employee employee = new Employee();
                BeanUtils.copyProperties(e, employee);
                customEmployees.add(employee);
            });
            return customEmployees;

        } catch (Exception e) {
            throw e;
        }
    }

    /**
     * 회원 추가
     * */
    public String addEmployee(EmployeeEntity employee) {
        try {
            if (!employeeRepository.existsByFirstNameAndLastName(employee.getFirstName(), employee.getLastName())) {
                employeeRepository.save(employee);
                return "Employee added successfully";
            } else {
                return "This employee is already exists in the database.";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    /**
     * 회원 제거
     * */
    public String removeEmployee(EmployeeEntity employee) {
        try {
            if (employeeRepository.existsByFirstNameAndLastName(employee.getFirstName(), employee.getLastName())) {
                employeeRepository.delete(employee);
                return "Employee delete successfully";
            } else {
                return "Employee does not exists";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    /**
    * 회원 수정
    * */
    public String updateEmployee(EmployeeEntity employee) {
        try {
            if (employeeRepository.existsById(employee.getId())) {
                employeeRepository.save(employee);
                return "Employee update successfully";
            } else {
                return "Employee does not exists";
            }
        } catch (Exception e) {
            throw e;
        }
    }
}
