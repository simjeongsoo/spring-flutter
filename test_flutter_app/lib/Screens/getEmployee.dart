import 'dart:convert';

import 'package:test_flutter_app/Model/EmployeeModel.dart';
import 'package:test_flutter_app/Screens/updateEmployee.dart';
import 'package:test_flutter_app/Screens/employeeDrawer.dart';
import 'package:test_flutter_app/Screens/deleteEmployee.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class getEmployee extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return getAllEmployeeState();
  }

}

class getAllEmployeeState extends State<getEmployee>{

  var employess = List<EmployeeModel>.generate(200, (index) => null);

  Future<List<EmployeeModel>> getEmployees() async {
    var data = await http.get('http://localhost:8081/getallemployees' as Uri);
    // var data = await http.get('http://10.0.2.2:8081/getallemployees'); // android Emulator
    var jsonData = json.decode(data.body);

    List<EmployeeModel> employee = [];
    for (var e in jsonData) {
      EmployeeModel employees = EmployeeModel();
      employees.id = e["id"];
      employees.firstName = e["firstName"];
      employees.lastName = e["lastName"];
      employee.add(employees);
    }
    return employee;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("All Employees Details"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> employeeDrawer()));
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: getEmployees(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(child: Center(child: Icon(Icons.error)));
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text('ID' + ' ' + 'First Name' + ' ' + 'Last Name'),
                    subtitle: Text(
                        '${snapshot.data[index].id}      ' +
                          '${snapshot.data[index].firstName}      ' +
                            '${snapshot.data[index].lastName}'),
                    onTap: () {
                      Navigator.push(
                        context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  EmployeeModel employee;

  DetailPage(this.employee);

  deleteEmployee1(EmployeeModel employee) async {
    final url = Uri.parse('http://localhost:8081/deleteemployee');
    // final url = Uri.parse('http://10.0.2.2:8081/deleteemployee'); // android

    final request = http.Request("DELETE", url);
    request.headers.addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(employee);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.firstName),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => updateEmployee(employee)));
              })
        ],
      ),
      body: Container(
        child: Text('FirstName : ' + ' ' + employee.firstName + '\n\n' + 'LastName : ' + employee.lastName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteEmployee1(employee);
          Navigator.push(context, MaterialPageRoute(builder: (context) => deleteEmployee()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}