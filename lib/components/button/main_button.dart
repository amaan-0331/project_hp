import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {Key? key,
      required this.size,
      required this.btnText,
      required this.btnFunc,
      required this.btnWidth,
      this.tagName = ''})
      : super(key: key);

  final Size size;
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
        child: Text(
          btnText,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
              fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(btnWidth, 70),
          primary: Color(0xff159B80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
