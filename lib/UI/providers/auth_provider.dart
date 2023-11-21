import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petto_app/utils/utils.dart';

class AuthenticationProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GlobalKey<FormState> logInKey = GlobalKey<FormState>();
  GlobalKey<FormState> sigInUpKey = GlobalKey<FormState>();
  GlobalKey<FormState> myAccount = GlobalKey<FormState>();
  String password = '';

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
    await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password);
    logger.d(getCurrentUser());
  }

  Future<void> signInUp() async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email!,
      password: password,
    );
    await userCredential.user!.updateDisplayName(displayName);
    logger.d(getCurrentUser());
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    logger.d(getCurrentUser());
  }

  Future<void> updateDisplayName() async {
    await _firebaseAuth.currentUser!.updateDisplayName(displayName);
  }

  Future<void> updateEmail() async {
    await _firebaseAuth.currentUser!.updateEmail(email!);
  }

  // Future<void> reauthenticateWithCredential() async {
  //   await _firebaseAuth.currentUser!.reauthenticateWithCredential(
  //     EmailAuthProvider.credential(email: _firebaseAuth.currentUser., password: password),
  //   );
  // }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  bool isValidLogIn() {
    return logInKey.currentState?.validate() ?? false;
  }

  bool isValidsigInUp() {
    return sigInUpKey.currentState?.validate() ?? false;
  }

  bool isValidMyAccount() {
    return myAccount.currentState?.validate() ?? false;
  }
}
