import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/models/map_marker_model.dart';

class DatabaseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference markers =
      FirebaseFirestore.instance.collection('markers');

  //Function to save user data
  Future<void> saveUserData(String name, email, uid) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(uid)
        .set({
          'uid': uid,
          'name': name,
          'email': email,
        })
        .then((value) => Logger().d("User Added"))
        .catchError(
            (error) => Logger().e("\n\n\n Failed to add user: $error \n\n\n"));
  }

  //Function to save marker data
  Future<void> saveMarkerData(MarkerModel markerModel) {
    // Call the user's CollectionReference to add a new user
    return markers
        .doc(markerModel.markerId)
        .set({
          'title': markerModel.infoTitle,
          'snippet': markerModel.infoSnippet,
          'latitude': markerModel.latitude,
          'longitude': markerModel.longitude,
        })
        .then((value) => Logger().d("marker Added"))
        .catchError((error) =>
            Logger().e("\n\n\n Failed to add marker: $error \n\n\n\n"));
  }
}
