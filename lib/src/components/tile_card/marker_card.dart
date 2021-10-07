import 'package:flutter/material.dart';
import 'package:project_hp/src/components/shadow/boxShadow.dart';
import 'package:project_hp/src/models/map_marker_model.dart';
import 'package:project_hp/src/utils/constants.dart';

class MarkerCard extends StatelessWidget {
  const MarkerCard({
    Key? key,
    required this.marker,
    required this.proximity,
    required this.function,
  }) : super(key: key);

  final MarkerModel marker;
  final double proximity;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [boxShadow()],
        ),
        child: ListTile(
          onTap: function,
          leading: Icon(
            Icons.location_pin,
            size: 40,
          ),
          title: Text(marker.title),
          subtitle: Text(marker.snippet),
          trailing: (proximity < 10000)
              ? Text(proximity.round().toString() + 'm')
              : Text((proximity / 1000).round().toString() + 'km'),
        ),
      ),
    );
  }
}
