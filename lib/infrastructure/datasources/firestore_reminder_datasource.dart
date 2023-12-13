import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:petto_app/domain/datasources/reminder_datasource.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FirestoreReminderDatasource extends ReminderDatasource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(onDidReceiveLocalNotification: (id, title, body, payload) {});
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {},
    );
  }

  @override
  Future<void> addReminder(Reminder reminder) async {
    tz.initializeTimeZones();
    final tzDateTime = tz.TZDateTime.from(DateTime.parse(reminder.date), tz.local);

    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'pet-care-reminders',
      'Reminders channel',
      channelDescription: 'Reminders about caring for your pets',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'Tu mascota necesita atención',
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      reminder.id,
      reminder.title,
      reminder.body,
      payload: reminder.payload,
      tzDateTime.add(const Duration(hours: 2)),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );

    await _db.collection('users').doc(_getUid()).collection('reminders').doc(reminder.id.toString()).set(
          reminder.toMap(),
        );
  }

  @override
  deleteReminder() {
    // TODO: implement deleteReminder
    throw UnimplementedError();
  }

  @override
  getReminders() {
    // TODO: implement getReminders
    throw UnimplementedError();
  }

  String _getUid() {
    try {
      return _firebaseAuth.currentUser!.uid;
    } catch (e) {
      logger.e('AUTH ERROR: $e');
      rethrow;
    }
  }
}
