import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_hp/src/components/button/text_button.dart';
import 'package:project_hp/src/utils/constants.dart';

Column showNoMarkers(
  BuildContext context,
  Size size,
  String content,
  String btnText,
  Function() btnFunc,
) {
  return Column(
    children: [
      SizedBox(height: size.height / 4),
      Lottie.asset(
        'assets/lottie/empty.json',
        errorBuilder: (context, error, stackTrace) => SizedBox(),
        width: size.width / 1.5,
      ),
      SizedBox(height: kDefaultPadding * 2),
      Text(
        content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline3,
      ),
      TextOnlyButton(
        btnText: btnText,
        btnFunc: btnFunc,
      ),
      SizedBox(height: size.height / 4),
    ],
  );
}

Column showAftrerMarkers(BuildContext context, Size size) {
  return Column(
    children: [
      SizedBox(height: size.height / 10),
      Lottie.asset(
        'assets/lottie/done.json',
        errorBuilder: (context, error, stackTrace) => SizedBox(),
        width: size.width / 1.5,
        repeat: false,
      ),
    ],
  );
}
