import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as p;

import '../../utils/colors.dart';
import '../../widgets/button_auth.dart';
import '../../widgets/return_page.dart';
import '../home_page.dart';

class RegisterScreen extends StatefulWidget {
  final TextEditingController nameUser;
  final TextEditingController lastNameUser;
  final TextEditingController birthDateUser;
  final TextEditingController sexUser;
  final TextEditingController phoneUser;
  final TextEditingController typeUser;
  final File? imageUser;
  
  const RegisterScreen( 
    {Key? key, 
    required this.nameUser, 
    required this.lastNameUser, 
    required this.birthDateUser, 
    required this.sexUser, 
    required this.phoneUser, 
    this.imageUser, 
    required this.typeUser, 
    }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<String> _uploadImageAndGetDownloadUrl(File imageFile) async {
    String fileName = p.basename(widget.imageUser!.path);
    final ref = FirebaseStorage.instance.ref().child('Users/$fileName');
    await ref.putFile(imageFile);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      try {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();
        String confirmPassword = confirmPasswordController.text.trim();

        if (password != confirmPassword) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Las contraseñas no coinciden'),
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
        } else {
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          final currentUser = FirebaseAuth.instance.currentUser;
          final imageUrl = await _uploadImageAndGetDownloadUrl(widget.imageUser!);
          
          await FirebaseFirestore.instance.collection('Usuarios').doc(currentUser!.uid).set({
            'nombre': widget.nameUser.text,
            'apellido': widget.lastNameUser.text,
            'fecha_Nacimiento': widget.birthDateUser.text,
            'genero': widget.sexUser.text,
            'telefono': widget.phoneUser.text,
            'tipo_usuario': widget.typeUser.text,  
            'email': email,
            'image': imageUrl,
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
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
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores.primaryColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Stack (
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 570,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colores.negro,
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
                      colorBackground: Colores.negro.withOpacity(0.8), 
                      colorIcon: Colores.argBlue
                    ),
                  ),
                  const SizedBox(height: 40),
                  const ListTile(
                    title:Text(
                      'REGÍSTRATE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ), 
                    subtitle: Text(
                      'Crea tus Credenciales\nde Acceso',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ), 
                  ),
                  const SizedBox(height: 40,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.all(20),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: passwordController,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              labelText: 'Confirmar Contraseña',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: ButtonAuth(
                              text: 'Registar',
                              onPressed: () {
                                register();
                              },
                              colorBackground: Colores.negro,
                              colorText: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  )
                ],
              ),
            ]
          )
        ), 
      )
    );
  }
}