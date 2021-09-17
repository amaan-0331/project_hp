import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_hp/main.dart';
import 'package:project_hp/src/providers/map_provider/map_screen_provider.dart';
import 'package:project_hp/src/utils/functions.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> markerSet = <Marker>{
    Marker(
      markerId: MarkerId('001'),
      position: LatLng(37.42796133580664, -122.085749655962),
      onTap: () {
        DialogFuncs.alertDialog(
          navigatorKey.currentContext!,
          'test',
          'testttt',
        );
      },
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<MapScreenProvider>(
      builder: (context, value, child) {
        return GoogleMap(
          markers: markerSet,
          padding: EdgeInsets.all(35),
          mapType: MapType.terrain,
          initialCameraPosition: _kGooglePlex,
          onTap: (position) {
            markerSet.add(
              Marker(
                markerId: MarkerId('005'),
                position: position,
              ),
            );
          },
          onMapCreated: (GoogleMapController controller) =>
              _controller.complete(controller),
        );
      },
    );
  }
}

void showMyDialog() {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => Center(
      child: Material(
        color: Colors.transparent,
        child: Text('Hello'),
      ),
    ),
  );
}
    // ListView(
    //   cacheExtent: 15,
    //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
    //     Map<String, dynamic> data = DatabaseController()
    //         .processDataFromStreambuilder(context, document);
    //     Logger().i(data.toString());
    //     return MarkerCard(data: data);
    //   }).toList(),
    // );