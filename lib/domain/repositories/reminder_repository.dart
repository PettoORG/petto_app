import 'package:petto_app/domain/datasources/reminder_datasource.dart';

abstract class ReminderRepository extends ReminderDatasource {
  @override
  addReminder();

  @override
  deleteReminder();

  @override
  getReminders();
}
