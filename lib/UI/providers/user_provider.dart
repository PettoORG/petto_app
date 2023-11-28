import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/infrastructure/datasources/firestore_user_datasource.dart';
import 'package:petto_app/infrastructure/repositories/user_repository_impl.dart';
import 'package:petto_app/utils/utils.dart';

class UserProvider extends ChangeNotifier {
  final UserRepositoryImpl _userRepository = UserRepositoryImpl(FirestoreUserDatasource());

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> deleteUser() async {
    try {
      isLoading = true;
      await _userRepository.deleteUser();
      isLoading = false;
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<User?> getUser() async {
    User user;
    try {
      isLoading = true;
      user = await _userRepository.getUser();
      isLoading = false;
      return user;
    } catch (e) {
      isLoading = false;
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> updateAllowEmailNotifications(bool isAllow) async {
    try {
      isLoading = true;
      await _userRepository.updateAllowEmailNotifications(isAllow);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> updateAllowPhoneNotifications(bool isAllow) async {
    try {
      isLoading = true;
      await _userRepository.updateAllowPhoneNotifications(isAllow);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> updateDisplayName(String newDisplayName) async {
    try {
      isLoading = true;
      await _userRepository.updateDisplayName(newDisplayName);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      isLoading = true;
      await _userRepository.updateEmail(newEmail);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }
}
