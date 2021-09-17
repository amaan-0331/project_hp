import 'package:flutter/material.dart';

class IconOnlyButton extends StatelessWidget {
  const IconOnlyButton({
    Key? key,
    required this.btnIcon,
    required this.btnFunc,
    required this.btnHeight,
    required this.btnColor,
    this.tagName = '',
  }) : super(key: key);

  final Icon btnIcon;
  final Function() btnFunc;
  final Object tagName;
  final double btnHeight;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tagName,
      child: ElevatedButton(
        onPressed: btnFunc,
        child: btnIcon,
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          shape: CircleBorder(),
          padding: EdgeInsets.symmetric(vertical: btnHeight),
        ),
      ),
    );
  }
}
