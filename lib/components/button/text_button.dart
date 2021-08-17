import 'package:flutter/material.dart';

class TextOnlyButton extends StatelessWidget {
  const TextOnlyButton({
    Key? key,
    required this.btnText,
    required this.btnFunc,
    this.tagName = '',
  }) : super(key: key);

  final String btnText, tagName;
  final Function() btnFunc;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: tagName,
        child: Center(
          child: TextButton(
            child: Text(btnText),
            onPressed: btnFunc,
          ),
        ));
  }
}
