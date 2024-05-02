
import 'package:flutter/material.dart';

class FormTextArea extends StatelessWidget {
  final int numLineas;
  final Color campoTextoColor;
  final Color bordeColor;
  final Color focusColor;
  final Color fillColor;
  final Color textColor;
  final String campoTexto;
  final TextEditingController controller;

  const FormTextArea({
    Key? key, 
    required this.campoTexto, 
    required this.controller, 
    required this.numLineas, 
    required this.campoTextoColor, 
    required this.bordeColor, 
    required this.focusColor, 
    required this.fillColor, 
    required this.textColor
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: textColor, 
        fontSize: 17, 
      ),
      minLines: numLineas, 
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: controller,
      decoration: InputDecoration(
        labelText: campoTexto,
        labelStyle: TextStyle(
          color: campoTextoColor, 
          fontSize: 15, 
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: bordeColor, 
            width: 2, 
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: focusColor, 
            width: 2, 
          ),
        ),
        filled: true, 
        fillColor: fillColor, 
      ),
    );
  }
}