abstract class ReminderDatasource {
  Future<void> addReminder({required String title, required String body, required String payload});

  deleteReminder();

  getReminders();
}
