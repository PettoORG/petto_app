import 'dart:io';
import 'package:petto_app/domain/entities/entities.dart';

abstract class PetDatasource {
  Future<List<Pet>> getPets();

  Future<String> addPet(Pet pet);

  Future<void> deletePet(String petId);

  Future<void> updatePetImage(String petId, File imageFile);

  Future<void> updatePet(String petId, Map<Object, Object?> petData);
}
