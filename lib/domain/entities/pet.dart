class Pet {
  final String name;
  final String specie;
  final String gender;
  final String breed;
  final String size;
  final String birthdate;
  final String age;
  final double weight;
  final String? image;
  final String? activityHabit;
  final String? dietaryHabit;
  final int? microchipId;
  final List<Medicine>? medicines;
  final List<Reminder>? reminders;
  final List<Illness>? illnesses;
  final DateTime? lastVaccine;
  final DateTime? nextVaccine;
  final List<Vaccine>? vaccines;

  Pet({
    required this.name,
    required this.specie,
    required this.gender,
    required this.breed,
    required this.size,
    required this.birthdate,
    required this.age,
    required this.weight,
    this.image,
    this.activityHabit,
    this.dietaryHabit,
    this.microchipId,
    this.reminders,
    this.medicines,
    this.illnesses,
    this.lastVaccine,
    this.nextVaccine,
    this.vaccines,
  });

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
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
      activityHabit: map['activityHabit'],
      dietaryHabit: map['dietaryHabit'],
      microchipId: map['microchipId'],
      reminders: (map['reminders'] as List<dynamic>?)?.map((item) => Reminder.fromMap(item)).toList(),
      medicines: (map['medicines'] as List<dynamic>?)?.map((item) => Medicine.fromMap(item)).toList(),
      illnesses: (map['illnesses'] as List<dynamic>?)?.map((item) => Illness.fromMap(item)).toList(),
      lastVaccine: map['lastVaccine'] != null ? DateTime.parse(map['lastVaccine']) : null,
      nextVaccine: map['nextVaccine'] != null ? DateTime.parse(map['nextVaccine']) : null,
      vaccines: (map['vaccines'] as List<dynamic>?)?.map((item) => Vaccine.fromMap(item)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'specie': specie,
      'breed': breed,
      'size': size,
      'gender': gender,
      'birthdate': birthdate,
      'age': age,
      'weight': weight,
      'image': image,
      'activityHabit': activityHabit,
      'dietaryHabit': dietaryHabit,
      'microchipId': microchipId,
      'reminders': reminders?.map((reminder) => reminder.toMap()).toList(),
      'medicines': medicines?.map((medicine) => medicine.toMap()).toList(),
      'illnesses': illnesses?.map((illness) => illness.toMap()).toList(),
      'lastVaccine': lastVaccine?.toIso8601String(),
      'nextVaccine': nextVaccine?.toIso8601String(),
      'vaccines': vaccines?.map((vaccine) => vaccine.toMap()).toList(),
    };
  }
}

class Medicine {
  final String name;
  final String purpose;
  final String interval;

  Medicine({required this.name, required this.purpose, required this.interval});

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      name: map['name'],
      purpose: map['purpose'],
      interval: map['interval'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'purpose': purpose,
      'interval': interval,
    };
  }
}

class Illness {
  final String name;
  final String symptoms;

  Illness({required this.name, required this.symptoms});

  factory Illness.fromMap(Map<String, dynamic> map) {
    return Illness(
      name: map['name'],
      symptoms: map['symptoms'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'symptoms': symptoms,
    };
  }
}

class Vaccine {
  final String name;
  final String date;

  Vaccine({required this.name, required this.date});

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      name: map['name'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
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
