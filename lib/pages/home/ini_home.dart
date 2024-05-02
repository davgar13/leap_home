import 'package:flutter/material.dart';
import 'package:leap_home/widgets/items/item_card_home.dart';

import '../../models/pets_model.dart';
import '../../widgets/carrusel_home.dart';
import '../../widgets/home/title_option.dart';

class IniHome extends StatefulWidget {
  const IniHome({super.key});

  @override
  State<IniHome> createState() => _IniHomeState();
}

class _IniHomeState extends State<IniHome> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: 140,
            color: Colors.black,
          ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: CarouselHome(),
        ),
        Container(
          margin: const EdgeInsets.only(top: 190),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    TitleOption(
                      title: 'Mascotas',
                      redirect: (){
                        setState(() {
                          selectedIndex = 2;  
                        });
                      }
                    ),
                  FutureBuilder(
                    future: PetsModel().getPetsHome(), 
                    builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError){
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: snapshot.data!.map((doc){
                            return ItemCardHome(
                              title: doc['name'],
                              image: doc['imageUrl'],
                              elevation: 5,
                              context: context,
                              idPet: doc['id'],
                            );
                          }).toList(),
                        );
                      }
                    }
                  ),
                  const SizedBox(height: 15),
                    TitleOption(
                      title: 'Albergues',
                      redirect: () {
                        setState(() {
                          selectedIndex = 3;  
                        });
                      }, 
                    ),
                  ]
                ),
              ),
            ]
          )
        ),
      ],
    );
  }
}