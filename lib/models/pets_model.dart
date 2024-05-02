
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PetsModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  User? get user => _firebaseAuth.currentUser;

  Future<List<Map<String, dynamic>>> getPetsHome() async {
    QuerySnapshot querySnapshot = await _firestore
    .collection('Pet_Person')
    .limit(3)
    .get();
    return querySnapshot.docs.map((doc) {
      return {
        'id': doc['id'],
        'name': doc['name'],
        'type_animal': doc['type'],
        'ageA': doc['ageA'],
        'ageM': doc['ageM'],
        'gen' : doc['gen'],
        'color' : doc['color'],
        'id_owner': doc['idPerson'],
        'isVacunated': doc['isVacunated'],
        'dateVaccine': doc['dateVaccine'],
        'isDewormed': doc['isDewormed'],
        'dateDeworming': doc['dateDeworming'],
        'isSterilized': doc['isSterilized'],
        'dateSterilization': doc['dateSterilization'],
        'description': doc['description'],
        'imageUrl' : doc['imageUrl'],
        'imageUrl2' : doc['imageUrl2'],
        'imageUrl3' : doc['imageUrl3'],
        'status': doc['status'],
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getPets() async {
    final QuerySnapshot querySnapshot = await _firestore
    .collection('Pet_Person')
    .get();
    return querySnapshot.docs.map((doc) {
      return {
        'id': doc['id'],
        'name': doc['name'],
        'type_animal': doc['type'],
        'ageA': doc['ageA'],
        'ageM': doc['ageM'],
        'gen' : doc['gen'],
        'color' : doc['color'],
        'id_owner': doc['idPerson'],
        'isVacunated': doc['isVacunated'],
        'dateVaccine': doc['dateVaccine'],
        'isDewormed': doc['isDewormed'],
        'dateDeworming': doc['dateDeworming'],
        'isSterilized': doc['isSterilized'],
        'dateSterilization': doc['dateSterilization'],
        'description': doc['description'],
        'imageUrl' : doc['imageUrl'],
        'imageUrl2' : doc['imageUrl2'],
        'imageUrl3' : doc['imageUrl3'],
        'status': doc['status'],
      };
    }).toList();
  }
  
}