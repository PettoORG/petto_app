import 'dart:io';

import 'package:petto_app/domain/datasources/pet_datasource.dart';
import 'package:petto_app/domain/entities/pet.dart';
import 'package:petto_app/domain/repositories/pet_repository.dart';

class PetRepositoryImpl extends PetRepository {
  final PetDatasource datasource;
  PetRepositoryImpl(this.datasource);

  @override
  Future<void> addPet(Pet pet, File? petImage) async {
    await datasource.addPet(pet, petImage);
  }

  @override
  Future<void> deletePet(String petId) async {
    await datasource.deletePet(petId);
  }

  @override
  Future<List<Pet>> getPets() async {
    return await datasource.getPets();
  }

  @override
  Future<void> updatePetImage(String petId, File imageFile) async {
    return await datasource.updatePetImage(petId, imageFile);
  }

  @override
  Future<void> updatePet(petId, petData) async {
    await datasource.updatePet(petId, petData);
  }
}
