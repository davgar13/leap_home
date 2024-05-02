import 'package:flutter/material.dart';
import 'package:leap_home/utils/colors.dart';

class FormSelect extends StatelessWidget {
  final String campoTexto;
  final List itemsFormSelect;
  final TextEditingController controller;
  
  const FormSelect({Key? key, required this.itemsFormSelect, required this.controller, required this.campoTexto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: campoTexto,
        labelStyle: const TextStyle(
          color: Colors.black, 
          fontSize: 15, 
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
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
      items:  itemsFormSelect.map<DropdownMenuItem<String>>((e){
          return DropdownMenuItem<String>(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                e,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            value: e,
          );
        }).toList(),
      onChanged: (String? value) {
        controller.text = value!;
      },
      isDense: true,
      isExpanded: true,
    );
  }
}