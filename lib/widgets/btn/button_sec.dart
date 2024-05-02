import 'package:flutter/material.dart';

class ButtonSec extends StatelessWidget {
  final String textValue;
  final Function() onPressed;
  final Color newColor;
  final Color fontColor;
  final Color? borderColor;
  final double height;
  final double fontSize;
  final double borderTopLeftRadius;
  final double borderTopRightRadius;
  final double borderBottomLeftRadius;
  final double borderBottomRightRadius;
  const ButtonSec({
    super.key, 
    required this.textValue, 
    required this.onPressed, 
    required this.newColor, 
    required this.fontColor,
    required this.height, 
    required this.fontSize,
    required this.borderTopLeftRadius,
    required this.borderTopRightRadius,
    required this.borderBottomLeftRadius,
    required this.borderBottomRightRadius,
    this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 140,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: newColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderTopLeftRadius),
              topRight: Radius.circular(borderTopRightRadius),
              bottomLeft: Radius.circular(borderBottomLeftRadius),
              bottomRight: Radius.circular(borderBottomRightRadius)
            
            ),
            side: BorderSide(color: borderColor ?? Colors.transparent) 
          )
        ),
        child: Text(
          textValue,
          style: TextStyle(
            color: fontColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold
          ),
        ),
      )
    );
  }
}

