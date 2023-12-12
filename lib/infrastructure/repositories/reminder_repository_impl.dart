import 'package:petto_app/domain/datasources/reminder_datasource.dart';
import 'package:petto_app/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final ReminderDatasource datasource;
  ReminderRepositoryImpl(this.datasource);

  @override
  Future<void> addReminder({required String title, required String body, required String payload}) async {
    await datasource.addReminder(title: title, body: body, payload: payload);
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
