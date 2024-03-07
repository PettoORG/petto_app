import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petto_app/utils/utils.dart';

class NotificationsService {
  static final _firebaseMesaging = FirebaseMessaging.instance;
  static final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future _firebaseNotiInit() async {
    await _firebaseMesaging.requestPermission();
    final String? token = await _firebaseMesaging.getToken();
    logger.d("DEVICE FCM TOKEN: $token");
  }

  static Future _localNotiInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsDarwin, linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: _onNotificationTap);
  }

  static void _onNotificationTap(NotificationResponse notificationResponse) {
    logger.d("onNotificationTap");
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails, payload: payload);
  }

  static Future<void> initialize() async {
    await _firebaseNotiInit();
    await _localNotiInit();
    setupFirebaseMessagingListeners();
  }

  static void setupFirebaseMessagingListeners() {
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  static Future _firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) logger.d("Some Notification recived");
  }

  static void _onMessage(RemoteMessage event) {}

  static void _onMessageOpenedApp(RemoteMessage event) {}
}
