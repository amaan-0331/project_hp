import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/controllers/database_controller.dart';
import 'package:project_hp/models/map_marker_model.dart';
import 'package:project_hp/utils/functions.dart';

class MapScreenProvider extends ChangeNotifier {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _snippetController = TextEditingController();

  Set<Marker> _setofmarkers = {};
  Set<Circle> _setofcircles = {};

  CameraPosition? _currentCamPos;

  //getters
  TextEditingController get getTitleController => _titleController;
  TextEditingController get getSnippetController => _snippetController;
  CameraPosition? get getCurrentLocationCameraPostion => _currentCamPos;
  Set<Marker> get getMarkerSet => _setofmarkers;
  Set<Circle> get getCircleSet => _setofcircles;

  //setters
  CameraPosition setCurrentCamPosition(Position currentLoc) {
    return CameraPosition(
      target: LatLng(
        currentLoc.latitude,
        currentLoc.longitude,
      ),
      zoom: 17,
      tilt: 60,
    );
  }

  //save user marker in firestore
  void saveMarkerInDatabase(MarkerModel markerModel) {
    DatabaseController().saveMarkerData(markerModel);
  }

  //getting markers from database
  void addMarkersFromDatabase(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    MarkerModel model = MarkerModel(
        markerId: document.id,
        latitude: data['latitude'],
        longitude: data['longitude'],
        infoTitle: data['infoTitle'],
        infoSnippet: data['infoSnippet']);
    addMarkerToSet(model);
    notifyListeners();
    Logger().i('New Location ${document.id} Created!');
  }

  //save user selection --> long press function
  Future<void> saveMarker(LatLng userPosition, BuildContext context) async {
    getTitleController.clear();
    getSnippetController.clear();
    await DialogFuncs.alertDialogWithTextFields(
      context,
      'Topic',
      'Short info About the tag!😉',
      getTitleController,
      getSnippetController,
    );
    MarkerModel newLocModel = MarkerModel(
      markerId: "${userPosition.latitude}${userPosition.longitude}",
      latitude: userPosition.latitude,
      longitude: userPosition.longitude,
      infoTitle: getTitleController.text,
      infoSnippet: getSnippetController.text,
    );
    Logger().i('New Location Created!');
    addMarkerToSet(newLocModel);
    saveMarkerInDatabase(newLocModel);
    notifyListeners();
    Logger().i('New Location Added!');
  }

  //add marker to the set
  void addMarkerToSet(MarkerModel model) {
    Marker loc = Marker(
        markerId: MarkerId(model.markerId),
        position: LatLng(model.latitude, model.longitude),
        infoWindow: InfoWindow(
          title: model.infoTitle,
          snippet: model.infoSnippet,
        ));
    getMarkerSet.add(loc);
  }

  //removing all markers
  void removeMarkers() {
    getMarkerSet.clear();
    notifyListeners();
  }

  //testing code //////////
  // Stream tetstts = Stream();
  Future<Marker> testStream(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    MarkerModel model = MarkerModel(
        markerId: document.id,
        latitude: data['latitude'],
        longitude: data['longitude'],
        infoTitle: data['title'],
        infoSnippet: data['snippet']);
    Marker test1 = Marker(markerId: MarkerId(model.markerId));
    return test1;
  }
  //testing code //////////
}
