

import 'package:flutter/material.dart';
import 'package:leap_home/widgets/home/app_bar_title_image.dart';

class SimpleAppBarImage extends StatelessWidget{
  final Function onPressedRight;
  final Icon iconRight;
  final Color newColorIcons;
  final Color newColorCard;
  final Color newColorCardTitle;
  final Color newColorSimple;
  const SimpleAppBarImage({
    super.key, 
    required this.onPressedRight, 
    required this.iconRight, 
    required this.newColorIcons, 
    required this.newColorCard, 
    required this.newColorSimple,
    required this.newColorCardTitle, 
    });
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 38),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.5,
            height: 45,
            decoration: BoxDecoration(
              color: newColorCardTitle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AppBarTitleImage(),
          ),
        ),
        Container(
          width: 40,
          height: 50,
          margin: const EdgeInsets.only(top: 34, left: 20),
          child: Card(
            color: newColorCard,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              color: newColorIcons,
            )
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(top: 34, right: 20),
            child: Card(
              color: newColorCard,
              child: IconButton(
                onPressed: () {
                  onPressedRight;
                },
                icon: iconRight,
                color: newColorIcons,
              )
            ),
          ),
        )
      ],
    );
  }
}