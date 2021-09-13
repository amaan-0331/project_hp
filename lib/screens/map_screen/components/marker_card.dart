import 'package:flutter/material.dart';
import 'package:project_hp/components/shadow/boxShadow.dart';
import 'package:project_hp/utils/constants.dart';

class MarkerCard extends StatelessWidget {
  const MarkerCard({
    Key? key,
    required this.data,
    required this.func,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final Function func;

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
          leading: Icon(
            Icons.location_pin,
            size: 40,
          ),
          title: Text(data['title']),
          subtitle: Text(data['snippet']),
          onTap: func(),
        ),
      ),
    );
  }
}
