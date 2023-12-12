import 'package:petto_app/domain/datasources/reminder_datasource.dart';

abstract class ReminderRepository extends ReminderDatasource {
  @override
  Future<void> addReminder({required String title, required String body, required String payload});

  @override
  deleteReminder();

  @override
  getReminders();
}
