import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/src/models/map_marker_model.dart';
import 'package:project_hp/src/models/user_model.dart';
import 'package:project_hp/src/providers/map_provider/map_screen_provider.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference markers =
      FirebaseFirestore.instance.collection('markers');
  Stream<QuerySnapshot<Map<String, dynamic>>> markerStream =
      FirebaseFirestore.instance.collection('markers').snapshots();

  //get current user details
  Future<UserModel> getCurrentUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    UserModel currentUser = UserModel(
      uid: kAnonymous,
      email: kAnonymous,
      name: 'Mystery User',
    );
    if (uid != kAnonymous) {
      Logger().v('uid is $uid');
      DocumentSnapshot document = await users.doc(uid).get();
      if (document.data() != null) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        currentUser.uid = data['uid'];
        currentUser.name = data['name'];
        currentUser.email = data['email'];
      }
    }
    return currentUser;
  }

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
          'uid': markerModel.uid,
        })
        .then((value) => Logger().d("marker Added"))
        .catchError((error) =>
            Logger().e("\n\n\n Failed to add marker: $error \n\n\n\n"));
  }

  //Function to update marker data in user collection
  void updateMarkerInUserData(String uid, String markerId) {
    users.doc(uid).update({
      'markers': FieldValue.arrayUnion([markerId])
    });
  }

  // // user doc stream
  // Stream<UserModel> get userData {
  //   return users.doc(uid).snapshots().map(_userDataFromSnapshot);
  // }

  // // user data from snapshots
  // UserModel _userDataFromSnapshot(DocumentSnapshot document) {
  //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //   return UserModel(
  //     uid: uid!,
  //     name: data['name'],
  //     email: data['sugars'],
  //   );
  // }

  //Function to process marker stream
  Map<String, dynamic> processDataFromStreambuilder(
      BuildContext context, DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    MarkerModel model = MarkerModel(
        markerId: document.id,
        uid: data['uid'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        infoTitle: data['title'],
        infoSnippet: data['snippet']);
    Provider.of<MapScreenProvider>(context, listen: false)
        .addMarkerToSet(model);
    return data;
  }
}
