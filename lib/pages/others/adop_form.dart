import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leap_home/models/users_model.dart';

import '../../services/service_email.dart';
import '../home/ini_home.dart';

class AdoptionFormScreen extends StatefulWidget {
  final String? ownerEmail;
  const AdoptionFormScreen({super.key, required this.ownerEmail});

  @override
  _AdoptionFormScreenState createState() => _AdoptionFormScreenState();
}

class _AdoptionFormScreenState extends State<AdoptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _nationalityController = TextEditingController();

  final _familyController = TextEditingController();
  final _childrenController = TextEditingController();
  final _agechildrenController = TextEditingController();
  final _otherpetsController = TextEditingController();

  final _jobController = TextEditingController();
  final _travelController = TextEditingController();

  final _typeHomeController = TextEditingController();
  final _gardensizeController = TextEditingController();

  final _experienceController = TextEditingController();

  final _messageController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await UserModel().getUser();
        Map<String, dynamic> datos = {
          'Dueño_Email': widget.ownerEmail,
          'datos_personales': {
            'nombre': user['nombre'],
            'apellido': user['apellido'],
            'edad': int.parse(_ageController.text),
            'direccion': _addressController.text,
            'nacionalidad': _nationalityController.text,
            'telefono': user['telefono'],
            'email': user['email'],
          },
          'datos_familiares': {
            'familia': _familyController.text,
            'hijos': _childrenController.text,
            'edad_hijos': _agechildrenController.text,
            'otras_mascotas': _otherpetsController.text,
          },
          'datos_laborales': {
            'trabajo': _jobController.text,
            'viajes': _travelController.text,
          },
          'datos_vivienda': {
            'tipo': _typeHomeController.text,
            'jardin': _gardensizeController.text,
          },
          'experiencia': _experienceController.text,
          'mensaje': _messageController.text,
          'createdAt': Timestamp.now(),
        };

        await FirebaseFirestore.instance.collection('solicitudes').add(datos);

        enviarEmail(datos);
        _formClean();
        showDialog(
          context: _scaffoldKey.currentContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('¡Felicidades!...'),
              content: const Text('Tu solicitud ha sido enviada con éxito.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, 
                    MaterialPageRoute(builder: (context) => const IniHome()), 
                    (route) => false);
                  },
                ),
              ],
            );
          },
        );
      } catch (e) { 
        print('Error: $e');
        showDialog(
          context: _scaffoldKey.currentContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: ListTile(
                title: const Text('Hubo un error al enviar tu Solicitud.'),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Porfavor intenta de nuevo...'),
                    SizedBox(height: 10,),
                    Text('Error: $e'),
                  ],
                ),
              ),
              actions: <Widget>[
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

  void _formClean(){
    _ageController.clear();
    _addressController.clear();
    _nationalityController.clear();
    _familyController.clear();
    _childrenController.clear();
    _agechildrenController.clear();
    _otherpetsController.clear();
    _jobController.clear();
    _travelController.clear();
    _typeHomeController.clear();
    _gardensizeController.clear();
    _experienceController.clear();
    _messageController.clear();
  }

  Map<String, String> colors = {
    "red": "Rojo",
    "green": "Verde",
    "blue": "Azul",
  };

  List extencion = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Formulario de Adopción'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        title: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.red,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text('Datos Personales'),
                          ],
                        ),
                        subtitle: Text(
                            'Es importante poder identificar al adoptante'),
                      ),
                      TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(labelText: 'Edad'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu edad';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration:
                            const InputDecoration(labelText: 'Dirección'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu dirección';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _nationalityController,
                        decoration:
                            const InputDecoration(labelText: 'Nacionalidad'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, ingresa tu nacionalidad';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color.fromARGB(255, 255, 255, 255)),
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.family_restroom,
                            color: Colors.blue,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text('Datos Familiares'),
                        ],
                      ),
                      subtitle: Text(
                          'Es importante conocer el entorno familiar del adoptante'),
                    ),
                    TextFormField(
                      controller: _familyController,
                      decoration: const InputDecoration(
                          labelText: '¿Vives en familia?'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa si vives en familia';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _childrenController,
                      decoration: const InputDecoration(
                          labelText: '¿Tienes hijos pequeños?'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa si tienes hijos';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _agechildrenController,
                      decoration: const InputDecoration(
                          labelText: '¿Qué edad tienen los niños?'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa si tienes hijos mayores de edad';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _otherpetsController,
                      decoration: const InputDecoration(
                          labelText: '¿Tienes otras mascotas?'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa si tienes otras mascotas';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color.fromARGB(255, 255, 255, 255)),
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.work,
                            color: Colors.green,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text('Datos Laborales'),
                        ],
                      ),
                      subtitle: Text(
                          'Es importante conocer el entorno laboral del adoptante'),
                    ),
                    TextFormField(
                      controller: _jobController,
                      decoration:
                          const InputDecoration(labelText: '¿Tienes trabajo?'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa si tienes trabajo';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _travelController,
                      decoration:
                          const InputDecoration(labelText: '¿Viajas mucho?'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa si viajas mucho';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellow,
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color.fromARGB(255, 255, 255, 255)),
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: Colors.yellow,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text('Datos de Vivienda'),
                        ],
                      ),
                      subtitle: Text(
                          'Es importante conocer el entorno de la vivienda del adoptante'),
                    ),
                    TextFormField(
                      controller: _typeHomeController,
                      decoration: const InputDecoration(
                          labelText: '¿Qué tipo de vivienda tienes?'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa el tipo de vivienda';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _gardensizeController,
                      decoration: const InputDecoration(
                          labelText: '¿Tienes jardin en casa?'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa si tienes jardin en casa';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange,
                      blurRadius: 3.0,
                      spreadRadius: 0.0,
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color.fromARGB(255, 255, 255, 255)),
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.question_answer,
                            color: Colors.orange,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text('Experiencia y Motivo de Adopción'),
                        ],
                      ),
                      subtitle:
                          Text('Es importante conocer el Motivo de adopción'),
                    ),
                    TextFormField(
                      controller: _experienceController,
                      decoration: const InputDecoration(
                          labelText: '¿Tienes experiencia con mascotas?'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa si tienes experiencia con mascotas';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                          labelText: 'Motivo de Adopción'),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _submitForm();
                
              },
              child: const Text('Enviar Solicitud'),
            ),
          ],
        ),
      ),
    );
  }
}
