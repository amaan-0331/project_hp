import 'package:flutter/material.dart';

class SecondaryTextButton extends StatelessWidget {
  const SecondaryTextButton(
      {Key? key, required this.btnText, required this.btnFunc})
      : super(key: key);

  final String btnText;
  final Function() btnFunc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnFunc,
      child: Center(
        child: Text(
          btnText,
          // textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      ),
    );
  }
}
