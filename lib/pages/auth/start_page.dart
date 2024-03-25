import 'package:flutter/material.dart';
import 'package:leap_home/pages/auth/register_dates_screen.dart';
import 'package:leap_home/pages/auth/login_screen.dart';

import '../../utils/colors.dart';
import '../../widgets/button_auth.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores.primaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 570,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
              ),
            ),
            Column(
              children: [ 
                const SizedBox(height: 150),
                Center(
                  child: Container(
                    height: 265,
                    width: double.infinity,
                    //color: Colores.primaryColor,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icon/iconSinBg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  '¡BIENVENIDO!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  color: Colors.black,
                  margin: const EdgeInsets.all(20),
                  child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ButtonAuth(
                            text: 'Crear Nueva Cuenta', 
                            onPressed: () => Navigator.push(context, 
                              MaterialPageRoute(
                                builder: (context) => const RegisterDatesScreen()
                                )
                              ),
                            colorBackground: Colors.white, 
                            colorText: Colors.black,
                          ),
                          const SizedBox(height: 5,),
                            Divider(
                              color: Colors.white.withOpacity(0.8),
                              thickness: 1.5,
                            ),
                          const SizedBox(height: 5,),
                          ButtonAuth(
                            text: 'Iniciar Sesión', 
                            onPressed: () => Navigator.push(context, 
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen()
                                )
                              ),
                            colorBackground: Colors.black, 
                            colorText: Colors.white,
                            colorBorder: Colors.white,
                          ),
                        ],
                      ),
                  )
                ),
              ],
            ),  
          ],
        ),
      ),
    );
  }
}