import 'package:petto_app/domain/datasources/pet_datasource.dart';
import 'package:petto_app/domain/entities/pet.dart';
import 'package:petto_app/domain/repositories/pet_repository.dart';

class PetRepositoryImpl extends PetRepository {
  final PetDatasource datasource;
  PetRepositoryImpl(this.datasource);

  @override
  Future<void> addPet(Map<String, dynamic> pet) async {
    await datasource.addPet(pet);
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
  Future<void> updateBirthdate(String birthdate) async {
    await datasource.updateBirthdate(birthdate);
  }

  @override
  Future<void> updatePetName(String newDisplayName) async {
    await datasource.updatePetName(newDisplayName);
  }
}
