import 'package:flutter/material.dart';
import 'package:petto_app/services/services.dart';
import 'package:petto_app/utils/utils.dart';

class DBProvider extends ChangeNotifier {
  final FirestoreService _db = FirestoreService();
  final FirebaseAuthService _firebaseAuth = FirebaseAuthService();

  Future<void> updateAllowEmailNotifications(bool isAllow) async {
    try {
      await _db.updateAllowEmailNotifications(_firebaseAuth.getCurrentUser()!.uid, isAllow);
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
    }
  }

  Future<void> updateAllowPhoneNotifications(bool isAllow) async {
    try {
      await _db.updateAllowPhoneNotifications(_firebaseAuth.getCurrentUser()!.uid, isAllow);
    } catch (e) {
      logger.e('FIRESTORE ERROR: $e');
    }
  }
}
