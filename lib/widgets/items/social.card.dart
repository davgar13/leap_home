import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class SocialCard extends StatelessWidget {
  final String pathImg;
  const SocialCard({
    super.key,
    required this.pathImg,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colores.negro
      ),
      width: 50,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Image.asset(pathImg, fit: BoxFit.cover),
      )
    );
  }
}