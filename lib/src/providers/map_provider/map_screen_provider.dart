import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/main.dart';
import 'package:project_hp/src/components/alert_dialogs/alert_dialogs.dart';
import 'package:project_hp/src/controllers/auth_controller.dart';
import 'package:project_hp/src/controllers/database_controller.dart';
import 'package:project_hp/src/models/map_marker_model.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreenProvider extends ChangeNotifier {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _snippetController = TextEditingController();

  Set<Marker> _setofmarkers = {};
  Set<Circle> _setofcircles = {};
  CameraPosition? _currentCamPos;

  CameraPosition? _newCamPosition;

  GoogleMapController? mapController;

  // int nearbyMarkersCount = 0;

  //getters
  TextEditingController get getTitleController => _titleController;
  TextEditingController get getSnippetController => _snippetController;
  CameraPosition? get getCurrentLocationCameraPostion => _currentCamPos;
  CameraPosition? get getNewCameraPostion => _newCamPosition;
  Set<Marker> get getMarkerSet => _setofmarkers;
  Set<Circle> get getCircleSet => _setofcircles;

  //setters
  CameraPosition setCamPosition(Position currentLoc) {
    if (_newCamPosition == null) {
      return CameraPosition(
        target: LatLng(
          currentLoc.latitude,
          currentLoc.longitude,
        ),
        zoom: kZoom,
        tilt: kTilt,
      );
    } else {
      return _newCamPosition!;
    }
  }

  void setNewCamPosition(LatLng currentLoc) {
    CameraPosition camPos = CameraPosition(
      target: LatLng(
        currentLoc.latitude,
        currentLoc.longitude,
      ),
      zoom: kZoom,
      tilt: kTilt,
    );
    _newCamPosition = camPos;
    Logger().i(_newCamPosition.toString());
  }

  //function to animate camera to new loc
  void animateToLocation(LatLng location) {
    CameraPosition camPos = CameraPosition(
      target: location,
      zoom: kZoom,
      tilt: kTilt,
    );
    mapController!.animateCamera(CameraUpdate.newCameraPosition(camPos));
  }

  //getting markers from database //not being used //could be used
  // Future<void> getMarkersFromDatabase(
  //   DocumentSnapshot document,
  //   BuildContext context,
  // ) async {
  //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //   MarkerModel model = MarkerModel(
  //     markerId: document.id,
  //     uid: data['uid'],
  //     latitude: data['latitude'],
  //     longitude: data['longitude'],
  //     title: data['infoTitle'],
  //     snippet: data['infoSnippet'],
  //   );
  //   await addMarkerToSet(model);
  //   notifyListeners();
  //   Logger().i('New Location ${document.id} Created!');
  // }

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
        title: getTitleController.text,
        snippet: getSnippetController.text,
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
      if (uid != kAnonymous) {
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
          curMarkerModel.title,
          curMarkerModel.snippet,
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
      } else {
        DialogFuncs.alertDialogWithExtraWidgets(
          navigatorKey.currentContext!,
          curMarkerModel!.title,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(curMarkerModel.snippet),
              Text('Login and vote...'),
            ],
          ),
        );
      }
      Logger().v(curMarkerModel.title, curMarkerModel.snippet);
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

  // void increaseNearbyMarkers() {
  //   nearbyMarkersCount++;
  //   notifyListeners();
  // }

  //removing all markers //not being used
  void removeMarkers() {
    getMarkerSet.clear();
    notifyListeners();
  }
}
