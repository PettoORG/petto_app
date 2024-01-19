import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petto_app/domain/datasources/user_datasource.dart';
import 'package:petto_app/domain/entities/user.dart';
import 'package:petto_app/utils/logger_prints.dart';

class FirestoreUserDatasource extends UserDatasource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<User> getUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _db.collection('users').doc(uid).get();
    logger.d(snapshot.data());
    return User.fromMap(snapshot.data()!);
  }

  @override
  Future<void> registerUser(String uid, Map<String, dynamic> user) async {
    await _db.collection('users').doc(uid).set(user);
  }

  @override
  Future<void> deleteUser(String uid) async {
    await _db.collection('users').doc(uid).delete();
  }

  @override
  Future<void> updateAllowEmailNotifications(String uid, bool isAllow) async {
    await _db.collection('users').doc(uid).update({'allowEmailNotifications': isAllow});
  }

  @override
  Future<void> updateAllowPhoneNotifications(String uid, bool isAllow) async {
    await _db.collection('users').doc(uid).update({'allowPhoneNotifications': isAllow});
  }

  @override
  Future<void> updateName(String uid, String newName) async {
    await _db.collection('users').doc(uid).update({'name': newName});
  }

  @override
  Future<void> updateEmail(String uid, String newEmail) async {
    await _db.collection('users').doc(uid).update({'name': newEmail});
  }
}
