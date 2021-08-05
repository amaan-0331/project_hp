import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key? key,
      required this.hintText,
      required this.lblText,
      this.inputLines,
      this.onChangedFunc,
      this.inputController,
      this.inputType,
      this.validatorFunc,
      this.obscure = false})
      : super(key: key);
  final String lblText;
  final String hintText;
  final int? inputLines;
  final Function? onChangedFunc;
  final TextEditingController? inputController;
  final String Function(String)? validatorFunc;
  final TextInputType? inputType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    int? _maxlines;
    if (inputLines == null) {
      _maxlines = 1;
    } else {
      _maxlines = inputLines;
    }
    return TextFormField(
      // validator: validatorFunc,
      // onChanged: onChangedFunc,
      obscureText: obscure,
      keyboardType: inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: inputController,
      maxLines: _maxlines,
      decoration: InputDecoration(
          labelText: lblText.toUpperCase(),
          labelStyle:
              TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold),
          hintText: hintText,
          fillColor: Color(0xffD4D3E3),
          filled: true,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(20),
          // )
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.transparent))),
    );
  }
}
