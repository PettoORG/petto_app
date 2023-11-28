import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petto_app/domain/datasources/user_datasource.dart';
import 'package:petto_app/domain/entities/user.dart';
import 'package:petto_app/utils/utils.dart';

class FirestoreUserDatasource extends UserDatasource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  @override
  Future<User> getUser() async {
    return await _db.collection('users').doc(_getUid()).get().then((DocumentSnapshot snapshot) {
      logger.d(snapshot);
      return User(
        displayName: snapshot['displayName'],
        email: snapshot['email'],
        image: snapshot['image'],
        allowEmailNotifications: snapshot['allowEmailNotifications'],
        allowPhoneNotifications: snapshot['allowPhoneNotifications'],
      );
    });
  }

  @override
  Future<void> addUser(Map<String, dynamic> user) async {
    await _db.collection('users').doc(_getUid()).set(user);
  }

  @override
  Future<void> deleteUser() async {
    await _db.collection('users').doc(_getUid()).delete();
  }

  @override
  Future<void> updateAllowEmailNotifications(bool isAllow) async {
    await _db.collection('users').doc(_getUid()).update({'allowEmailNotifications': isAllow});
  }

  @override
  Future<void> updateAllowPhoneNotifications(bool isAllow) async {
    await _db.collection('users').doc(_getUid()).update({'allowPhoneNotifications': isAllow});
  }

  @override
  Future<void> updateDisplayName(String newDisplayName) async {
    await _db.collection('users').doc(_getUid()).update({'displayName': newDisplayName});
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    await _db.collection('users').doc(_getUid()).update({'displayName': newEmail});
  }

  String? _getUid() {
    try {
      return _firebaseAuth.currentUser!.uid;
    } catch (e) {
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }
}
