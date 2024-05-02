import 'package:flutter/material.dart';

class CardSimple extends StatelessWidget{
  final Color newColorCard;
  final Widget itemWidget;

  const CardSimple({super.key, 
    required this.newColorCard,
    required this.itemWidget,
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
      child: Container(
        padding: const EdgeInsets.all(10),
        child: itemWidget,
      )
    );
  }
}
