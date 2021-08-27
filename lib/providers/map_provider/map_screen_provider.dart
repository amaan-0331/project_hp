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
    );
  }

  //save user marker in firestore
  void saveMarkerInDatabase(MarkerModel markerModel) {
    DatabaseController().saveMarkerData(markerModel);
  }

  //save user selection --> long press function
  Future<void> saveUserMarker(LatLng userPosition, BuildContext context) async {
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

    Marker newLoc = Marker(
        markerId: MarkerId(newLocModel.markerId),
        position: userPosition,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: newLocModel.infoTitle,
          snippet: newLocModel.infoSnippet,
        ));
    Logger().i('New Location Created!');
    saveMarkerInDatabase(newLocModel);
    getMarkerSet.add(newLoc);
    notifyListeners();
    Logger().i('New Location Added!');
  }

  //removing all markers
  void removeMarkers() {
    getMarkerSet.clear();
    notifyListeners();
  }
}
