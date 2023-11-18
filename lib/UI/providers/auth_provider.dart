import 'package:flutter/material.dart';
import 'package:petto_app/services/services.dart';

class AuthenticationProvider with ChangeNotifier {
  GlobalKey<FormState> logInKey = GlobalKey<FormState>();
  GlobalKey<FormState> sigInUpKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> logIn() async {
    await Auth().signInWithEmailAndPassWord(email: email, password: password);
  }

  Future<void> signInUp() async {
    await Auth().createUserWithEmailAndPassword(email: email, password: password);
  }

  bool isValidLogIn() {
    return logInKey.currentState?.validate() ?? false;
  }

  bool isValidsigInUp() {
    return sigInUpKey.currentState?.validate() ?? false;
  }
}
