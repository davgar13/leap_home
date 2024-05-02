import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leap_home/pages/auth/register_dates_screen.dart';
import 'package:leap_home/widgets/return_page.dart';

import '../../utils/colors.dart';
import '../../widgets/btn/button_auth.dart';
import '../home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );  
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores.negro,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 570,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: Colores.gradientRadio1,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 25,),
                Container(
                  margin: const EdgeInsets.all(22),
                  alignment: Alignment.centerLeft,
                  child: ReturnPage(
                    colorBackground: Colors.black.withOpacity(0.8), 
                    colorIcon: Colores.azure
                  ),
                ),
                const SizedBox(height: 60,),
                const Text(
                  '¡BIENVENIDO\nDE NUEVO!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 50,),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  margin: const EdgeInsets.all(20),
                  child: Form(
                      child:Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Correo',
                              hintText: 'Ingrese su correo',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) => value!.isEmpty ? 'Ingrese su correo' : null,
                            controller: emailController,
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              hintText: 'Ingrese su contraseña',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                            validator: (value) => value!.isEmpty ? 'Ingrese su contraseña' : null,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 20),
                          ButtonAuth(
                            text: 'Ingresar',
                            onPressed: () {
                              login();
                            },
                            colorBackground: Colores.azure,
                            colorText: Colors.black,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('¿No tienes una cuenta?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const RegisterDatesScreen()),
                                  );
                                },
                                child: const Text('Regístrate'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) 
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}