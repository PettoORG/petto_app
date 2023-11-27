import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();

  Future<void> addUser(Map<String, dynamic> user, String uid) async {
    await _db.collection('users').doc(uid).set(user);
  }

  Future<void> deleteUser(String uid) async {
    await _db.collection('users').doc(uid).delete();
  }

  Future<void> updateDisplayName(String uid, String newDisplayName) async {
    await _db.collection('users').doc(uid).update({'displayName': newDisplayName});
  }

  Future<void> updateEmail(String uid, String newEmail) async {
    await _db.collection('users').doc(uid).update({'displayName': newEmail});
  }

  Future<void> updateAllowEmailNotifications(String uid, bool isAllow) async {
    await _db.collection('users').doc(uid).update({'allowEmailNotifications': isAllow});
  }

  Future<void> updateAllowPhoneNotifications(String uid, bool isAllow) async {
    await _db.collection('users').doc(uid).update({'allowPhoneNotifications': isAllow});
  }
}
