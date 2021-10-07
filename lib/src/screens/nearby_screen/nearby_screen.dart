import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:project_hp/src/components/after_list/after_list_elements.dart';
import 'package:project_hp/src/components/temp_screen/temp_screen.dart';
import 'package:project_hp/src/components/tile_card/marker_card.dart';
import 'package:project_hp/src/controllers/database_controller.dart';
import 'package:project_hp/src/models/map_marker_model.dart';
import 'package:project_hp/src/providers/map_provider/location_provider.dart';
import 'package:project_hp/src/providers/map_provider/map_screen_provider.dart';
import 'package:project_hp/src/screens/map_screen/components/home_screen_title.dart';
import 'package:project_hp/src/utils/constants.dart';
import 'package:project_hp/src/utils/functions.dart';
import 'package:provider/provider.dart';

// FIXME: finish this
class NearByScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HomeScreenTitle(size: size, title: 'Nearby Feed'),
            NearByFeed(size: size),
          ],
        ),
      ),
    );
  }
}

class NearByFeed extends StatefulWidget {
  const NearByFeed({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<NearByFeed> createState() => _NearByFeedState();
}

class _NearByFeedState extends State<NearByFeed> {
  @override
  Widget build(BuildContext context) {
    Position _currentLoc =
        Provider.of<LocationProvider>(context).getCurrentLocation;
    return Consumer<MapScreenProvider>(
      builder: (context, value, child) {
        return Container(
          height: widget.size.height * 0.75,
          child: StreamBuilder<QuerySnapshot>(
            stream: DatabaseController().markerStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return TempScreen(
                    size: widget.size, message: 'Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return TempScreen(size: widget.size, message: "Loading");
              }
              int nearbyMarkersCount = 0;
              List<Widget> listItems = [];
              listItems.addAll(snapshot.data!.docs.map(
                (DocumentSnapshot document) {
                  MarkerModel currentMarker = DatabaseController()
                      .processDataFromStreambuilder(context, document);
                  double proximity = MarkerViewFuncs()
                      .proximityFinder(_currentLoc, currentMarker);
                  if (proximity < kCheckDistance) {
                    nearbyMarkersCount++;
                    return MarkerCard(
                      marker: currentMarker,
                      proximity: proximity,
                      function: () => MarkerViewFuncs()
                          .openInMapMethod(context, currentMarker),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ).toList());
              listItems.add(SizedBox());

              return ListView.separated(
                itemCount: listItems.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return listItems[index];
                },
                separatorBuilder: (BuildContext context, int index) {
                  Logger()
                      .d(listItems.length.toString() + ',' + index.toString());
                  if (index == listItems.length - 2) {
                    return (nearbyMarkersCount > 0)
                        ? showAftrerMarkers(context, widget.size)
                        : showNoMarkers(context, widget.size,
                            'No Tags Near You!\nBut you can Share!');
                  } else {
                    return SizedBox();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
