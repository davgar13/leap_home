import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leap_home/pages/auth/register_screen.dart';
import 'package:leap_home/utils/my_lists.dart';
import 'package:leap_home/widgets/forms/form_login.dart';
import 'package:leap_home/widgets/forms/form_select_login.dart';

import '../../utils/colors.dart';
import '../../widgets/btn/button_auth.dart';
import '../../widgets/return_page.dart';

class RegisterDatesScreen extends StatefulWidget {
  const RegisterDatesScreen({super.key});

  @override
  State<RegisterDatesScreen> createState() => _RegisterDatesScreenState();
}

class _RegisterDatesScreenState extends State<RegisterDatesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameUserController = TextEditingController();
  final _lastNameUserController = TextEditingController();
  final _birthDateUserController = TextEditingController();
  final _sexUserController = TextEditingController();
  final _phoneUserController = TextEditingController();
  final _typeUserController = TextEditingController();
  File? _image;

  List<String> genList = MyList().genList;
  List<String> typeList = MyList().typeUserList;

  Future<void> _pickImage() async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colores.negro,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  const SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                      top: 20,
                      left: 15
                    ),
                    child: ReturnPage(
                      colorBackground: Colores.negro.withOpacity(0.8), 
                      colorIcon: Colores.azure,
                    ),
                  ),
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
                      'Ingresa tus datos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ), 
                  ),
                  const SizedBox(height: 100,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(height: 35,),
                          FormLogin(
                            formController: _nameUserController, 
                            labelText: 'Nombre', 
                            icon: Icons.person, 
                            messageError: 'Por favor ingrese su nombre', 
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 15,),
                          FormLogin(
                            formController: _lastNameUserController, 
                            labelText: 'Apellido', 
                            icon: Icons.person, 
                            messageError: 'Por favor ingrese su apellido',
                          ),
                          const SizedBox(height: 15,), 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 140,
                                child: FormLogin(
                                  formController: _birthDateUserController, 
                                  labelText: 'Fecha Nacimiento', 
                                  icon: Icons.calendar_today, 
                                  messageError: 'Por favor ingrese su fecha de nacimiento',
                                  keyboardType: TextInputType.datetime,
                                ),
                              ),
                              Container(
                                width: 140,
                                child: FormLogin(
                                  formController: _phoneUserController, 
                                  labelText: 'Teléfono', 
                                  icon: Icons.phone, 
                                  messageError: 'Por favor ingrese su teléfono',
                                  keyboardType: TextInputType.phone,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15,),
                          FormSelectLogin(
                            formController: _sexUserController, 
                            labelText: 'Género', 
                            icon: Icons.insights_rounded, 
                            formList: genList,
                          ),
                          const SizedBox(height: 15,),
                          FormSelectLogin(
                            formController: _typeUserController, 
                            labelText: 'Tipo de Usuario', 
                            icon: Icons.people, 
                            formList: typeList,
                          ),

                          const SizedBox(height: 15,),
                          ButtonAuth(
                            text: 'Siguiente', 
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                Navigator.push(context, 
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(
                                      nameUser: _nameUserController,
                                      lastNameUser: _lastNameUserController,
                                      birthDateUser: _birthDateUserController,
                                      sexUser: _sexUserController,
                                      phoneUser: _phoneUserController,
                                      imageUser: _image,
                                      typeUser: _typeUserController,
                                    )
                                  )
                                );
                              }
                            },
                            colorBackground: Colores.azure, 
                            colorText: Colors.black,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            if(_image != null)
              Center(
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.only(top: 165),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: ClipOval(
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: const EdgeInsets.only(top: 105),
                              child: FloatingActionButton(
                                onPressed: _pickImage,
                                mini: true,
                                backgroundColor: Colores.primaryColor.withOpacity(0.8),  
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ) 
                  )
            else 
              Center(
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.only(top: 165),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.black12.withOpacity(0.6),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 105),
                          child: FloatingActionButton(
                            onPressed: _pickImage,
                            mini: true,
                            backgroundColor: Colores.primaryColor.withOpacity(0.8),  
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              )
            ],
          ),
        ), 
       ),
    );
  }
}