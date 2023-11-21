import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petto_app/utils/utils.dart';

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GlobalKey<FormState> logInKey = GlobalKey<FormState>();
  GlobalKey<FormState> sigInUpKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String userName = '';
  bool _isLoading = false;

  AuthenticationProvider() {
    logger.d(getCurrentUser());
  }

  Future<void> logIn() async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    logger.d(getCurrentUser());
  }

  Future<void> signInUp() async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(userName);
    logger.d(getCurrentUser());
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    logger.d(getCurrentUser());
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidLogIn() {
    return logInKey.currentState?.validate() ?? false;
  }

  bool isValidsigInUp() {
    return sigInUpKey.currentState?.validate() ?? false;
  }
}
