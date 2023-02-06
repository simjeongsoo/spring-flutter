import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_flutter_app/Screens/getEmployee.dart';
import 'package:test_flutter_app/Screens/login.dart';
import 'package:test_flutter_app/Screens/registerEmployee.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_flutter_app/Service/location_service.dart'; // google map

class employeeDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return employeeDrawerState();
  }
}

class employeeDrawerState extends State<employeeDrawer> {

  final minimumPadding = 5.0;

  // Completer<GoogleMapController> _controller = Completer();

  // 초기 카메라 위치
  // static final CameraPosition _KGooglePlex = CameraPosition(
  //   target: LatLng(37.358453, 126.714331),
  //   zoom: 14.4746,
  // );

  // 찾을 위치
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.358453, 126.714331),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414
  // );


  // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
  GoogleMapController _mapController;

  // 이 값은 지도가 시작될 때 첫 번째 위치입니다.
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.358453, 126.714331),
    zoom: 14.4746,
  );


  // 지도 클릭 시 표시할 장소에 대한 마커 목록
  final List<Marker> markers = [];

  addMarker(cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      markers
          .add(Marker(
          position: cordinate,
          markerId: MarkerId(id.toString())
      ));
    });
  }
  // marker end

  // 검색한 장소로 지도를 이동하기 위한 컨트롤러
  TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EV charging station'),
        backgroundColor: Color.fromRGBO(233, 65, 82, 1),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(hintText: 'Search by City'),
                    onChanged: (value){
                      print(value);
                    },
                  )
                ),
                IconButton(
                    onPressed: () async {
                      var place = await LocationService().getPlace(_searchController.text);
                      _goToSearchPlace(place);
                    },
                    icon: Icon(Icons.search)
                ),
              ],
            ),
            Expanded(
                child: GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: _initialPosition,
                  // 초기 카메라 위치
                  onMapCreated: (controller) {
                    setState(() {
                      _mapController = controller; // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
                    });
                  },
                  // onMapCreated: (GoogleMapController controller){
                  //   _controller.complete(controller);
                  // },
                  markers: markers.toSet(),
                  onTap: (cordinate) {
                    _mapController.animateCamera(CameraUpdate.newLatLng(cordinate));

                    addMarker(cordinate);
                  },
                ),
            ),
          ],
        )
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'zoomIn',
              onPressed: () {
                _mapController.animateCamera(CameraUpdate.zoomIn());
              },
              child: Icon(Icons. zoom_in),
            ),
            FloatingActionButton(
              heroTag: 'zoomOut',
              onPressed: () {
                _mapController.animateCamera(CameraUpdate.zoomOut());
              },
              child: Icon(Icons. zoom_out),
            ),
          ],
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheTarget,
      //   label: Text('go!'),
      //   icon: Icon(Icons.directions_car),
      // ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
              child: Text('EV charging station'),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 65, 82, 1)
              ),
            ),
            ListTile(
              title: Text('Register user'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => registerEmployee()));
              },
            ),
            ListTile(
              title: Text('Get user'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getEmployee()));
              },
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 400,
              width: 100,
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text('Logout'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // 검색한 장소로 위치 이동
  Future<void> _goToSearchPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    // final GoogleMapController controller = await _controller.future;
    final GoogleMapController controller = await _mapController;

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat,lng), zoom: 12),
      ),
    );
  }

}