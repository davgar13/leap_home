import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/home/app_bar_title.dart';
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
          title: const AppBarTitle(
            newColor: Colors.white,
            title: 'LeapHome',
            subtitle: 'Creandores de estilo',
          ),
          leading: AppBarIconProfile(),
      ),
      endDrawer: const BurgerMenu(),
      backgroundColor: Colores.white,
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
              icon: Icon(Icons.content_cut_outlined ),
              label: 'Mascotas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopify_rounded),
              label: 'Categorías',
            ),
            
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.white,
          onTap: onItemTapped,
        ),
      ),
      body: 
        widgetOptions.elementAt(selectedIndex),
    );
  }
}