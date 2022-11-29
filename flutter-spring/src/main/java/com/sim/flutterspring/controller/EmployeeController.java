package com.sim.flutterspring.controller;

import com.sim.flutterspring.entity.EmployeeEntity;
import com.sim.flutterspring.model.Employee;
import com.sim.flutterspring.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 전체 조회 api
     * */
    @RequestMapping(value = "getallemployees", method = RequestMethod.GET)
    public List<Employee> getAllEmployees() {
        return employeeService.getAllEmployees();
    }

    /**
     * add api
     * */
    @RequestMapping(value = "addemployee", method = RequestMethod.POST)
    public String addEmployee(@RequestBody EmployeeEntity employee) {
        return employeeService.addEmployee(employee);
    }

    /**
     * update api
     * */
    @RequestMapping(value = "updateemployee", method = RequestMethod.PUT)
    public String updateEmployee(@RequestBody EmployeeEntity employee) {
        return employeeService.updateEmployee(employee);
    }

    /**
     * delete api
     * */
    @RequestMapping(value = "deleteemployee", method = RequestMethod.DELETE)
    public String removeEmployee(@RequestBody EmployeeEntity employee) {
        return employeeService.removeEmployee(employee);
    }
}
