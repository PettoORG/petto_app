import 'package:petto_app/domain/datasources/reminder_datasource.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final ReminderDatasource datasource;
  ReminderRepositoryImpl(this.datasource);

  @override
  Future<void> addReminder(Reminder reminder) async {
    await datasource.addReminder(reminder);
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
