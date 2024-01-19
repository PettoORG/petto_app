import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart' as entitie;
import 'package:petto_app/infrastructure/datasources/firebase_auth_datasource.dart';
import 'package:petto_app/infrastructure/datasources/firestore_user_datasource.dart';
import 'package:petto_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:petto_app/infrastructure/repositories/user_repository_impl.dart';
import 'package:petto_app/utils/utils.dart';

class AuthenticationProvider with ChangeNotifier {
  final UserRepositoryImpl _userRepository = UserRepositoryImpl(FirestoreUserDatasource());
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl(FirebaseAuthDatasource());

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isLogIn = true;
  bool get isLogIn => _isLogIn;
  set isLogIn(bool value) {
    _isLogIn = value;
    notifyListeners();
  }

  AuthenticationProvider() {
    logger.d(getCurrentUser());
  }

  Future<void> logIn(String email, String password) async {
    isLoading = true;
    try {
      await _authRepository.logIn(email, password);
      isLoading = false;
      logger.d(getCurrentUser());
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> signInUp(String email, String password, String name) async {
    isLoading = true;
    try {
      await _authRepository.signInUp(email, password, name);
      Map<String, dynamic> user = entitie.User(
        uid: getCurrentUser()!.uid,
        name: name,
        email: email,
        allowEmailNotifications: true,
        allowPhoneNotifications: true,
      ).toMap();
      await _userRepository.registerUser(getCurrentUser()!.uid, user);
      logger.d(getCurrentUser());
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    isLoading = true;
    try {
      await _authRepository.signOut();
      isLoading = false;
      logger.d(getCurrentUser());
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> updateName(String newName) async {
    isLoading = true;
    try {
      await _authRepository.updateName(newName);
      await _userRepository.updateName(getCurrentUser()!.uid, newName);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> updatePassWord(String newPassWord) async {
    isLoading = true;
    try {
      await _authRepository.updatePassword(newPassWord);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> updateEmail(String newEmail) async {
    isLoading = true;
    try {
      await _authRepository.updateEmail(newEmail);
      await _userRepository.updateEmail(getCurrentUser()!.uid, newEmail);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> reAuth(String password) async {
    isLoading = true;
    try {
      await _authRepository.reAuth(EmailAuthProvider.credential(
        email: _authRepository.getCurrentUser()!.email!,
        password: password,
      ));
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    isLoading = true;
    try {
      await _authRepository.sendPasswordResetEmail(email);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    isLoading = true;
    try {
      String uid = getCurrentUser()!.uid;
      await _authRepository.deleteAccount();
      await _userRepository.deleteUser(uid);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  User? getCurrentUser() {
    try {
      return _authRepository.getCurrentUser();
    } catch (e) {
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }
}
