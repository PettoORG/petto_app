import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petto_app/domain/entities/notification.dart';

class Reminder extends GeneralNotification {
  final String petId;
  final String category;
  final DateTime reminderDate;

  Reminder({
    required this.petId,
    required this.category,
    required this.reminderDate,
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
      'description': description,
      'petId': petId,
      'category': category,
      'reminderDate': Timestamp.fromDate(reminderDate),
      'image': image,
      'name': name
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      petId: map['petId'],
      category: map['category'],
      reminderDate: (map['reminderDate'] as Timestamp).toDate(),
    );
  }
}

class ReminderCategory {
  final String text;
  final String value;

  ReminderCategory({required this.text, required this.value});
}
