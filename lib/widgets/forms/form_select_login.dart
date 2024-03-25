import 'package:flutter/material.dart';

class FormSelectLogin extends StatelessWidget {
  final TextEditingController formController;
  final String labelText;
  final IconData icon;
  final List<String> formList;
  
  const FormSelectLogin({
    super.key,
    required this.formController,
    required this.labelText,
    required this.icon,
    required this.formList
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),
      items:  formList.map<DropdownMenuItem<String>>((e){
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
        formController.text = value!;
      },
      isDense: true,
      isExpanded: true,
    );
  }
}