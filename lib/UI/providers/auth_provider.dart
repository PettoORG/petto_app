import 'package:flutter/material.dart';

class AuthenticationProvider with ChangeNotifier {
  GlobalKey<FormState> logIn = GlobalKey<FormState>();
  GlobalKey<FormState> sigInUp = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidLogIn() {
    return logIn.currentState?.validate() ?? false;
  }

  bool isValidsigInUp() {
    return sigInUp.currentState?.validate() ?? false;
  }
}
