import 'package:flutter/material.dart';
import 'package:petto_app/domain/repositories/pet_repository.dart';
import 'package:petto_app/infrastructure/datasources/firestore_pet_datasource.dart';
import 'package:petto_app/infrastructure/repositories/pet_repository_impl.dart';
import 'package:petto_app/utils/utils.dart';

class PetProvider extends ChangeNotifier {
  final PetRepository _userRepository = PetRepositoryImpl(FirestorePetDatasource());

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getPets(String petId) async {
    try {
      isLoading = true;
      await _userRepository.getPets();
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

  Future<void> addPet(Map<String, dynamic> pet) async {
    try {
      isLoading = true;
      await _userRepository.addPet(pet);
      isLoading = false;
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }
}
