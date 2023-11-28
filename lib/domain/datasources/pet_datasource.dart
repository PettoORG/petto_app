import 'package:petto_app/domain/entities/entities.dart';

abstract class PetDatasource {
  Future<List<Pet>> getPets();

  Future<void> addPet(Map<String, dynamic> pet);

  Future<void> updatePetName(String newDisplayName);

  Future<void> updateBirthdate(String birthdate);

  Future<void> deletePet(String petId);
}
