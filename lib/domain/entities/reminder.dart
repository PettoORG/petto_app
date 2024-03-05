class Reminder {
  final String petId;
  final String id;
  final String title;
  final String category;
  final String body;
  final String payload;
  final String date;
  final String image;

  Reminder({
    required this.petId,
    required this.id,
    required this.title,
    required this.category,
    required this.body,
    required this.payload,
    required this.date,
    required this.image,
  });

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      petId: map['petId'],
      id: map['id'],
      title: map['title'],
      body: map['body'],
      payload: map['payload'],
      date: map['date'],
      image: map['image'],
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'petId': petId,
      'id': id,
      'title': title,
      'category': category,
      'body': body,
      'payload': payload,
      'date': date,
      'image': image,
    };
  }
}

class Category {
  final String text;
  final String value;

  Category({required this.text, required this.value});
}
