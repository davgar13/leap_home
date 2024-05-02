
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class FormAdd extends StatelessWidget {
  final String campoTexto;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const FormAdd({
    Key? key, 
    required this.campoTexto, 
    required this.controller,
    required this.keyboardType,
    this.validator,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: campoTexto,
        labelStyle: const TextStyle(
          color: Colors.black, 
          fontSize: 15, 
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colores.primaryColor, 
            width: 2, 
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.black, 
            width: 2, 
          ),
        ),
        filled: true, 
        fillColor: Colors.white.withOpacity(0.8), 
      ),
      validator: validator,
    );
  }
}