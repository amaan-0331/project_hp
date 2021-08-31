import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_hp/providers/map_provider/location_provider.dart';
import 'package:project_hp/providers/map_provider/map_screen_provider.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    Position _currentLoc =
        Provider.of<LocationProvider>(context).getCurrentLocation;
    return Scaffold(
      body: Consumer<MapScreenProvider>(
        builder: (context, value, child) {
          return GoogleMap(
            markers: value.getMarkerSet,
            padding: EdgeInsets.all(35),
            mapType: MapType.normal,
            onLongPress: (userPosition) async =>
                await value.saveMarker(userPosition, context),
            initialCameraPosition: value.setCurrentCamPosition(_currentLoc),
            onMapCreated: (GoogleMapController controller) =>
                _controller.complete(controller),
          );
        },
      ),
    );
  }
}
