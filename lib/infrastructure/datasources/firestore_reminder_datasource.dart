import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:petto_app/domain/datasources/reminder_datasource.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/utils/utils.dart';

class FirestoreReminderDatasource extends ReminderDatasource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  @override
  Future<void> addReminder(Reminder reminder) async {
    // TODO: implement addReminder
    throw UnimplementedError();
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    await _db.collection('users').doc(_getUid()).collection('reminders').doc(reminderId).delete();
  }

  @override
  Future<List<Reminder>> getReminders() async {
    CollectionReference reminderRef = _db.collection('users').doc(_getUid()).collection('reminders');
    QuerySnapshot snapshot = await reminderRef.get();
    List<Reminder> reminders = [];
    for (DocumentSnapshot document in snapshot.docs) {
      Reminder reminder = Reminder.fromMap(document.data() as Map<String, dynamic>);
      reminders.add(reminder);
    }
    return reminders;
  }

  @override
  Future<List<Category>> getCategories(String locale) async {
    DocumentSnapshot document = await _db.collection('configuration').doc('reminders').get();
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Map<String, dynamic> categoriesMap = data[locale];
    List<Category> categories = categoriesMap.entries.map((entry) {
      return Category(text: entry.value['text'], value: entry.key);
    }).toList();
    return categories;
  }

  String _getUid() {
    try {
      return _firebaseAuth.currentUser!.uid;
    } catch (e) {
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }
}
