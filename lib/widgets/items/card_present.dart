import 'package:flutter/material.dart';

class CardPresent extends StatelessWidget{
  final Color newColorCard;
  final String title;
  final Color newColorTitle;
  final String subtitle;
  final Color newColorSubtitle;

  const CardPresent({super.key, 
    required this.newColorCard, 
    required this.title, 
    required this.newColorTitle, 
    required this.subtitle, 
    required this.newColorSubtitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: newColorCard,
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: newColorTitle,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: newColorSubtitle,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      )
    );
  }
}
