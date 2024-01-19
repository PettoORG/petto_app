import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:petto_app/infrastructure/datasources/firebase_auth_datasource.dart';
import 'package:petto_app/infrastructure/datasources/firestore_user_datasource.dart';
import 'package:petto_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:petto_app/infrastructure/repositories/user_repository_impl.dart';
import 'package:petto_app/utils/utils.dart';

class UserProvider extends ChangeNotifier {
  final UserRepositoryImpl _userRepository = UserRepositoryImpl(FirestoreUserDatasource());
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl(FirebaseAuthDatasource());

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  User? _user;
  User? get user => _user;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  String? _name;
  String? get name => _name;
  set name(String? name) {
    _name = name;
    notifyListeners();
  }

  String? _email;
  String? get email => _email;
  set email(String? email) {
    _email = email;
    notifyListeners();
  }

  Future<void> getUser() async {
    try {
      user = await _userRepository.getUser(_getCurrentUser()!.uid);
      name = user!.name;
      email = user!.email;
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  Future<void> updateAllowEmailNotifications(bool isAllow) async {
    try {
      isLoading = true;
      await _userRepository.updateAllowEmailNotifications(_getCurrentUser()!.uid, isAllow);
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
      await _userRepository.updateAllowPhoneNotifications(_getCurrentUser()!.uid, isAllow);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('FIRESTORE ERROR: $e');
      rethrow;
    }
  }

  auth.User? _getCurrentUser() {
    try {
      return _authRepository.getCurrentUser();
    } catch (e) {
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }
}
