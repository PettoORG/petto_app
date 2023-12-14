import 'package:petto_app/domain/datasources/reminder_datasource.dart';
import 'package:petto_app/domain/entities/entities.dart';

abstract class ReminderRepository extends ReminderDatasource {
  @override
  Future<void> addReminder(Reminder reminder);

  @override
  Future<void> deleteReminder(String reminderId);

  @override
  Future<List<Reminder>> getReminders();
}
