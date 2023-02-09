import 'package:flutter/material.dart';
import 'package:test_flutter_app/Screens/dashboard.dart';
import 'Screens/employeeDrawer.dart';
import 'Screens/login.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'EvChargerApp',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
        home: Login(),
      );
  }
}