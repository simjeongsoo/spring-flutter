import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_flutter_app/Screens/getEmployee.dart';
import 'package:test_flutter_app/Screens/login.dart';
import 'package:test_flutter_app/Screens/registerEmployee.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // google map

class employeeDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return employeeDrawerState();
  }
}

class employeeDrawerState extends State<employeeDrawer> {

  final minimumPadding = 5.0;

  Completer<GoogleMapController> _controller = Completer();

  // 초기 카메라 위치
  static final CameraPosition _KGooglePlex = CameraPosition(
    target: LatLng(37.358453, 126.714331),
    zoom: 14.4746,
  );

  // 찾을 위치
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.358453, 126.714331),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EV charging station'),
        backgroundColor: Color.fromRGBO(233, 65, 82, 1),
      ),
      // body: Center(child: Text('google map api')),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _KGooglePlex, // 초기 카메라 위치
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(

        onPressed: _goToTheTarget,
        label: Text('go!'),
        icon: Icon(Icons.directions_car),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding,bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
                child: Text('EV charging station'),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 65, 82, 1)
              ),
            ),
            ListTile(
              title: Text('Register user'),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=> registerEmployee()));
              },
            ),
            ListTile(
              title: Text('Get user'),
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

  Future<void> _goToTheTarget() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

}