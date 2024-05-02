
import 'package:flutter/material.dart';
import 'package:leap_home/utils/colors.dart';

import '../../models/users_model.dart';
import '../../pages/options/add_adopt_pets.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    gradient: Colores.gradientLinear2,
                  ),
                  alignment: Alignment.bottomCenter,
                  height: 120,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: const ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/icon/IconNormal.png',),
                    ),
                    title: Text(
                      'Más que Mascotas,\nSon Familia',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 5,
                    left: 15,
                  ),
                  child: const Text(
                    'Opciones de Generales',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                  thickness: 1.5,
                  indent: 15,
                  endIndent: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: Image(
                      image: AssetImage(
                        'assets/images/addPet.png',
                        ),
                        width: 33,
                        height: 33,
                      ),
                    title: const Text('Dar en Adopción'),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const AddAdoptPets(),
                        ),
                      );
                    },
                  ),
                ),
                
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Contacto'),
                    onTap: () {
                      // Acción al pulsar la opción
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: const Icon(Icons.location_on_sharp),
                    title: const Text('Ubicación'),
                    onTap: () {
                      // Acción al pulsar la opción
                    },
                  ),
                ),
                
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 5,
                    left: 15,
                  ),
                  child: const Text(
                    'Opciones de Configuración',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                  thickness: 1.5,
                  indent: 15,
                  endIndent: 10,
                ),

                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Configuración'),
                    onTap: () {
                      /*Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const OptionsSistem(),
                        ),
                      );*/
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: ListTile(
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      UserModel().signOut(context);
                    },
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.bottomCenter,
                child: const Text(
                  'Versión 1.0.0 by @davgarciab',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),  
        ],
      )
    );
  }
}