import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter_app/Model/EmployeeModel.dart';
import 'package:test_flutter_app/Screens/getEmployee.dart';

class deleteEmployee extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return deleteEmployeeState();
  }
}

Future<EmployeeModel> deleteEmployees(String firstName, String lastName) async {
  // var Url = "http://localhost:8081/deleteemployee";
  var Url = "http://10.0.2.2:8081/updateemployee"; // android Emulator
  var response = await http.delete(
    Url,
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
  return EmployeeModel.fromJson(jsonDecode(response.body));
}

class deleteEmployeeState extends State<deleteEmployee>{
  @override
  Widget build(BuildContext context) {
    return getEmployee();
  }
}