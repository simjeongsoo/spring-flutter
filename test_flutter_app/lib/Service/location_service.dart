import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService{
  final String key = 'AIzaSyB5Qej1hGiYUwL3Hw19XYV_8DSpfJ6l_Q8';

  Future<String> getPlaceId(String input) async{
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var placeId = json['candidates'][0]['place_id'] as String;

    print(placeId);

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async{
    final placeId = await getPlaceId(input);

    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var result = json['result'] as Map<String, dynamic>;

    print(result);

    return result;

  }

  // google map directions 경로찾기
  Future<void> getDirections(String origin, String destination) async {

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=place_id:$origin&destination=place_id:$destination&key=$key';
    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);
    // var json = jsonDecode(utf8.decode(response.bodyBytes));

    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints().decodePolyline(
          json['routes'][0]['overview_polyline']['points']
      ),
    };

    print(json);
    print(results);



    // return result;
  }

  // 위도, 경도로 placeId search
  Future<String> getPlaceIdByLatLng(double lat, double lng) async {
    String urlstr = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$key';
    // final response = await http.get(url);
    var url = Uri.parse(urlstr);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data['results'][0]['place_id'];
    } else {
      throw Exception('Failed to get place ID');
    }
  }

  // 현위치 search
  Future<String> getCurrentPlaceId() async {

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var placeIdByLatLng = getPlaceIdByLatLng(position.latitude, position.longitude);

    return placeIdByLatLng;
  }

  // 현위치 위도 경도
  Future<String> getCurrentLatLng() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String currentLatLng = "${position.latitude},${position.longitude}";
    return currentLatLng;
  }

}