import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  late UserCredential? authInfo;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> signInWithEmailAndPassWord({required String email, required String password}) async {
    authInfo = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({required String email, required String password}) async {
    authInfo = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
