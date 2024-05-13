import 'package:cloud_firestore/cloud_firestore.dart';  
import 'package:flutter/material.dart';
import 'package:leap_home/pages/others/adop_form.dart';
import 'package:leap_home/widgets/btn/button_sec.dart';
import 'package:leap_home/widgets/items/card_simple.dart';
import 'package:leap_home/widgets/items/user_present.dart';

import '../../models/users_model.dart';
import '../../utils/colors.dart';
import '../../widgets/items/card_present.dart';

class PetInfoPage extends StatefulWidget {
  final String petInfoID;
  final String ownerId;
  const PetInfoPage({
    super.key, 
    required this.petInfoID,
    required this.ownerId
  });

  @override
  State<PetInfoPage> createState() => _PetInfoPageState();
}

class _PetInfoPageState extends State<PetInfoPage> {
  late Future<DocumentSnapshot> futureService;
  late Future<String> dateUser;

  @override
  void initState() {
    super.initState();
    futureService = FirebaseFirestore.instance.collection('Pet_Person').doc(widget.petInfoID).get();
    dateUser = UserModel().getUserEmailFormId(widget.ownerId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: futureService,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
      } else { 
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          String genero = data['gen'];
          Color colorGen = genero == 'Macho' ? Colores.azure : Colores.frenchRose;
          return Scaffold(
            body: Stack(
              children: [
                Image.network(
                  data['imageUrl'],
                  width: double.infinity,
                  height: 360,
                  fit: BoxFit.cover,
                ),
                
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 450,
                    margin: const EdgeInsets.only(top: 270),
                    decoration: BoxDecoration(
                      color: colorGen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)
                      )
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [ 
                              Container(
                                margin: const EdgeInsets.only(left: 20, top: 20),
                                child: Text(
                                  '${data['name']}'.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colores.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: FutureBuilder<String>(
                                  future: dateUser,
                                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Container(
                                        margin: const EdgeInsets.only(right: 20, top: 20),
                                        child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: ButtonSec(
                                              textValue: 'Adoptar', 
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AdoptionFormScreen(ownerEmail: snapshot.data!)));
                                                print(snapshot.data!);
                                              }, 
                                              newColor: Colors.white, 
                                              fontColor: Colors.black, 
                                              height: 35, 
                                              fontSize: 20, 
                                              borderTopLeftRadius: 10, 
                                              borderTopRightRadius: 20, 
                                              borderBottomLeftRadius: 20, 
                                              borderBottomRightRadius: 10)
                                          )
                                        );
                                    }
                                  }
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text(
                                  '${data['type']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text(
                                  'Aquí va el tipo de raza',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.black.withOpacity(0.8),
                            thickness: 1.5,
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Aserca de ${data['name']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          /*CardSimple(
                            newColorCard: Colores.negro.withOpacity(0.8), 
                            itemWidget: 
                          ),*/
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 17,),
                              const Icon(
                                Icons.lens,
                                color: Colores.orange,
                                size: 10,
                              ),
                              const SizedBox(width: 17,),
                              Text('${data['gen']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13
                                ),
                              )
                            ]
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 17,),
                              const Icon(
                                Icons.lens,
                                color: Colores.orange,
                                size: 10,
                              ),
                              const SizedBox(width: 17,),
                              Text('${data['isVacunated']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13
                                ),
                              )
                            ]
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 17,),
                              const Icon(
                                Icons.lens,
                                color: Colores.orange,
                                size: 10,
                              ),
                              const SizedBox(width: 17,),
                              Text('${data['isVacunated']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13
                                ),
                              )
                            ]
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 17,),
                              const Icon(
                                Icons.lens,
                                color: Colores.orange,
                                size: 10,
                              ),
                              const SizedBox(width: 17,),
                              Text('${data['isVacunated']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13  
                                ),
                              )
                            ]
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 17,),
                              const Icon(
                                Icons.lens,
                                color: Colores.orange,
                                size: 10,
                              ),
                              const SizedBox(width: 17,),
                              Text('${data['isVacunated']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13
                                ),
                              )
                            ]
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CardSimple(
                            newColorCard: Colores.negro.withOpacity(0.8), 
                             itemWidget: UserPresent(
                              userId: data['idPerson'],
                              nameColor: Colors.white,
                              userTypeColor: Colores.grey,  
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                         CardPresent(
                            newColorCard: Colores.negro.withOpacity(0.8), 
                            title: 'Descripcion: ', 
                            newColorTitle: Colores.white, 
                            subtitle: '${data['description']}', 
                            newColorSubtitle: Colors.white, 
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    )
                  ),
                )
              ],
            )
          );
        }
      },
    );
  }
}