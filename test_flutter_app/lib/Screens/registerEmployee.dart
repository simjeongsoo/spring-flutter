import 'dart:convert';

import 'package:test_flutter_app/Model/EmployeeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class registerEmployee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerEmployeeState();
  }
}

Future<EmployeeModel> registerEmployees(
    String firstName, String lastName, BuildContext context) async {

  var Url = "http://localhost:8081/addemployee";
  // var Url = "http://10.0.2.2:8081/addemployee"; // Android Emulator
  var response = await http.post(Url as Uri,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "firstName": firstName,
        "lastName": lastName,
      }));

    String responseString = response.body;
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(title: 'Backend Response', content: response.body);
        },
      );
    }
    // throw ''; // null safety , 2.12.0
}

class registerEmployeeState extends State<registerEmployee> {
  final minimumPadding = 5.0;

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  // EmployeeModel employee;

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Register Employee"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: firstController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please enter your name';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Enter Your First Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: lastController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please enter your name';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Enter Your First Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () async{
                  String firstName = firstController.text;
                  String lastName = lastController.text;
                  EmployeeModel employees = await registerEmployees(firstName, lastName, context);
                  firstController.text = '';
                  lastController.text = '';
                  setState(() {
                    employees = employees;
                  });
                })
            ],
          ),
        ),
      ),
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}