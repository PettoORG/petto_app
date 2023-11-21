import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petto_app/services/services.dart';
import 'package:petto_app/utils/utils.dart';

class AuthenticationProvider with ChangeNotifier {
  GlobalKey<FormState> logInKey = GlobalKey<FormState>();
  GlobalKey<FormState> sigInUpKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String userName = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> logIn() async {
    await Auth().signInWithEmailAndPassWord(email: email, password: password);
    logger.d(getCurrentUser());
  }

  Future<void> signInUp() async {
    await Auth().createUserWithEmailAndPassword(email: email, password: password, userName: userName);
    logger.d(getCurrentUser());
  }

  Future<void> signOut() async {
    await Auth().signOut();
    logger.d(getCurrentUser());
  }

  User? getCurrentUser() {
    return Auth().getCurrentUser();
  }

  bool isValidLogIn() {
    return logInKey.currentState?.validate() ?? false;
  }

  bool isValidsigInUp() {
    return sigInUpKey.currentState?.validate() ?? false;
  }
}
