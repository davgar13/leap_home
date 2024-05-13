import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as p;

import '../../models/users_model.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File? _image;
  File? _portada;
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _ocupacionController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _pickImage() async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _portada = File(pickedFile.path);
      });
    }
  }
  Future<String> _uploadImageAndGetDownloadUrl(File imageFile) async {
    String fileName = p.basename(imageFile.path);
    String uniqueFileName = "${DateTime.now().millisecondsSinceEpoch}_$fileName";
    final ref = FirebaseStorage.instance.ref().child('Users/$uniqueFileName');
    await ref.putFile(imageFile);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadPortadaAndGetDownloadUrl(File imageFile) async {
    String fileName = p.basename(imageFile.path);
    String uniqueFileName = "${DateTime.now().millisecondsSinceEpoch}_$fileName";
    final ref = FirebaseStorage.instance.ref().child('Portada/$uniqueFileName');
    await ref.putFile(imageFile);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _updateDates()async {
    if (_formKey.currentState!.validate()) {
      UserModel().updateUser({
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'ocupacion': _ocupacionController.text,
        'telefono': _phoneController.text,
        'image': await _uploadImageAndGetDownloadUrl(_image!),
        'portada': await _uploadPortadaAndGetDownloadUrl(_portada!),
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Actualizar Perfil'),
      content: const Text('¿Desea actualizar su perfil?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          child: const Text('Cancelar')
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _updateDates();
          }, 
          child: const Text('Aceptar')
        )
      ],
    );
  }
}