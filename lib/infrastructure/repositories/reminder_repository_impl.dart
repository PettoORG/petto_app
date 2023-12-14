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
  Future<void> deleteReminder(String reminderId) async {
    await datasource.deleteReminder(reminderId);
  }

  @override
  Future<List<Reminder>> getReminders() async {
    return await datasource.getReminders();
  }
}
