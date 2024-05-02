import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String textValue;
  final Function() onPressed;
  final Color newColor;
  final Color fontColor;
  final Color? borderColor ;

  const ButtonPrimary({super.key, required this.textValue, required this.onPressed, required this.newColor, required this.fontColor, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 140,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: newColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: borderColor ?? Colors.transparent) 
          )
        ),
        child: Text(
          textValue,
          style: TextStyle(
            color: fontColor,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      )
    );
  }
}

