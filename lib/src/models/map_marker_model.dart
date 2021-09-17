import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  String? markerId, uid;
  double latitude, longitude;
  String infoTitle, infoSnippet;
  List<dynamic> upVoterslist, downVoterslist;

  MarkerModel({
    required this.markerId,
    required this.uid,
    required this.latitude,
    required this.longitude,
    required this.infoTitle,
    required this.infoSnippet,
    this.upVoterslist = const [],
    this.downVoterslist = const [],
  });
}

//sample
Marker home = Marker(
    markerId: MarkerId('home'),
    position: LatLng(1.11, 2.22),
    infoWindow: InfoWindow(title: '', snippet: ''));
