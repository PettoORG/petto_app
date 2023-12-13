class Reminder {
  final String petId;
  final int id;
  final String title;
  final String body;
  final String payload;
  final String date;

  Reminder({
    required this.petId,
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.date,
  });

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      petId: map['petId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
      payload: map['payload'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'petId': petId,
      'id': id,
      'title': title,
      'body': body,
      'payload': payload,
      'date': date,
    };
  }
}
