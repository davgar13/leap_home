
import 'package:flutter/material.dart';

class AppBarTitleImage extends StatelessWidget {
  const AppBarTitleImage({
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/nameSinBg.png',
        width: 150,
        height: 70,
      ),
    );
  }
}