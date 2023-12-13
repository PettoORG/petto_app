import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/infrastructure/datasources/firestore_reminder_datasource.dart';
import 'package:petto_app/infrastructure/repositories/reminder_repository_impl.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderRepositoryImpl _reminderRepository = ReminderRepositoryImpl(FirestoreReminderDatasource());
  int id = 1;

  Future<void> addReminder(Reminder reminder) async {
    await _reminderRepository.addReminder(reminder);
  }
}
