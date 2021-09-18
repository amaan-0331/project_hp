import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/main.dart';
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

  //getting markers from database //not being used
  Future<void> addMarkersFromDatabase(
      DocumentSnapshot document, BuildContext context) async {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    MarkerModel model = MarkerModel(
      markerId: document.id,
      uid: data['uid'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      infoTitle: data['infoTitle'],
      infoSnippet: data['infoSnippet'],
    );
    await addMarkerToSet(model);
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
        await addMarkerToSet(newLocModel);
        DatabaseController().saveMarkerData(newLocModel);
        DatabaseController().addMarkerInUserData(
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
  Future<void> addMarkerToSet(MarkerModel model) async {
    Marker loc = Marker(
      markerId: MarkerId(model.markerId!),
      position: LatLng(model.latitude, model.longitude),
      icon: BitmapDescriptor.defaultMarker,
      onTap: () => displayMarkerData(model.markerId!),
    );
    getMarkerSet.add(loc);
  }

  //Function to show marker data ontap
  Future<void> displayMarkerData(String markerId) async {
    MarkerModel? curMarkerModel =
        await DatabaseController().getCurrentMarkerDetails(markerId);
    if (curMarkerModel.runtimeType == MarkerModel) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? uid = prefs.getString('uid');
      VoteStatus voteStatus = checkVoteStatus(
        markerId,
        uid!,
        curMarkerModel!.upVoterslist,
        curMarkerModel.downVoterslist,
      );

      if (voteStatus == VoteStatus.notVoted) {
        curMarkerModel.upVoterslist.remove(uid);
        curMarkerModel.downVoterslist.remove(uid);
      }

      int voteCount = (curMarkerModel.upVoterslist.length -
          curMarkerModel.downVoterslist.length);
      DialogFuncs.alertDialogForMarker(
        navigatorKey.currentContext!,
        curMarkerModel.infoTitle,
        curMarkerModel.infoSnippet,
        voteStatus,
        voteCount,
        () {
          if (voteStatus == VoteStatus.notVoted) {
            DatabaseController()
                .addMarkerInUserVoteData(markerId, kUpvotedList);
            DatabaseController()
                .addUserInMarkerVoteData(markerId, kUpvotersList);
            curMarkerModel.upVoterslist.add(uid);
            voteStatus = VoteStatus.upvoted;
          } else if (voteStatus == VoteStatus.upvoted) {
            DatabaseController()
                .removeMarkerInUserVoteData(markerId, kUpvotedList);
            DatabaseController()
                .removeUserInMarkerVoteData(markerId, kUpvotersList);
            curMarkerModel.upVoterslist.remove(uid);
            voteStatus = VoteStatus.notVoted;
          } else {
            DatabaseController()
                .removeMarkerInUserVoteData(markerId, kDownvotedList);
            DatabaseController()
                .removeUserInMarkerVoteData(markerId, kDownvotersList);
            curMarkerModel.downVoterslist.remove(uid);
            DatabaseController()
                .addMarkerInUserVoteData(markerId, kUpvotedList);
            DatabaseController()
                .addUserInMarkerVoteData(markerId, kUpvotersList);
            curMarkerModel.upVoterslist.add(uid);
            voteStatus = VoteStatus.upvoted;
          }
        },
        () {
          if (voteStatus == VoteStatus.notVoted) {
            DatabaseController()
                .addMarkerInUserVoteData(markerId, kDownvotedList);
            DatabaseController()
                .addUserInMarkerVoteData(markerId, kDownvotersList);
            curMarkerModel.downVoterslist.add(uid);
            voteStatus = VoteStatus.downvoted;
          } else if (voteStatus == VoteStatus.downvoted) {
            DatabaseController()
                .removeMarkerInUserVoteData(markerId, kDownvotedList);
            DatabaseController()
                .removeUserInMarkerVoteData(markerId, kDownvotersList);
            curMarkerModel.downVoterslist.remove(uid);
            voteStatus = VoteStatus.notVoted;
          } else {
            DatabaseController()
                .removeMarkerInUserVoteData(markerId, kUpvotedList);
            DatabaseController()
                .removeUserInMarkerVoteData(markerId, kUpvotersList);
            curMarkerModel.upVoterslist.remove(uid);
            DatabaseController()
                .addMarkerInUserVoteData(markerId, kDownvotedList);
            DatabaseController()
                .addUserInMarkerVoteData(markerId, kDownvotersList);
            curMarkerModel.downVoterslist.add(uid);
            voteStatus = VoteStatus.downvoted;
          }
        },
      );
      Logger().v(curMarkerModel.infoTitle, curMarkerModel.infoSnippet);
    } else {
      //type error
      DialogFuncs.alertDialog(
        navigatorKey.currentContext!,
        'Error',
        'Marker is not Working',
      );
      //make a function to remove the marker from the database
    }
  }

  //Function to check vote status
  VoteStatus checkVoteStatus(
    String markerId,
    String uid,
    List<dynamic> upVoters,
    List<dynamic> downVoters,
  ) {
    List<dynamic> upVoterslist = upVoters;
    List<dynamic> downVoterslist = downVoters;
    VoteStatus voteStatus = VoteStatus.notVoted;
    if (upVoterslist.contains(uid) && downVoterslist.contains(uid)) {
      DatabaseController().removeUserInMarkerVoteData(markerId, kUpvotersList);
      DatabaseController()
          .removeUserInMarkerVoteData(markerId, kDownvotersList);
    }
    if (upVoterslist.contains(uid)) {
      voteStatus = VoteStatus.upvoted;
    } else if (downVoterslist.contains(uid)) {
      voteStatus = VoteStatus.downvoted;
    }
    return voteStatus;
  }

  //removing all markers //not being used
  void removeMarkers() {
    getMarkerSet.clear();
    notifyListeners();
  }
}