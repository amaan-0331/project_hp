import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_hp/src/components/after_list/after_list_elements.dart';
import 'package:project_hp/src/components/tile_card/marker_card.dart';
import 'package:project_hp/src/controllers/database_controller.dart';
import 'package:project_hp/src/models/map_marker_model.dart';
import 'package:project_hp/src/models/user_model.dart';
import 'package:project_hp/src/providers/map_provider/location_provider.dart';
import 'package:project_hp/src/providers/navigator_provider/navigator_provider.dart';
import 'package:project_hp/src/utils/functions.dart';
import 'package:provider/provider.dart';

class UpvotedMarkers extends StatelessWidget {
  const UpvotedMarkers({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Position _currentLoc = Provider.of<LocationProvider>(context).getCurrentLocation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upvoted Markers',
          style: Theme.of(context).textTheme.headline2,
        ),
        leading: IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: user.upVotedlist.length + 1,
        itemBuilder: (context, index) {
          if (index == user.upVotedlist.length) {
            return (user.upVotedlist.length == 0)
                ? showNoMarkers(
                    context,
                    size,
                    'You can Upvote your \nFavorite tags!',
                    'Start Upvoting! 😇',
                    () {
                      Provider.of<NavigatorProvider>(context, listen: false)
                          .setCurrentScreenIndex(1);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  )
                : showAftrerMarkers(context, size);
          }
          return FutureBuilder<MarkerModel?>(
            future: DatabaseController().getCurrentMarkerDetails(user.upVotedlist[index]),
            builder: (context, snapshot) {
              MarkerModel? marker = snapshot.data;
              if (snapshot.hasData) {
                double proximity = MarkerViewFuncs().proximityFinder(_currentLoc, marker!);
                return MarkerCard(
                  marker: marker,
                  proximity: proximity,
                  function: () {
                    MarkerViewFuncs().openInMapMethod(context, marker);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                );
              } else {
                return SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
