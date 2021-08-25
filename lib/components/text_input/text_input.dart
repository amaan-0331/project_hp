import 'package:flutter/material.dart';

class FormTextInput extends StatelessWidget {
  const FormTextInput({
    Key? key,
    required this.lblText,
    this.hintText,
    this.inputLines,
    this.onChangedFunc,
    this.inputController,
    this.inputType,
    this.validatorFunc,
    this.obscure = false,
  }) : super(key: key);
  final String lblText;
  final String? hintText;
  final int? inputLines;
  final Function? onChangedFunc;
  final TextEditingController? inputController;
  final String? Function(String?)? validatorFunc;
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
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: Color(0xffD4D3E3), borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: TextFormField(
          validator: validatorFunc,
          obscureText: obscure,
          keyboardType: inputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: inputController,
          maxLines: _maxlines,
          decoration: InputDecoration(
            labelText: lblText.toUpperCase(),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}

class NormalTextInput extends StatelessWidget {
  const NormalTextInput({
    Key? key,
    required this.lblText,
    this.hintText,
    this.inputLines,
    this.onChangedFunc,
    this.inputController,
    this.inputType,
    this.obscure = false,
  }) : super(key: key);
  final String lblText;
  final String? hintText;
  final int? inputLines;
  final Function? onChangedFunc;
  final TextEditingController? inputController;
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
    return TextField(
      obscureText: obscure,
      keyboardType: inputType,
      controller: inputController,
      maxLines: _maxlines,
      decoration: InputDecoration(
        labelText: lblText.toUpperCase(),
        hintText: hintText,
      ),
    );
  }
}
