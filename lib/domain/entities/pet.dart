class Pet {
  final String name;
  final String specie;
  final String gender;
  final String breed;
  final String size;
  final String birthdate;
  final String age;
  final String weight;
  final String? id;
  final String? foodType;
  final String? lastVeterinarySession;
  final String? lastDeworming;
  final String? image;
  final String? microchipId;
  final List<Reminder>? reminders;

  Pet({
    required this.name,
    required this.specie,
    required this.gender,
    required this.breed,
    required this.size,
    required this.birthdate,
    required this.age,
    required this.weight,
    this.foodType,
    this.lastVeterinarySession,
    this.lastDeworming,
    this.id,
    this.image,
    this.microchipId,
    this.reminders,
  });

  factory Pet.fromMap(Map<String, dynamic> map, String id) {
    return Pet(
      id: id,
      name: map['name'],
      specie: map['specie'],
      breed: map['breed'],
      size: map['size'],
      gender: map['gender'],
      birthdate: map['birthdate'],
      age: map['age'],
      weight: map['weight'],
      image: map['image'] ??
          'https://firebasestorage.googleapis.com/v0/b/petto-18ace.appspot.com/o/avatars%2Fpetto-avatar.png?alt=media&token=8fe0315f-ef69-4fca-8d03-e3e4bef73ad3',
      microchipId: map['microchipId'],
      reminders: (map['reminders'] as List<dynamic>?)?.map((item) => Reminder.fromMap(item)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specie': specie,
      'breed': breed,
      'size': size,
      'gender': gender,
      'birthdate': birthdate,
      'age': age,
      'weight': weight,
      'image': image,
      'microchipId': microchipId,
      'reminders': reminders?.map((reminder) => reminder.toMap()).toList(),
    };
  }
}

class Reminder {
  final String reminder;
  final String date;

  Reminder({required this.reminder, required this.date});

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      reminder: map['name'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': reminder,
      'date': date,
    };
  }
}
