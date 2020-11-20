import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    @required this.buttonTitle,

    @required this.buttonColor,
    @required this.buttonTextColor,
    @required this.buttonTextSize,
    @required this.onPressed,
    this.minimumWidth,
    this.height,
  });
  final String buttonTitle;
  
  final double minimumWidth;
  final double height;
  final Color buttonColor;
  final Color buttonTextColor;
  final double buttonTextSize;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minimumWidth,
      height: height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black87, width: 2),
        ),
        child: Text(
          buttonTitle,
          style: TextStyle(
            color: buttonTextColor,
            fontWeight: FontWeight.w600,
            fontSize: buttonTextSize,
          ),
        ),
        onPressed: onPressed,
        color: buttonColor,
      ),
    );
  }
}
