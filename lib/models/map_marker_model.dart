import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  String? markerId, uid;
  double latitude, longitude;
  String infoTitle, infoSnippet;

  MarkerModel({
    required this.markerId,
    required this.uid,
    required this.latitude,
    required this.longitude,
    required this.infoTitle,
    required this.infoSnippet,
  });
}

//sample
Marker home = Marker(
    markerId: MarkerId('home'),
    position: LatLng(1.11, 2.22),
    infoWindow: InfoWindow(title: '', snippet: ''));
