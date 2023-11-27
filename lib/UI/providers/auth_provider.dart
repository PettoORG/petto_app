import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart' as entitie;
import 'package:petto_app/infrastructure/datasources/firebase_user_datasource.dart';
import 'package:petto_app/infrastructure/repositories/user_repository_impl.dart';
import 'package:petto_app/services/services.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationProvider with ChangeNotifier {
  final UserRepositoryImpl _userRepository = UserRepositoryImpl(FirestoreUserDatasource());
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  AuthenticationProvider() {
    logger.d(getCurrentUser());
  }

  Future<void> logIn(String email, String password) async {
    try {
      isLoading = true;
      await _firebaseAuth.logIn(email, password);
      isLoading = false;
      logger.d(getCurrentUser());
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> signInUp(String email, String password, String displayName) async {
    try {
      isLoading = true;
      await _firebaseAuth.signInUp(email, password, displayName);
      Map<String, dynamic> user = entitie.User(
        displayName: displayName,
        email: email,
        image: null,
        pets: <entitie.Pet>[],
        allowEmailNotifications: true,
        allowPhoneNotifications: true,
      ).toMap();
      await _userRepository.addUser(user);
      isLoading = false;
      logger.d(getCurrentUser());
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      isLoading = true;
      await _firebaseAuth.signOut();
      isLoading = false;
      logger.d(getCurrentUser());
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> updateDisplayName(String newDisplayName) async {
    try {
      isLoading = true;
      await _firebaseAuth.updateDisplayName(newDisplayName);
      await _userRepository.updateDisplayName(newDisplayName);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> updatePassWord(String newPassWord) async {
    try {
      isLoading = true;
      await _firebaseAuth.updatePassWord(newPassWord);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      isLoading = true;
      await _firebaseAuth.updateEmail(newEmail);
      await _userRepository.updateEmail(newEmail);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> reAuth(String password) async {
    try {
      isLoading = true;
      await _firebaseAuth.reAuth(EmailAuthProvider.credential(
        email: _firebaseAuth.getCurrentUser()!.email!,
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
    try {
      isLoading = true;
      await _firebaseAuth.sendPasswordResetEmail(email);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      isLoading = true;
      await _userRepository.deleteUser();
      await _firebaseAuth.deleteAccount();
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  User? getCurrentUser() {
    try {
      return _firebaseAuth.getCurrentUser();
    } catch (e) {
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }

  bool isValidForm(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterEmail;
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
      return AppLocalizations.of(context)!.enterValidEmail;
    }
    return null;
  }

  String? validateDisplayName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterValidName;
    }
    return null;
  }

  String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    }
    if (value.length < 8) {
      return AppLocalizations.of(context)!.passwordLength;
    }
    return null;
  }

  String? confirmPassword(String? confirmNewPassWord, String newPassWord, BuildContext context) {
    if (confirmNewPassWord == null || confirmNewPassWord.isEmpty) {
      'Confirme su nueva contraseña';
    }
    if (confirmNewPassWord != newPassWord) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}
