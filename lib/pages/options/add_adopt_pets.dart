import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leap_home/utils/colors.dart';
import 'package:leap_home/utils/my_lists.dart';
import 'package:leap_home/widgets/forms/form_textarea.dart';
import 'package:path/path.dart' as p;

import '../../widgets/btn/button_primary.dart';
import '../../widgets/forms/form_add.dart';
import '../../widgets/forms/form_select.dart';
import '../../widgets/simple_app_bar.dart';

class AddAdoptPets extends StatefulWidget {
  const AddAdoptPets({super.key});

  @override
  State<AddAdoptPets> createState() => _AddAdoptPetsState();
}

class _AddAdoptPetsState extends State<AddAdoptPets> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _namePetController = TextEditingController();
  final TextEditingController _typePetController = TextEditingController();
  final TextEditingController _ageAPetController = TextEditingController();
  final TextEditingController _ageMPetController = TextEditingController();
  final TextEditingController _genPetController = TextEditingController();
  final TextEditingController _colorPetController = TextEditingController();
  final TextEditingController _isVacunatedPetController = TextEditingController();
  final TextEditingController _dateVaccinePetController = TextEditingController();
  final TextEditingController _isDewormedPetController = TextEditingController();
  final TextEditingController _dateDewormingPetController = TextEditingController();
  final TextEditingController _isSterilizedPetController = TextEditingController();
  final TextEditingController _dateSterilizationPetController = TextEditingController();
  final TextEditingController _descriptionPetController = TextEditingController();
  bool _isLoading = false;
  File? _image;
  File? _image2;
  File? _image3;

  List<String> answer = MyList().answerSimpleQuestion;
  List<String> genPet = MyList().genPetList;
  List<String> typePet = MyList().typePetList;

  Future<void> _pickImage(String imageNumber) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        switch (imageNumber) {
          case '1':
            _image = File(pickedFile.path);
            break;
          case '2':
            _image2 = File(pickedFile.path);
            break;
          case '3':
            _image3 = File(pickedFile.path);
            break;
        }
      });
    }
  }
  void _removeImage(String imageNumber) {
    setState(() {
      switch (imageNumber) {
        case '1':
          _image = null;
          break;
        case '2':
          _image2 = null;
          break;
        case '3':
          _image3 = null;
          break;
      }
    });
  }

  Future<String> _uploadImageAndGetDownloadUrl(File imageFile) async {
    String fileName = p.basename(imageFile.path);
    String uniqueFileName = "${DateTime.now().millisecondsSinceEpoch}_$fileName";
    final ref = FirebaseStorage.instance.ref().child('PetsImages/$uniqueFileName');
    await ref.putFile(imageFile);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _sumbitPet() async {
    if (formkey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });

      try {
        String? imageUrl;
        String? imageUrl2;
        String? imageUrl3;

        if (_image != null) {
          imageUrl = await _uploadImageAndGetDownloadUrl(_image!);
        }
        if (_image2 != null) {
          imageUrl2 = await _uploadImageAndGetDownloadUrl(_image2!);
        }
        if (_image3 != null) {
          imageUrl3 = await _uploadImageAndGetDownloadUrl(_image3!);
        }
        var idPet = _namePetController.text+'_'+'${FirebaseAuth.instance.currentUser!.email}';

        await FirebaseFirestore.instance.collection(_typePetController.text).doc(idPet).set({
          'id': idPet,
          'name': _namePetController.text,
          'type': _typePetController.text,
          'ageA': _ageAPetController.text,
          'ageM': _ageMPetController.text,
          'gen': _genPetController.text,
          'color': _colorPetController.text,
          'idPerson': FirebaseAuth.instance.currentUser!.uid,
          'isVacunated': _isVacunatedPetController.text,
          'dateVaccine': _dateVaccinePetController.text,
          'isDewormed': _isDewormedPetController.text,
          'dateDeworming': _dateDewormingPetController.text,
          'isSterilized': _isSterilizedPetController.text,
          'dateSterilization': _dateSterilizationPetController.text,
          'description': _descriptionPetController.text,
          'imageUrl': imageUrl, 
          'imageUrl2': imageUrl2,
          'imageUrl3': imageUrl3,
          'status': 'En Adopcion',
        });
        FirebaseFirestore.instance.collection('Pet_Person').doc(idPet).set({
          'id': idPet,
          'name': _namePetController.text,
          'type': _typePetController.text,
          'ageA': _ageAPetController.text,
          'ageM': _ageMPetController.text,
          'gen': _genPetController.text,
          'color': _colorPetController.text,
          'idPerson': FirebaseAuth.instance.currentUser!.uid,
          'isVacunated': _isVacunatedPetController.text,
          'dateVaccine': _dateVaccinePetController.text,
          'isDewormed': _isDewormedPetController.text,
          'dateDeworming': _dateDewormingPetController.text,
          'isSterilized': _isSterilizedPetController.text,
          'dateSterilization': _dateSterilizationPetController.text,
          'description': _descriptionPetController.text,
          'imageUrl': imageUrl, 
          'imageUrl2': imageUrl2,
          'imageUrl3': imageUrl3,
          'status': 'En Adopcion',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mascota subida correctamente'),
            duration: Duration(seconds: 2),
            backgroundColor: Colores.orange,
            elevation: 10,
          )
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: ListTile(
              title: Text('Error al subir la mascota'),
              subtitle: Text('Por favor intenta de nuevo'),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colores.red,
            elevation: 10,
          )
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
      formClean();
    }
  }

  void formClean(){
    _namePetController.clear();
    _typePetController.clear();
    _ageAPetController.clear();
    _ageMPetController.clear();
    _genPetController.clear();
    _colorPetController.clear();
    _isVacunatedPetController.clear();
    _dateVaccinePetController.clear();
    _isDewormedPetController.clear();
    _dateDewormingPetController.clear();
    _isSterilizedPetController.clear();
    _dateSterilizationPetController.clear();
    _descriptionPetController.clear();
    setState(() {
      if (_image != null) {
        _image = null;
      }
      if (_image2 != null) {
        _image2 = null;
      }
      if (_image3 != null) {
        _image3 = null;
      } 
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formkey,
        child: Stack(
          children: [
            SimpleAppBar(
              onPressedRight: () => print('Hola'), 
              iconRight: const Icon(
                Icons.add_business,
                size: 25,
              ),
              newColorIcons: Colors.white,
              newColorCard: Colores.primaryColor, 
              newColorSimple: Colores.white,
              title: 'SUBIR',
              subtitle: 'MASCOTA', 
              newColorCardTitle: Colors.transparent,
            ),
              
            Container(
              width: double.infinity,
              height: 170,
              margin: const EdgeInsets.only(top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (_image != null) 
                        ...[
                          Image.file(_image!, width: 100, height: 150, fit: BoxFit.cover),
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                              size: 32,
                            ),
                            onPressed: () => _removeImage('1'), 
                          ),
                        ]
                      else // Si _image es null, muestra el botón para cargar
                        Ink(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: IconButton(
                            onPressed: () => _pickImage('1'), // Identificador para _image
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),

                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (_image2 != null) // Si _image2 no es null, muestra la imagen y el botón de remover
                        ...[
                          Image.file(_image2!, width: 100, height: 150, fit: BoxFit.cover),
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                              size: 32,
                            ),
                            onPressed: () => _removeImage('2'), 
                          ),
                        ]
                      else 
                        Ink(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: IconButton(
                            onPressed: () => _pickImage('2'), // Identificador para _image2
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                    ],
                  ),

                  // Bloque para _image3
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (_image3 != null) 
                        ...[
                          Image.file(_image3!, width: 100, height: 150, fit: BoxFit.cover),
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                              size: 32,
                            ),
                            onPressed: () => _removeImage('3'), 
                          ),
                        ]
                      else // Si _image3 es null, muestra el botón para cargar
                        Ink(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: IconButton(
                            onPressed: () => _pickImage('3'), 
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                    ],
                  ),
                ],
              )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 293),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: Colores.gradientLinear2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ) 
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      FormAdd(
                        campoTexto: 'Nombre', 
                        controller: _namePetController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      FormSelect(
                        campoTexto: 'Tipo', 
                        itemsFormSelect: typePet, 
                        controller: _typePetController,
                      ),
                      const SizedBox(height: 20),
                      FormAdd(
                        campoTexto: 'Edad (Años)', 
                        controller: _ageAPetController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      FormAdd(
                        campoTexto: 'Edad (Meses)', 
                        controller: _ageMPetController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un número';
                          }
                          final n = int.tryParse(value);
                          if (n == null) {
                            return 'Por favor ingresa un número válido';
                          }
                          if (n < 1 || n > 12) {
                            return 'El número debe estar entre 1 y 12';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      FormSelect(
                        campoTexto: 'Genero', 
                        itemsFormSelect: genPet, 
                        controller: _genPetController,
                      ),
                      const SizedBox(height: 20),
                      FormAdd(
                        campoTexto: 'Color', 
                        controller: _colorPetController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      FormSelect(
                        campoTexto: 'Vacunado', 
                        itemsFormSelect: answer, 
                        controller: _isVacunatedPetController,
                      ),
                      const SizedBox(height: 20),
                      FormAdd(
                        campoTexto: 'Fecha de Vacunación', 
                        controller: _dateVaccinePetController,
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(height: 20),
                      FormSelect(
                        campoTexto: 'Desparasitado', 
                        itemsFormSelect: answer, 
                        controller: _isDewormedPetController,
                      ),
                      const SizedBox(height: 20),
                      FormAdd(
                        campoTexto: 'Fecha de Desparasitación', 
                        controller: _dateDewormingPetController,
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(height: 20),
                      FormSelect(
                        campoTexto: 'Esterilizado', 
                        itemsFormSelect: answer, 
                        controller: _isSterilizedPetController,
                      ),
                      const SizedBox(height: 20),
                      FormAdd(
                        campoTexto: 'Fecha de Esterilización', 
                        controller: _dateSterilizationPetController,
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(height: 20),
                      FormTextArea(
                        campoTexto: 'Descripcion', 
                        controller: _descriptionPetController, 
                        numLineas: 2, 
                        campoTextoColor: Colores.negro, 
                        bordeColor: Colores.primaryColor, 
                        focusColor: Colores.negro, 
                        fillColor: Colors.white.withOpacity(0.8), 
                        textColor: Colores.negro
                      ),
                      const SizedBox(height: 20),
                      
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: ButtonPrimary(
                              textValue: 'Subir Mascota',
                              onPressed: (){
                                _sumbitPet();
                              },
                              newColor: Colors.black,
                              fontColor: Colores.white,
                            ),
                          ),
                          if (_isLoading)
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}