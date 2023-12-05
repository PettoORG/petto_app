import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/domain/repositories/pet_repository.dart';
import 'package:petto_app/infrastructure/datasources/firestore_pet_datasource.dart';
import 'package:petto_app/infrastructure/repositories/pet_repository_impl.dart';
import 'package:petto_app/utils/utils.dart';

class PetProvider extends ChangeNotifier {
  final PetRepository _userRepository = PetRepositoryImpl(FirestorePetDatasource());
  List<Pet> pets = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getPets() async {
    try {
      isLoading = true;
      pets = await _userRepository.getPets();
      isLoading = false;
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> deletePet(String petId) async {
    try {
      isLoading = true;
      await _userRepository.deletePet(petId);
      isLoading = false;
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<String> addPet(Pet pet) async {
    try {
      String petId;
      isLoading = true;
      petId = await _userRepository.addPet(pet);
      isLoading = false;
      return petId;
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> updatePetImage(String petId, File image) async {
    try {
      isLoading = true;
      _userRepository.updatePetImage(petId, image);
      isLoading = false;
    } catch (e) {
      logger.e('STORAGE ERROR: $e');
      rethrow;
    }
  }
}
