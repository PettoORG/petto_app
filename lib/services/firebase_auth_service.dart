import 'package:firebase_auth/firebase_auth.dart';
import 'package:petto_app/utils/utils.dart';

class Auth {
  late final UserCredential authInfo;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> signInWithEmailAndPassWord({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> siginUpWithEmailAndPassword({required String email, required String password}) async {
    authInfo = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: "user@example.com",
      password: "password",
    );
  }

  Future<void> signOut({required String email, required String password}) async {
    await _firebaseAuth.signOut();
  }
}
