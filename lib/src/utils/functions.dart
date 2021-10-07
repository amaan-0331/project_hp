import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_hp/src/models/map_marker_model.dart';
import 'package:project_hp/src/providers/map_provider/map_screen_provider.dart';
import 'package:project_hp/src/providers/navigator_provider/navigator_provider.dart';
import 'package:provider/provider.dart';

class UtilFuncs {
  //Loader animation when button loading
  static Widget buttonLoader = SpinKitWave(
    type: SpinKitWaveType.start,
    color: Color(0xff159B80),
    // size: 50.0,
  );

  //Loader animation when page loading
  static Widget pageLoader = SpinKitChasingDots(
    color: Color(0xff159B80),
    // size: 50.0,
  );
}

//Functions to navigate across the screens
class NavigatorFuncs {
  //Function to Navigate with push
  static void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  //Function to Navigate with pushAndRemoveUntil
  static void navigateToNoBack(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }
}

//marker view functions
class MarkerViewFuncs {
  //function to open the marker in the map
  void openInMapMethod(BuildContext context, MarkerModel camMarker) {
    Provider.of<MapScreenProvider>(context, listen: false)
        .setNewCamPosition(LatLng(camMarker.latitude, camMarker.longitude));
    Provider.of<NavigatorProvider>(context, listen: false)
        .setCurrentScreenIndex(1);
  }

  //function to find proximity
  double proximityFinder(Position currentLoc, MarkerModel currentMarker) =>
      Geolocator.distanceBetween(currentLoc.latitude, currentLoc.longitude,
          currentMarker.latitude, currentMarker.longitude);
}
