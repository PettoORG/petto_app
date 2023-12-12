import 'package:flutter/material.dart';
import 'package:petto_app/infrastructure/datasources/local_reminder_datasource.dart';
import 'package:petto_app/infrastructure/repositories/reminder_repository_impl.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderRepositoryImpl _reminderRepository = ReminderRepositoryImpl(LocalReminderDatasource());
}
