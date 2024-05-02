import 'package:flutter/painting.dart';

class Colores {
  static const Color primaryColor = Color(0xFF0000CD);
  static const Color darkPrimary = Color.fromARGB(255, 0, 0, 165);
  static const Color azure = Color(0xFF007BFF);
  static const Color argBlue = Color(0xFF63B4FF);
  static const Color lightblue = Color.fromARGB(255, 117, 178, 235);
  static const Color orange = Color(0xFFFFC200);
  static const Color red = Color(0xFFD80000);
  static const Color blackPing = Color(0xFF94265B);
  static const Color lightGrey = Color(0xFFBFBDBC);
  static const Color grey = Color(0xFF8A8A8A);
  static const Color darkGrey = Color(0xFF4A4A4A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color negro = Color(0xFF000000);
  static const Color pageColor = Color(0xFFF4F4F9);
  static const Color teaGreen = Color(0xFFD3FAC7);
  static const Color jet = Color(0xFF39393A);
  static const Color frenchRose = Color(0xFFF44174);


  //DEGRADES LINEAL
  static LinearGradient gradientLinear1 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkPrimary,primaryColor,azure],
  );
  static LinearGradient gradientLinear2 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryColor,azure,argBlue],
  );
  static LinearGradient gradientLinear3 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [azure,argBlue,lightblue],
  );
  //DEGRADES RADIO
  static RadialGradient gradientRadio1 = const RadialGradient(
    radius: 0.9,
    colors: [primaryColor,argBlue],
  );
}