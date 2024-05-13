import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leap_home/pages/home/category.dart';
import 'package:leap_home/pages/home/ini_home.dart';
import 'package:leap_home/pages/home/pets.dart';
import 'package:leap_home/pages/profile/my_profile.dart';
import 'package:leap_home/widgets/home/app_bar_title_image.dart';

import '../utils/colors.dart';
import '../widgets/home/appbar_icon_profile.dart';
import '../widgets/home/burger_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

final List<Widget> widgetOptions = <Widget>[
  const IniHome(),
  const PetsPage(),
  const CategoryPage(),
];

void onItemTapped(int index) {
  setState(() {
    selectedIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const AppBarTitleImage(),
          leading: AppBarIconProfile(
            onPressed: () => Navigator.push(context, 
                MaterialPageRoute(builder: (context) => MyProfilePage(
                  userId: FirebaseAuth.instance.currentUser!.uid,
                ),
              )
            ),
          ),
      ),
      endDrawer: const BurgerMenu(),
      backgroundColor: Colores.pageColor,
      bottomNavigationBar:Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black, // Cambia el color de fondo aquí
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pets_rounded),
              label: 'Mascotas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Categorías',
            ),
            
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colores.azure,
          unselectedItemColor: Colors.white,
          onTap: onItemTapped,
          selectedFontSize: 15,
          selectedIconTheme: IconThemeData(size: 30),
        ),
      ),
      body: 
        widgetOptions.elementAt(selectedIndex),
    );
  }
}