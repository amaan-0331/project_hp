import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {Key? key,
      required this.size,
      required this.btnText,
      required this.btnFunc,
      this.tagName = ''})
      : super(key: key);

  final Size size;
  final String btnText;
  final Function() btnFunc;
  final Object tagName;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tagName,
      child: ElevatedButton(
        onPressed: btnFunc,
        child: Text(btnText),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(size.width, 70),
          padding:
              EdgeInsets.symmetric(horizontal: size.width / 8, vertical: 23),
        ),
      ),
    );
  }
}
