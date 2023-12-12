import 'package:petto_app/domain/datasources/reminder_datasource.dart';
import 'package:petto_app/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final ReminderDatasource datasource;
  ReminderRepositoryImpl(this.datasource);

  @override
  addReminder() {
    datasource.addReminder();
  }

  @override
  deleteReminder() {
    datasource.deleteReminder();
  }

  @override
  getReminders() {
    datasource.getReminders();
  }
}
