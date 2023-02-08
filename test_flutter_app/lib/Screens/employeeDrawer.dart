import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
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

  // Spring 에서 받아온 데이터
  List<EvChargerInfo> _evChargerInfoList;

  @override
  void initState() {
    super.initState();
    fetchEvChargerInfoData();
  }

  // get location from Spring
  Future<void> fetchEvChargerInfoData() async {
    final response = await http.get('http://localhost:8081/flutter/get/evInfo');
    if (response.statusCode == 200) {
      setState(() {
        _evChargerInfoList =
            (jsonDecode(utf8.decode(response.bodyBytes)) as List).map((e) =>
                EvChargerInfo.fromJson(e)).toList();

      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
  GoogleMapController _mapController;

  // 시작 위치
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.358453, 126.714331),
    zoom: 14.4746,
  );


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
                  markers: _evChargerInfoList.map((e) => Marker(
                    markerId: MarkerId(e.statId.toString()),
                    position: LatLng(e.lat, e.lng),
                    infoWindow: InfoWindow(
                      title: e.statNm,
                      snippet: e.addr,
                    )
                  )).toSet()
                  // markers: markers.toSet(),
                  // onTap: (cordinate) {
                  // 클릭시 마커 추가
                  //   _mapController.animateCamera(CameraUpdate.newLatLng(cordinate));
                  //   addMarker(cordinate);
                  // },
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
            FloatingActionButton(
              heroTag: 'admin',
              onPressed: () {
                // _mapController.animateCamera(CameraUpdate.zoomOut());
                // fetchEvInfoData();
              },
              child: Icon(Icons.adb_outlined),
            ),
          ],
        ),
      ),
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
        CameraPosition(target: LatLng(lat,lng), zoom: 15),
      ),
    );
  }

  // get data
  Future<void> _getLocationData() async {
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
  }

  Future<EvChargerInfo> fetchEvInfoData() async {
    final response = await http.get('http://localhost:8081/flutter/get/one');

    if (response.statusCode == 200) {
      // Map<String, dynamic> map = json.decode(response.body);
      Map<String, dynamic> map = jsonDecode(utf8.decode(response.bodyBytes)); // 한글깨짐 오류 처리


      var evChargerInfo1 = EvChargerInfo.fromJson(map);
      print(EvChargerInfo.fromJson(map).addr);
      print(evChargerInfo1.lng);
      print(evChargerInfo1.lat);

      return EvChargerInfo.fromJson(map);
    } else {

      throw Exception('Failed to load data');
    }
  }
}

class EvChargerInfo {
   String statNm;          // 충전소명
   String statId;            // 충전소 ID
   var chgerId;           // 충전기 ID
   var chgerType;         // 충전기 타입
   String addr;            // 주소
   String location;        // 상세위치
   String useTime;         // 이용가능시간
   var lat;               // 위도
   var lng;               // 경도
   String busiId;          // 기관 아이디
   String bnm;             // 기관명
   String busiNm;          // 운영기관명
   String busiCall;        // 운영기관 연락처
   var chstat;            // 충전기 상태
   String statUpdDt;         // 상태 갱신일시
   String lastTsdt;          // 마지막 충전시작 일시
   String lastTedt;          // 마지막 충전종료 일시
   String nowTsdt;           // 충전중 시작일시
   String powerType;
   var output;            // 충전용량
   String method;         // 충전방식
   var zcode;             // 지역코드
   var zscode;            // 지역구분 상세코드
   String kind;            // 충전소 구분 코드
   String kindDetail;      // 충전소 구분 상세 코드
   bool parkingFree;    // 주차료 무료
   String note;            // 충전소 안내
   bool limitYn;        // 이용자제한
   String limitDetail;     // 이용 제한사유
   bool delYn;          // 삭제 여부
   String delDetail;       // 삭제 사유
   bool trafficYn;  // 편의제공 여부

   EvChargerInfo(
      this.statNm,
      this.statId,
      this.chgerId,
      this.chgerType,
      this.addr,
      this.location,
      this.useTime,
      this.lat,
      this.lng,
      this.busiId,
      this.bnm,
      this.busiNm,
      this.busiCall,
      this.chstat,
      this.statUpdDt,
      this.lastTsdt,
      this.lastTedt,
      this.nowTsdt,
      this.powerType,
      this.output,
      this.method,
      this.zcode,
      this.zscode,
      this.kind,
      this.kindDetail,
      this.parkingFree,
      this.note,
      this.limitYn,
      this.limitDetail,
      this.delYn,
      this.delDetail,
      this.trafficYn);

   String get _statNm => statNm;
   String get _statId => statId;

   factory EvChargerInfo.fromJson(Map<String, dynamic> json) {
     return EvChargerInfo(
       json['statNm'],
       json['statId'],
       json['chgerId'],
       json['chgerType'],
       json['addr'],
       json['location'],
       json['useTime'],
       json['lat'],
       json['lng'],
       json['busiId'],
       json['bnm'],
       json['busiNm'],
       json['busiCall'],
       json['chstat'],
       json['statUpDt'],
       json['lastTsdt'],
       json['lastTedt'],
       json['nowTsdt'],
       json['powerType'],
       json['output'],
       json['method'],
       json['zcode'],
       json['zscode'],
       json['kind'],
       json['kindDetail'],
       json['parkingFree'],
       json['note'],
       json['limitYn'],
       json['limitDetail'],
       json['delYn'],
       json['delDetail'],
       json['trafficYn'],
     );
   }

   Future<List<EvChargerInfo>> fetchEvInfoData() async {
     final response = await http.get('http://localhost:8081/flutter/get/evInfo');

     if (response.statusCode == 200) {
       // List<dynamic> data = json.decode(response.body);

       List<dynamic> data  = jsonDecode(utf8.decode(response.bodyBytes)); // 한글깨짐 오류 처리

       List<EvChargerInfo> evChargerInfos = []; // 리스트 배열 생성

       for (var item in data) {
         evChargerInfos.add(EvChargerInfo.fromJson(item));
       }
       return evChargerInfos;

     } else {
       throw Exception('Failed to load data');
     }
   }




}

