import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/infrastructure/datasources/firestore_reminder_datasource.dart';
import 'package:petto_app/infrastructure/repositories/reminder_repository_impl.dart';
import 'package:uuid/uuid.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderRepositoryImpl _reminderRepository = ReminderRepositoryImpl(FirestoreReminderDatasource());

  List<Reminder> reminders = [];

  var uuid = const Uuid();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addReminder(String petId, String image, String title, String body, String date) async {
    String uniqueId = uuid.v4();
    String numericId = uniqueId.replaceAll(RegExp(r'[^0-9]'), '');
    int reminderId = int.parse(numericId);
    Reminder reminder = Reminder(
      petId: petId,
      image: image,
      id: reminderId,
      title: title,
      body: body,
      payload: '',
      date: date,
    );
    await _reminderRepository.addReminder(reminder);
    reminders.add(reminder);
    notifyListeners();
  }
}
