import 'package:flutter/painting.dart';

class Colores {
  static const Color primaryColor = Color(0xFF0000CD);
  static const Color azure = Color(0xFF007BFF);
  static const Color argBlue = Color(0xFF63B4FF);
  static const Color orange = Color(0xFFFFC200);
  static const Color blackPing = Color(0xFF94265B);
  static const Color lightGrey = Color(0xFFBFBDBC);
  static const Color grey = Color(0xFF8A8A8A);
  static const Color darkGrey = Color(0xFF4A4A4A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color negro = Color(0xFF000000);

  //DEGRADES LINEAL
  static LinearGradient gradientLinear1 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryColor,azure],
  );
  //DEGRADES RADIO
  static RadialGradient gradientRadio1 = const RadialGradient(
    radius: 0.9,
    colors: [primaryColor,argBlue],
  );
}