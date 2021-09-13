import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/src/models/map_marker_model.dart';
import 'package:project_hp/src/providers/map_provider/map_screen_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('markers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          snapshot.data!.docs.forEach((DocumentSnapshot document) {
            Logger().i(document.toString());
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            MarkerModel model = MarkerModel(
                markerId: document.id,
                uid: data['uid'],
                latitude: data['latitude'],
                longitude: data['longitude'],
                infoTitle: data['title'],
                infoSnippet: data['snippet']);
            Provider.of<MapScreenProvider>(context).addMarkerToSet(model);
          });

          return Consumer<MapScreenProvider>(
            builder: (context, value, child) {
              return GoogleMap(
                markers: value.getMarkerSet,
                padding: EdgeInsets.all(35),
                mapType: MapType.normal,
                onTap: (val) {
                  print(value.getMarkerSet.toString());
                },
                // onLongPress: (userPosition) async =>await saveMarker(userPosition, context),
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) =>
                    _controller.complete(controller),
              );
            },
          );
        },
      ),
    );
  }
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