import 'package:flutter/material.dart';

class ButtonAuth extends StatelessWidget {
  final String text;
  final Color colorBackground;
  final Color colorText;
  final Color? colorBorder;
  final Function()? onPressed;

  const ButtonAuth({super.key, required this.text, required this.onPressed, required this.colorBackground, required this.colorText, this.colorBorder});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: colorBorder ?? Colors.transparent)
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Center(
          child:  Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorText,
            ),
          ),
        ),
      )
    );
  }
}
