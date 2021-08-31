import 'package:flutter/material.dart';
import 'package:project_hp/utils/constants.dart';

class MarkerCard extends StatelessWidget {
  const MarkerCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(9, 8),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            Icons.location_pin,
            size: 40,
          ),
          title: Text(data['title']),
          subtitle: Text(data['snippet']),
        ),
      ),
    );
  }
}
