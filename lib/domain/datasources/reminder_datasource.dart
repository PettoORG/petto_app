import 'package:petto_app/domain/entities/entities.dart';

abstract class ReminderDatasource {
  Future<void> addReminder(Reminder reminder);

  Future<ReminderConfig> getReminderConfig(String locale);

  Future<void> deleteReminder(String reminderId);

  Future<List<Reminder>> getReminders();
}
