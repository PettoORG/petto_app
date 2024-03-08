import 'package:petto_app/domain/entities/reminder.dart';

abstract class ReminderDatasource {
  Future<void> addReminder(Reminder reminder);

  Future<List<ReminderCategory>> getCategories(String locale);

  Future<void> deleteReminder(String reminderId);

  Future<List<Reminder>> getReminders();
}
