import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._internal();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  factory FirebaseAuthService() {
    return _instance;
  }

  FirebaseAuthService._internal();

  Future<void> logIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInUp(String email, String password, String displayName) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await updateDisplayName(displayName);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> updateDisplayName(String newDisplayName) async {
    await _firebaseAuth.currentUser!.updateDisplayName(newDisplayName);
  }

  Future<void> updatePassWord(String newPassWord) async {
    await _firebaseAuth.currentUser!.updatePassword(newPassWord);
  }

  Future<void> reAuth(AuthCredential credential) async {
    await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> deleteAccount() async {
    await _firebaseAuth.currentUser!.delete();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
