import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_hp/src/utils/constants.dart';

Column showNoMarkers(BuildContext context, Size size, String content) {
  return Column(
    children: [
      SizedBox(
        height: size.height / 4,
      ),
      Lottie.network(
        'https://assets3.lottiefiles.com/private_files/lf30_bn5winlb.json',
        errorBuilder: (context, error, stackTrace) => SizedBox(),
        width: size.width / 1.5,
      ),
      SizedBox(height: kDefaultPadding * 2),
      Text(
        content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
    ],
  );
}

Column showAftrerMarkers(BuildContext context, Size size) {
  return Column(
    children: [
      // SizedBox(height: size.height / 10),
      Lottie.network(
        'https://assets1.lottiefiles.com/private_files/lf30_z1sghrbu.json',
        errorBuilder: (context, error, stackTrace) => SizedBox(),
        height: size.height / 2,
        width: size.width / 2,
        repeat: true,
      ),
    ],
  );
}
