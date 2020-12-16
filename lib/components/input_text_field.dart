import 'package:flutter/material.dart';
import 'package:ms_honda_sales/utilities/constants/styles.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final Function validator;
  final String initialValue;
  final bool choice;
  final TextInputType type;

  const InputTextField({
    @required this.hintText,
    @required this.onChanged,
    @required this.validator,
    @required this.choice,
    this.type,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
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
