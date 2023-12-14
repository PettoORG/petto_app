import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/infrastructure/datasources/firestore_reminder_datasource.dart';
import 'package:petto_app/infrastructure/repositories/reminder_repository_impl.dart';
import 'package:petto_app/utils/logger_prints.dart';
import 'package:uuid/uuid.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderRepositoryImpl _datasource = ReminderRepositoryImpl(FirestoreReminderDatasource());

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
    int insertionIndex = 0;
    String numericId = uniqueId.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericId.length > 10) {
      numericId = numericId.substring(0, 9);
    }

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
    try {
      isLoading = true;
      await _datasource.addReminder(reminder);
      for (int i = 0; i < reminders.length; i++) {
        if (DateTime.parse(reminder.date).isAfter(DateTime.parse(reminders[i].date))) {
          insertionIndex = i + 1;
        } else {
          break;
        }
      }
      reminders.insert(insertionIndex, reminder);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      logger.e('REMINDER ERROR: $e');
      rethrow;
    }
  }

  Future<void> getReminders() async {
    isLoading = true;
    try {
      reminders = await _datasource.getReminders();
      DateTime now = DateTime.now();
      // Filter reminders that have a date prior to DateTime.now().
      List<Reminder> remindersToDelete = reminders.where((reminder) {
        DateTime reminderDate = DateTime.parse(reminder.date);
        return reminderDate.isBefore(DateTime(now.year, now.month, now.day));
      }).toList();
      // Delete the filtered reminders.
      for (Reminder reminder in remindersToDelete) {
        await _datasource.deleteReminder(reminder.id.toString());
        reminders.remove(reminder);
      }
      // Sort the remaining reminders by date.
      reminders.sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
      isLoading = false;
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }
}
