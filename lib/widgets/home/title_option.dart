import 'package:flutter/material.dart';

class TitleOption extends StatelessWidget{
  final String title;
  final Function()? redirect;
  const TitleOption({super.key, required this.title, this.redirect, });

  @override
  Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: redirect,
            child: const Text(
              'Sugerencias',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
  }
}