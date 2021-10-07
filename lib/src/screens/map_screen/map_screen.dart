import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_hp/src/components/temp_screen/temp_screen.dart';
import 'package:project_hp/src/controllers/database_controller.dart';
import 'package:project_hp/src/providers/map_provider/location_provider.dart';
import 'package:project_hp/src/providers/map_provider/map_screen_provider.dart';
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
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Consumer<MapScreenProvider>(
        builder: (context, value, child) {
          return StreamBuilder<QuerySnapshot>(
            stream: DatabaseController().markerStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return TempScreen(size: size, message: 'Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return TempScreen(size: size, message: "Loading");
              }

              snapshot.data!.docs.forEach(
                (DocumentSnapshot document) {
                  DatabaseController()
                      .processDataFromStreambuilder(context, document);
                },
              );

              return SafeArea(
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: value.getMarkerSet,
                  padding: EdgeInsets.all(35),
                  mapType: MapType.normal,
                  onLongPress: (userPosition) async =>
                      await value.saveMarker(userPosition, context),
                  initialCameraPosition: value.setCamPosition(_currentLoc),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    value.mapController = controller;
                  },
                  onTap: (tapLocation) {
                    value.animateToLocation(tapLocation);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
