import 'package:firebase_auth/firebase_auth.dart';
import 'package:petto_app/domain/datasources/auth_datasource.dart';

class FirebaseAuthDatasource extends AuthDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> deleteAccount() async {
    await _firebaseAuth.currentUser!.delete();
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> logIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signInUp(String email, String password, String name) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await updateName(name);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> updateName(String newName) async {
    await _firebaseAuth.currentUser!.updateDisplayName(newName);
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    await _firebaseAuth.currentUser!.updateEmail(newEmail);
  }

  @override
  Future<void> updatePassword(String newPassWord) async {
    await _firebaseAuth.currentUser!.updatePassword(newPassWord);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> reAuth(credential) async {
    await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
  }
}
