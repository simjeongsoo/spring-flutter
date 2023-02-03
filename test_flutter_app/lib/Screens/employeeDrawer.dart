import 'package:flutter/material.dart';
import 'package:test_flutter_app/Screens/getEmployee.dart';
import 'package:test_flutter_app/Screens/login.dart';
import 'package:test_flutter_app/Screens/registerEmployee.dart';

class employeeDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return employeeDrawerState();
  }
}

class employeeDrawerState extends State<employeeDrawer> {

  final minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Management'),
      ),
      body: Center(child: Text('google map api')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding,bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
                child: Text('Employee Management'),
                decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Register Employee'),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=> registerEmployee()));
              },
            ),
            ListTile(
              title: Text('Get Employee'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => getEmployee()));
              },
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height:400,
              width:100,
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('Logout'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}