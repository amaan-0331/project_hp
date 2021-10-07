import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_hp/src/components/after_list/after_list_elements.dart';
import 'package:project_hp/src/components/tile_card/marker_card.dart';
import 'package:project_hp/src/controllers/database_controller.dart';
import 'package:project_hp/src/models/map_marker_model.dart';
import 'package:project_hp/src/models/user_model.dart';
import 'package:project_hp/src/providers/map_provider/location_provider.dart';
import 'package:project_hp/src/utils/functions.dart';
import 'package:provider/provider.dart';

class UserMarkers extends StatelessWidget {
  const UserMarkers({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Position _currentLoc =
        Provider.of<LocationProvider>(context).getCurrentLocation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Markers',
          style: Theme.of(context).textTheme.headline2,
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: user.userMarkers.length + 1,
        itemBuilder: (context, index) {
          if (index == user.userMarkers.length) {
            return (user.userMarkers.length == 0)
                ? showNoMarkers(
                    context, size, 'You Haven\'t Shared any Tags yet!')
                : showAftrerMarkers(context, size);
          }

          return FutureBuilder<MarkerModel?>(
            future: DatabaseController()
                .getCurrentMarkerDetails(user.userMarkers[index]),
            builder: (context, snapshot) {
              MarkerModel? marker = snapshot.data;
              if (snapshot.hasData) {
                double proximity =
                    MarkerViewFuncs().proximityFinder(_currentLoc, marker!);
                return MarkerCard(
                  marker: marker,
                  proximity: proximity,
                  function: () {
                    MarkerViewFuncs().openInMapMethod(context, marker);
                    Navigator.pop(context);
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
