import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? password;

  String? _email;
  String? get email => _email;
  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  String? _displayName;
  String? get displayName => _displayName;
  set displayName(String? value) {
    _displayName = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  AuthenticationProvider() {
    displayName = _firebaseAuth.currentUser?.displayName;
    email = _firebaseAuth.currentUser?.email;
    logger.d(getCurrentUser());
  }

  Future<void> logIn() async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
    logger.d(getCurrentUser());
  }

  Future<void> signInUp() async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    await userCredential.user!.updateDisplayName(displayName);
    logger.d(getCurrentUser());
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    email = null;
    password = null;
    displayName = null;
    logger.d(getCurrentUser());
  }

  Future<void> updateDisplayName() async {
    await _firebaseAuth.currentUser!.updateDisplayName(displayName);
  }

  Future<void> updatePassWord(String newPassWord) async {
    await _firebaseAuth.currentUser!.updatePassword(newPassWord);
  }

  Future<void> updateEmail() async {
    await _firebaseAuth.currentUser!.updateEmail(email!);
  }

  Future<void> resetPassword() async {
    await _firebaseAuth.sendPasswordResetEmail(email: email!);
  }

  Future<void> deleteAccount() async {
    await _firebaseAuth.currentUser!.delete();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
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
