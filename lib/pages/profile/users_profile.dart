import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leap_home/models/users_model.dart';

import '../../utils/colors.dart';
import '../../widgets/items/social.card.dart';

class UsersProfilePage extends StatefulWidget {
  final String userId;
  const UsersProfilePage({
    super.key,
    required this.userId,
  });

  @override
  State<UsersProfilePage> createState() => _UsersProfilePageState();
}

class _UsersProfilePageState extends State<UsersProfilePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserModel().getUserDataFormId(widget.userId), 
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 2.0, 
            ) 
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error); 
        } else {
          final data = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('${data['nombre'] ?? 'Nombre desconocido'}'+ ' ' + '${data['apellido'] ?? 'Apellido desconocido'}'),
            ),
            body: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.3,
                    color: Colores.pageColor,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4.6,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: data['portada'] != null ? Image.network(data['portada'], fit: BoxFit.cover) : Image.asset('assets/images/LeapHome_post.png', fit: BoxFit.cover),),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).padding.top * 3.35,
                          left: 20,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(data['image'] ?? 'assets/images/personIcon.png'),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).padding.top * 5.3,
                          left: 140,
                          child: Row(
                            children: [
                              SocialCard(pathImg: 'assets/images/Social/ig.png',),
                              SizedBox(width: 20,),
                              SocialCard(pathImg: 'assets/images/Social/wha.png',),
                              SizedBox(width: 20,),
                              SocialCard(pathImg: 'assets/images/Social/in.png',),
                            ],
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).padding.top * 7,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.business_center_sharp, size: 25, color: Colores.grey,),
                                  SizedBox(width: 5,),
                                  Text('${data['ocupacion'] ?? 'Sin Definir'}', 
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colores.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.people_alt_sharp, size: 25, color: Colores.grey,),
                                  SizedBox(width: 5,),
                                  Text('${data['userType'] ?? 'No Especificado'}', 
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colores.grey),
                                  ),
                                ],
                              )
                            ],
                          )
                        ),
                      ]
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Stack(
                      children: [
                         Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Icon(Icons.pets_rounded, size: 25, color: Colores.negro,)
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Icon(Icons.image_rounded, size: 25, color: Colores.grey,)
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          );
        }
      },
    );
  }
}