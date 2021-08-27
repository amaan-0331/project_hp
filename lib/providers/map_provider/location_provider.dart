import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/utils/functions.dart';

class LocationProvider extends ChangeNotifier {
  bool _serviceEnabled = false;
  LocationPermission? _permission;
  late Position _currentLocation;

  //setters
  void setServiceStatus(bool val) => _serviceEnabled = val;
  void setPermission(LocationPermission val) => _permission = val;
  void setCurrentLocation(Position val) => _currentLocation = val;

  //getters
  Position get getCurrentLocation => _currentLocation;

  // check if location services are enabled
  Future<void> checkLocationService() async {
    bool val = await Geolocator.isLocationServiceEnabled();
    setServiceStatus(val);
  }

  //Check permission for location services
  Future<void> checkPermission() async {
    LocationPermission val = await Geolocator.checkPermission();
    setPermission(val);
  }

  //determining the current position
  Future<Position?> determinePosition(BuildContext context) async {
    await checkLocationService();
    if (!_serviceEnabled) {
      DialogFuncs.alertDialogWithBtn(
        context,
        "Enable Location Service",
        "Pls Enable Location Services and Restart the Application!",
        "Open Settings",
        () {
          Geolocator.openLocationSettings();
          SystemNavigator.pop();
        },
      );
      return Future.error('Location services are disabled.');
    }
    await checkPermission();
    if (_permission == LocationPermission.denied) {
      Logger().v('Permission Denied first time');
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        Logger().w('Permission Denied Second time');
        return Future.error('Location permissions are denied');
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      DialogFuncs.alertDialogWithTwoBtn(
        context,
        "Share Location to Use",
        "Location Service is essential for This App.",
        "Exit",
        () {
          SystemNavigator.pop();
        },
        "Allow",
        () async {
          _permission = await Geolocator.requestPermission();
        },
      );

      Logger().e('Permission Denied Third time and forever');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // continue accessing the position of the device.
    Logger().i('Permission Labuna brooooo');

    Position val = await Geolocator.getCurrentPosition();
    setCurrentLocation(val);
    return val;
  }
}
