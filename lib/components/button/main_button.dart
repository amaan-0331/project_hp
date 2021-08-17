import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {Key? key,
      required this.btnText,
      required this.btnFunc,
      required this.btnWidth,
      this.tagName = ''})
      : super(key: key);

  final String btnText;
  final Function() btnFunc;
  final Object tagName;
  final double btnWidth;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tagName,
      child: ElevatedButton(
        onPressed: btnFunc,
        child: Text(btnText),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(btnWidth, 70),
          // padding:EdgeInsets.symmetric(horizontal: size.width / 8, vertical: 23),
        ),
      ),
    );
  }
}
