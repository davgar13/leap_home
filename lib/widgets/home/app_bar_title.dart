
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final Color newColor;
  final String title;
  final String? subtitle;
  const AppBarTitle({super.key, required this.newColor, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: newColor,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle ?? '',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: newColor,
            ),
          ),
        ],
      )
    );
  }
}