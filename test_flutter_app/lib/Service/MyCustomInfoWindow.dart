import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';

class MyCustomInfoWindow extends CustomInfoWindow {
  // MyCustomInfoWindow({Key? key, this.marker}) : super(key: key);
  MyCustomInfoWindow({this.marker});

  final Marker marker;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(marker.infoWindow.title),
          Text(marker.infoWindow.snippet),
          TextButton(
            child: Text("Button"),
            onPressed: () {
              // Your button action here
              print('hello');
            },
          )
        ],
      ),
    );
  }
}
