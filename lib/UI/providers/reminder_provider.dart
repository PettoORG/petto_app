import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/infrastructure/datasources/firestore_reminder_datasource.dart';
import 'package:petto_app/infrastructure/repositories/reminder_repository_impl.dart';
import 'package:petto_app/services/services.dart';
import 'package:petto_app/utils/logger_prints.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderRepositoryImpl _datasource = ReminderRepositoryImpl(FirestoreReminderDatasource());

  List<Reminder> reminders = [];

  List<ReminderCategory> categories = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addReminder(
    String petId,
    String image,
    String title,
    String description,
    DateTime reminderDate,
    String category,
    RepeatConfig repeatConfig,
  ) async {
    int insertionIndex = 0;

    Reminder reminder = Reminder(
      petId: petId,
      image: image,
      repeatConfig: repeatConfig,
      id: '',
      title: title,
      fcmToken: await NotificationsService.getFcmToken(),
      category: category,
      description: description,
      startTime: reminderDate,
    );
    try {
      await requestNotificationPermission();
      isLoading = true;
      await _datasource.addReminder(reminder);
      for (int i = 0; i < reminders.length; i++) {
        if (reminder.startTime.isAfter(reminders[i].startTime)) {
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

  Future<List<ReminderCategory>> getCategories(String locale) async {
    try {
      categories = await _datasource.getCategories(locale);
      return categories;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getReminders() async {
    try {
      reminders = await _datasource.getReminders();
      DateTime now = DateTime.now();
      // Filter reminders that have a date prior to DateTime.now().
      List<Reminder> remindersToDelete = reminders.where((reminder) {
        DateTime reminderDate = reminder.startTime;
        return reminderDate.isBefore(DateTime(now.year, now.month, now.day));
      }).toList();
      // Delete the filtered reminders.
      for (Reminder reminder in remindersToDelete) {
        await _datasource.deleteReminder(reminder.id.toString());
        reminders.remove(reminder);
      }
      // Sort the remaining reminders by date.
      reminders.sort((a, b) => a.startTime.compareTo(b.startTime));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;

    if (!status.isGranted) {
      status = await Permission.notification.request();
    }
  }
}
