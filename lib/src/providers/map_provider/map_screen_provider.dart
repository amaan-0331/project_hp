import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/src/controllers/auth_controller.dart';
import 'package:project_hp/src/controllers/database_controller.dart';
import 'package:project_hp/src/models/map_marker_model.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:project_hp/src/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  CameraPosition setCamPosition(Position currentLoc) {
    return CameraPosition(
      target: LatLng(
        currentLoc.latitude,
        currentLoc.longitude,
      ),
      zoom: 17,
      tilt: 60,
    );
  }

  //getting markers from database
  void addMarkersFromDatabase(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    MarkerModel model = MarkerModel(
        markerId: document.id,
        uid: data['uid'],
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    if (uid == kAnonymous) {
      DialogFuncs.alertDialogWithBtn(
        context,
        'Sign In to Contribute',
        'To Contribute Need an Account. \nSign In or Log In!',
        'Sign In',
        () => AuthController(context).signOut(),
      );
    } else {
      await DialogFuncs.alertDialogWithTextFields(
        context,
        'Topic',
        'Short info About the tag!😉',
        getTitleController,
        getSnippetController,
      );
      MarkerModel newLocModel = MarkerModel(
        markerId: "${userPosition.latitude}${userPosition.longitude}",
        uid: prefs.getString('uid'),
        latitude: userPosition.latitude,
        longitude: userPosition.longitude,
        infoTitle: getTitleController.text,
        infoSnippet: getSnippetController.text,
      );
      if (getTitleController.text == '' || getSnippetController.text == '') {
        DialogFuncs.alertDialog(
          context,
          'Need More Info!',
          'Title and Snippet cannot be Empty',
        );
      } else {
        Logger().i('New Location Created!');
        addMarkerToSet(newLocModel);
        DatabaseController().saveMarkerData(newLocModel);
        DatabaseController().updateMarkerInUserData(
          uid!,
          newLocModel.markerId!,
        );
        notifyListeners();
        Logger().i('New Location Added!');
      }

      getTitleController.clear();
      getSnippetController.clear();
    }
  }

  //add marker to the set
  void addMarkerToSet(MarkerModel model) {
    Marker loc = Marker(
        markerId: MarkerId(model.markerId!),
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
}
