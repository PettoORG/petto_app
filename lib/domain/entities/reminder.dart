import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petto_app/domain/entities/notification.dart';

class Reminder extends GeneralNotification {
  final String petId;
  final String fcmToken;
  final String category;
  final DateTime startTime;
  final RepeatConfig repeatConfig;

  Reminder({
    required this.petId,
    required this.fcmToken,
    required this.category,
    required this.repeatConfig,
    required this.startTime,
    required super.title,
    required super.description,
    required super.id,
    super.image,
    super.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'fcmToken': fcmToken,
      'repeatConfig': repeatConfig,
      'description': description,
      'petId': petId,
      'category': category,
      'startTime': Timestamp.fromDate(startTime),
      'image': image,
      'name': name
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      title: map['title'],
      fcmToken: map['fcmToken'],
      image: map['image'],
      description: map['description'],
      petId: map['petId'],
      category: map['category'],
      startTime: (map['startTime'] as Timestamp).toDate(),
      repeatConfig: map['repeatConfig'],
    );
  }
}

class RepeatConfig {
  final RepeatType type;
  final List<DateTime>? times;
  final int? repeatEvery;
  final List<int>? daysOfWeek;
  final List<int>? daysOfMonth;

  RepeatConfig({
    required this.type,
    this.times,
    this.repeatEvery,
    this.daysOfWeek,
    this.daysOfMonth,
  });
}

enum RepeatType {
  none,
  multipleTimesADay,
  daily,
  weekly,
  monthly,
  yearly,
  custom,
}
