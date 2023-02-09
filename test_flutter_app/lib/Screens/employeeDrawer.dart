import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_flutter_app/Screens/getEmployee.dart';
import 'package:test_flutter_app/Screens/login.dart';
import 'package:test_flutter_app/Screens/registerEmployee.dart';
import 'package:test_flutter_app/Model/EvChargerInfo.dart';
import 'package:test_flutter_app/Service/token_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_flutter_app/Service/location_service.dart'; // google map
import 'package:custom_info_window/custom_info_window.dart';
import 'package:url_launcher/url_launcher.dart';

class employeeDrawer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return employeeDrawerState();
  }
}

class employeeDrawerState extends State<employeeDrawer> {

  final minimumPadding = 5.0;
  String markerLatLng; // 마커 클릭시 위도경도
  String currentLatLng; // 현재 위치 위도경도
  void setCurrentLatLng()async{
    currentLatLng = await LocationService().getCurrentLatLng();
  }
  String direction; // 마커 클릭시 placeId
  String currentLocation; // Current placeId
  void setCurrentLocation() async {
    currentLocation = await LocationService().getCurrentPlaceId();
  }

  //========================================================================
  // 경로그리기 ( 한국 미지원 )
  Set<Polyline> _polylines = Set<Polyline>();
  int _polylineIdCounter = 1;
  void _setPolyline(List<PointLatLng> points){
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    if(points == null) {
      print("No data available");
      points = [];
    }

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
          .map(
              (point) => LatLng(point.latitude, point.longitude),
          )
          .toList()
      ),
    );
  }
  //========================================================================

  // google map 컨트롤러
  GoogleMapController _mapController;

  // 시작 위치
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.424345, 126.883305),
    zoom: 14.4746,
  );

  //========================================================================

  // Spring 에서 받아온 데이터
  List<EvChargerInfo> _evChargerInfoList;

  @override
  void initState() {
    super.initState();
    fetchEvChargerInfoData();
  }

  // 충전소 데이터 request
  Future<void> fetchEvChargerInfoData() async {

    if(TokenService().isAuthenticated() == null) {
      print('토큰이 유효하지 않음');
    }else {
      // String url = "http://localhost:8081/flutter/get/evInfo";
      String url = "http://10.0.2.2:8081/flutter/get/evInfo";

      // setToken();
      Future<String> getToken = TokenService().getToken();
      String token = await getToken;

      print("충전소 데이터 불러올때 토큰 : $token");
      Map<String, String> headers = {};

      if (token != null) {
        headers['Content-Type'] = 'application/json; charset=UTF-8';
        headers['Authorization'] = 'Bearer $token';
      }
      var uri = Uri.parse(url);
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          if ((jsonDecode(utf8.decode(response.bodyBytes)) as List) == null) {
            print("No data available");
          }

          _evChargerInfoList =
              (jsonDecode(utf8.decode(response.bodyBytes)) as List).map((e) =>
                  EvChargerInfo.fromJson(e)).toList();

          if (_evChargerInfoList == null) {
            print("No data available");
            _evChargerInfoList = [];
          }
        });
      } else if(response.statusCode == 401){
        throw Exception('401 에러');
      }else{
        throw Exception('Failed to load data');
      }
    }
  }
  //========================================================================

  // 검색한 장소로 지도를 이동하기 위한 컨트롤러
  TextEditingController _searchController = TextEditingController();
  // 검색한 장소로 위치 이동
  Future<void> _goToSearchPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _mapController;

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat,lng), zoom: 15),
      ),
    );
  }
  //========================================================================

  // custom_info_window 구현 예정
  // CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  //========================================================================

  /*// 지도 클릭 시 표시할 장소에 대한 마커 목록
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
  // marker end*/
  //========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EV Charging Station'),
        backgroundColor: Color.fromRGBO(60, 65, 64, 1),
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
                  polylines: _polylines,
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
                  markers: _evChargerInfoList != null ? _evChargerInfoList.map((e) => Marker(
                    markerId: MarkerId(e.statId.toString()),
                    position: LatLng(e.lat, e.lng),
                    infoWindow: InfoWindow(
                      title: e.statNm,
                      snippet:
                      e.addr + '\n' +
                      '운영기관 : '+e.bnm + '\n' +
                      '이용시간 : ' + e.useTime + '\n' +
                      '주차요금 : ' + (e.parkingFree == true ? '무료' : '유료') + '\n',
                    ),
                    onTap: (){
                      setState(() {
                        // direction = LocationService().getPlaceIdByLatLng(e.lat,e.lng) as String;
                        LocationService().getPlaceIdByLatLng(e.lat, e.lng).then((value) => direction = value);
                        markerLatLng = "${e.lat},${e.lng}";

                      });
                    }
                  )).toSet() : Set(),
                  // markers: markers.toSet(),
                  // onTap: (cordinate) {
                  // 클릭시 마커 추가
                  //   _mapController.animateCamera(CameraUpdate.newLatLng(cordinate));
                  //   addMarker(cordinate);
                  // },
                ),
            ),
          ],
        ),
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
            FloatingActionButton(
              heroTag: 'search route',

              // onPressed: () async {
              //   // _mapController.animateCamera(CameraUpdate.zoomOut());
              //   // fetchEvInfoData();
              //   // setCurrentLocation();

              //   google directions api 사용하려고 했으나 한국에서는 지원하지 않음

              //   // var directions = await LocationService().getDirections(currentLocation, direction);
              //   // LocationService().getDirections(currentLocation, direction);
              //   // print("현위치아이디 : "+currentLocation + " 목적지아이디 : " + direction);
              //
              //   // _goToSearchPlace(directions['start_location']['lat'], directions['start_location']['lng']);
              //
              //   // _setPolyline(directions['polyline_decoded']);
              //
              // },
              onPressed:() async {
                _launchUrl();
              } ,
              child: Icon(Icons.alt_route),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            DrawerHeader(
              child: Text('EV charging Info',
              style: GoogleFonts.kanit(
                fontSize: 30,

              ),),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(60, 65, 64, 1),
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
            ListTile(
              title: Text('test'),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => testScreen()));
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
                  TokenService().logout(); // 토큰 삭제
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

  // 현재위치와 마커의 위치 기반으로 경로찾기
  Future<void> _launchUrl() async {
    setCurrentLatLng();
    String urlstr = "https://www.google.com/maps/dir/${currentLatLng}/${markerLatLng}/data=!3m1!4b1!4m2!4m1!3e3";
    final Uri url = Uri.parse(urlstr);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  // get data and setMarker
  /*Future<void> _getLocationData() async {
    var response = await http.get('http://localhost:8081/flutter/get/one');
    var jsonData = json.decode(response.body);
    List locationData = jsonData['location_data'];
    setState(() {
      for (int i = 0; i < locationData.length; i++) {
        double latitude = locationData[i]['latitude'];
        double longitude = locationData[i]['longitude'];
        LatLng position = LatLng(latitude, longitude);
        Marker marker = Marker(
          markerId: MarkerId(locationData[i]['id']),
          position: position,
        );
        // _markers.add(marker);
      }
    });
  }*/
}

