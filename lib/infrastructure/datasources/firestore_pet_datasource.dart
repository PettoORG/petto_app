import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petto_app/domain/datasources/pet_datasource.dart';
import 'package:petto_app/domain/entities/pet.dart';
import 'package:petto_app/utils/utils.dart';

class FirestorePetDatasource extends PetDatasource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  @override
  Future<void> addPet(Pet pet, File? petImage) async {
    DocumentReference ref = await _db.collection('users').doc(_getUid()).collection('pets').add(pet.toMap());
    await _db.collection('users').doc(_getUid()).collection('pets').doc(ref.id).update({'id': ref.id});
    if (petImage != null) await updatePetImage(ref.id, petImage);
  }

  @override
  Future<void> deletePet(String petId) async {
    await _db.collection('users').doc(_getUid()).collection('pets').doc(petId).delete();
  }

  @override
  Future<List<Pet>> getPets() async {
    CollectionReference petsRef = _db.collection('users').doc(_getUid()).collection('pets');
    QuerySnapshot snapshot = await petsRef.get();

    List<Pet> pets = [];
    for (DocumentSnapshot document in snapshot.docs) {
      Pet pet = Pet.fromMap(document.data() as Map<String, dynamic>, document.id);
      pets.add(pet);
    }
    return pets;
  }

  String _getUid() {
    try {
      return _firebaseAuth.currentUser!.uid;
    } catch (e) {
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  @override
  Future<void> updatePetImage(String petId, File imageFile) async {
    final imageRef = _storage.ref('${_getUid()}/$petId/');
    final uploadTask = await imageRef.putFile(imageFile);
    final imageUrl = await uploadTask.ref.getDownloadURL();
    final petRef = _db.collection('users').doc(_getUid()).collection('pets').doc(petId);
    await petRef.update({
      'image': imageUrl,
    });
  }

  @override
  Future<void> updatePet(petId, petData) async {
    await _db.collection('users').doc(_getUid()).collection('pets').doc(petId).update(petData);
  }
}
