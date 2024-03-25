import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:leap_home/firebase_options.dart';
import 'package:leap_home/pages/auth/start_page.dart';
import 'package:leap_home/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leap Home',
      theme: ThemeData(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Verifica si el usuario está autenticado
            if (snapshot.hasData) {
              // Usuario autenticado, dirigir a HomePage
              return HomePage();
            } else {
              // Usuario no autenticado, dirigir a StartPage
              return const StartPage();
            }
          }
          // Mientras espera, mostrar un indicador de carga
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
