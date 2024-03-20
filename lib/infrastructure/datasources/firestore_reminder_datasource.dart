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
    DocumentReference ref = await _db.collection('users').doc(_getUid()).collection('reminders').add(reminder.toMap());
    await _db.collection('users').doc(_getUid()).collection('reminders').doc(ref.id).update({'id': ref.id});
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
  Future<ReminderConfig> getReminderConfig(String locale) async {
    DocumentSnapshot document = await _db.collection('configuration').doc('reminders').get();
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //Categories
    Map<String, dynamic> categoriesMap = data['categories'][locale];
    List<ReminderCategory> categories = categoriesMap.entries.map((entry) {
      return ReminderCategory(text: entry.value['text'], value: entry.key);
    }).toList();

    //Frecuencies
    Map<String, dynamic> frequenciesMap = data['frequencies'][locale];
    List<ReminderFrecuency> frequencies = frequenciesMap.entries.map((entry) {
      return ReminderFrecuency(text: entry.value['text'], value: entry.key);
    }).toList();

    return ReminderConfig(categories: categories, frequencies: frequencies);
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
