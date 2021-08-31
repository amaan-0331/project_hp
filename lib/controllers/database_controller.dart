import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/models/map_marker_model.dart';
import 'package:project_hp/providers/map_provider/map_screen_provider.dart';
import 'package:provider/provider.dart';

class DatabaseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference markers =
      FirebaseFirestore.instance.collection('markers');
  Stream<QuerySnapshot<Map<String, dynamic>>> markerStream =
      FirebaseFirestore.instance.collection('markers').snapshots();

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

  //Function to process marker stream
  Map<String, dynamic> processDataFromStreambuilder(
    BuildContext context,
    DocumentSnapshot document,
  ) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    MarkerModel model = MarkerModel(
        markerId: document.id,
        latitude: data['latitude'],
        longitude: data['longitude'],
        infoTitle: data['title'],
        infoSnippet: data['snippet']);
    Provider.of<MapScreenProvider>(context, listen: false)
        .addMarkerToSet(model);
    return data;
  }
}
