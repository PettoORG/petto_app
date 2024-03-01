import 'dart:io';

import 'package:petto_app/domain/datasources/pet_datasource.dart';
import 'package:petto_app/domain/entities/pet.dart';

abstract class PetRepository extends PetDatasource {
  @override
  Future<void> deletePet(String petId);

  @override
  Future<List<Pet>> getPets();

  @override
  Future<void> addPet(Pet pet, File? petImage);
}
