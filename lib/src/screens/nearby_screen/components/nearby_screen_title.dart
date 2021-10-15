import 'package:flutter/material.dart';
import 'package:project_hp/src/utils/constants.dart';

class NearbyScreenTitle extends StatelessWidget {
  const NearbyScreenTitle({
    Key? key,
    required this.size,
    required this.title,
  }) : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: kDefaultPadding * 2, left: kDefaultPadding * 1.5),
          width: size.width,
          child: Text(title, style: Theme.of(context).textTheme.headline6),
        ),
      ),
    );
  }
}
