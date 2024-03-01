import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/domain/repositories/pet_repository.dart';
import 'package:petto_app/infrastructure/datasources/firestore_pet_datasource.dart';
import 'package:petto_app/infrastructure/repositories/pet_repository_impl.dart';
import 'package:petto_app/utils/utils.dart';

class PetProvider extends ChangeNotifier {
  final PetRepository _petRepository = PetRepositoryImpl(FirestorePetDatasource());
  List<Pet> pets = [];

  int _currentPet = 0;
  int get currentPet => _currentPet;
  set currentPet(int value) {
    _currentPet = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getPets() async {
    try {
      pets = await _petRepository.getPets();
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> deletePet(String petId) async {
    try {
      isLoading = true;
      await _petRepository.deletePet(petId);
      isLoading = false;
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> addPet(
    String petName,
    String petSpecie,
    String petGender,
    String petBreed,
    String petSize,
    String petBirthDate,
    String petWeight,
    String petAge,
    File? petImage,
  ) async {
    isLoading = true;
    try {
      Pet pet = Pet(
        id: 'not-asigned',
        name: petName,
        specie: petSpecie,
        gender: petGender,
        breed: petBreed,
        size: petSize,
        birthdate: petBirthDate,
        weight: petWeight,
        age: petAge,
      );
      await _petRepository.addPet(pet, petImage);

      isLoading = false;
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> updatePetImage(String petId, File image) async {
    try {
      isLoading = true;
      _petRepository.updatePetImage(petId, image);
      isLoading = false;
    } catch (e) {
      logger.e('STORAGE ERROR: $e');
      rethrow;
    }
  }

  Future<void> updatePet(String petId, Map<Object, Object?> petData) async {
    try {
      isLoading = true;
      await _petRepository.updatePet(petId, petData);
      await getPets();
      isLoading = false;
    } catch (e) {
      logger.e('STORAGE ERROR: $e');
      rethrow;
    }
  }
}
