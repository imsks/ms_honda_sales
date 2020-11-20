import 'dart:ui';
import 'package:ms_honda_sales/utilities/constants/styles.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final Function validator;
  final String initialValue;
  final bool choice;

  const InputTextField({
    @required this.hintText,
    @required this.onChanged,
    @required this.validator,
    @required this.choice,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      textAlign: TextAlign.start,
      style: AppTheme.inputTextStyle,
      decoration:
          AppTheme.inputTextFieldDecoration.copyWith(hintText: hintText),
      obscureText: choice,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
