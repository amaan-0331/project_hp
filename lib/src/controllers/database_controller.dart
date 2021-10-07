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
        currentUser = UserModel.fromJson(data);
        if (data['markers'] != null) {
          currentUser.userMarkers = data['markers'];
        }
        if (data[kUpvotedList] != null) {
          currentUser.upVotedlist = data[kUpvotedList];
        }
        if (data[kDownvotedList] != null) {
          currentUser.downVotedlist = data[kDownvotedList];
        }
      }
    }
    return currentUser;
  }

  //get current marker details
  Future<MarkerModel?> getCurrentMarkerDetails(String markerId) async {
    MarkerModel currentMarker = MarkerModel(
      markerId: markerId,
      uid: '',
      latitude: 0,
      longitude: 0,
      title: '',
      snippet: '',
      downVoterslist: [],
      upVoterslist: [],
    );
    DocumentSnapshot document = await markers.doc(markerId).get();
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (document.data() != null) {
      currentMarker.uid = data['uid'];
      currentMarker.title = data['title'];
      currentMarker.snippet = data['snippet'];
      currentMarker.latitude = data['latitude'];
      currentMarker.longitude = data['longitude'];
      if (data[kUpvotersList] != null) {
        currentMarker.upVoterslist = data[kUpvotersList];
      }
      if (data[kDownvotersList] != null) {
        currentMarker.downVoterslist = data[kDownvotersList];
      }
      return currentMarker;
    }
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
          'markerId': markerModel.markerId,
          'title': markerModel.title,
          'snippet': markerModel.snippet,
          'latitude': markerModel.latitude,
          'longitude': markerModel.longitude,
          'uid': markerModel.uid,
        })
        .then((value) => Logger().d("marker Added"))
        .catchError((error) =>
            Logger().e("\n\n\n Failed to add marker: $error \n\n\n\n"));
  }

  //Function to update marker data in user collection
  void addMarkerInUserData(String uid, String markerId) {
    users.doc(uid).update({
      'markers': FieldValue.arrayUnion([markerId])
    });
  }

  //Function to add marker data in user vote collection
  Future<void> addMarkerInUserVoteData(String markerId, String listName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    users.doc(uid).update({
      listName: FieldValue.arrayUnion([markerId])
    });
  }

  //Function to remove marker data in user vote collection
  Future<void> removeMarkerInUserVoteData(
      String markerId, String listName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    users.doc(uid).update({
      listName: FieldValue.arrayRemove([markerId])
    });
  }

  //Function to add marker data in user vote collection
  Future<void> addUserInMarkerVoteData(String markerId, String listName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    markers.doc(markerId).update({
      listName: FieldValue.arrayUnion([uid])
    });
  }

  //Function to remove marker data in user vote collection
  Future<void> removeUserInMarkerVoteData(
      String markerId, String listName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    markers.doc(markerId).update({
      listName: FieldValue.arrayRemove([uid])
    });
  }

  //Function to process marker stream
  MarkerModel processDataFromStreambuilder(
    BuildContext context,
    DocumentSnapshot document,
  ) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    MarkerModel model = MarkerModel(
        markerId: document.id,
        uid: data['uid'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        title: data['title'],
        snippet: data['snippet']);
    Provider.of<MapScreenProvider>(context, listen: false)
        .addMarkerToSet(model);
    return model;
  }
}
