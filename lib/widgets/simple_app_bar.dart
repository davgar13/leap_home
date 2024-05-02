

import 'package:flutter/material.dart';

import 'home/app_bar_title.dart';

class SimpleAppBar extends StatelessWidget{
  final Function onPressedRight;
  final Icon iconRight;
  final Color newColorIcons;
  final Color newColorCard;
  final Color newColorCardTitle;
  final Color newColorSimple;
  final String title;
  final String? subtitle;
  const SimpleAppBar({
    super.key, 
    required this.onPressedRight, 
    required this.iconRight, 
    required this.newColorIcons, 
    required this.newColorCard, 
    required this.newColorSimple, 
    required this.title, 
    this.subtitle, required this.newColorCardTitle, 
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
            child: AppBarTitle(
              newColor: newColorSimple,
              title: title,
              subtitle: subtitle,  
            )
          ),
        ),
        Container(
          width: 50,
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