import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leap_home/pages/auth/start_page.dart';

class UserModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final FirebaseStorage _storage = FirebaseStorage.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<List<Map<String,dynamic>>> getUsers() async {
    final QuerySnapshot snapshot = await _firestore
    .collection('Usuarios')
    .get();
    return snapshot.docs.map((doc) {
      return {
        'id': doc['id'],
        'nombre': doc['nombre'],
        'apellido': doc['apellido'],
        'edad': doc['edad'],
        'genero': doc['genero'],
        'fecha_Nacimiento': doc['fecha_Nacimiento'],
        'image': doc['image'],
        'telefono': doc['telefono'],
        'email': doc['email'],
      };
    }).toList();
  }

  Future<Map<String, dynamic>> getUser() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
    .collection('Usuarios')
    .doc(currentUser!.uid)
    .get();
    final data = snapshot.data();
    return {
      'id': data?['id'],
      'nombre': data?['nombre'],
      'apellido': data?['apellido'],
      'edad': data?['edad'],
      'genero': data?['genero'],
      'fecha_Nacimiento': data?['fecha_Nacimiento'],
      'image': data?['image'],
      'telefono': data?['telefono'],
      'email': data?['email'],
    };
  }

  Future<Map<String, dynamic>> getUserDataFormId(String userId) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
    .collection('Usuarios')
    .doc(userId)
    .get();
    final data = snapshot.data();
    return {
      'id': data?['id'],
      'nombre': data?['nombre'],
      'apellido': data?['apellido'],
      'edad': data?['edad'],
      'genero': data?['genero'],
      'fecha_Nacimiento': data?['fecha_Nacimiento'],
      'image': data?['image'],
      'telefono': data?['telefono'],
      'email': data?['email'],
    };
  }

  Future<String> getCurrentUserImage() async {
    final DocumentSnapshot snapshot = await _firestore
    .collection('Usuarios')
    .doc(currentUser?.uid)
    .get();
    return snapshot['image'];
  }

  Future<String> getUserName() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
    .collection('Usuarios')
    .doc(currentUser?.uid)
    .get();
    final data = snapshot.data();
    return data?['nombre'] + ' ' + data?['apellido'];
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    await _firestore
    .collection('Usuarios')
    .doc(currentUser?.uid)
    .update(data);
  }

  Future<void> deleteUser() async {
    await _firestore
    .collection('Usuarios')
    .doc(currentUser?.uid)
    .delete();
  }

  Future<void> updateImageUser(String imageUrl) async {
    await _firestore
    .collection('Usuarios')
    .doc(currentUser?.uid)
    .update({
      'image': imageUrl,
    });
  }

 

  Future<void> updatePassword() async {
    final email = currentUser?.email;
    if (email != null) {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } else {
      throw Exception('No hay un usuario logueado');
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => StartPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}