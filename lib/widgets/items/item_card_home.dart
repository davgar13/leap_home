
import 'package:flutter/material.dart';
import 'package:leap_home/utils/colors.dart';

import '../../pages/others/pet_info_page.dart';


class ItemCardHome extends StatelessWidget{
  final String title;
  final String image;
  final String? idPet;
  final String? idHome;
  final double elevation;
  final BuildContext context;
  
  const ItemCardHome({
    super.key, 
    required this.title, 
    required this.image,
    this.idPet, 
    required this.elevation,  
    this.idHome, 
    required this.context, 
  });

  void redir() {
    if (idPet != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PetInfoPage(petInfoID: idPet!),
        ),
      );
    } /*else if (idSer != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServiceInfoPage(serviceId: idSer!),
        ),
      );
    }*/
  }
   
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        redir();
      },
      child: Column(
        children: [ 
          Container(
            width: 105,
            height: 105,
            child: Card(
              margin: const EdgeInsets.all(8),
              elevation: elevation,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              color: Colores.grey,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child:
                  Image(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  )
                ),
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      )
    );
  }
}