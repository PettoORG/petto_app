import 'package:petto_app/domain/entities/reminder.dart';

abstract class ReminderDatasource {
  Future<void> addReminder(Reminder reminder);

  deleteReminder();

  Future<List<Reminder>> getReminders();
}
