class Pet {
  final String specie;
  final String breed;
  final String gender;
  final DateTime birthdate;
  final double weight;
  final String? image;
  final String activityHabit;
  final String dietaryHabit;

  Pet({
    required this.specie,
    required this.breed,
    required this.gender,
    required this.birthdate,
    required this.weight,
    this.image,
    required this.activityHabit,
    required this.dietaryHabit,
  });

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      specie: map['specie'],
      breed: map['breed'],
      gender: map['gender'],
      birthdate: map['birthdate'],
      weight: map['weight'],
      image: map['image'],
      activityHabit: map['activityHabit'],
      dietaryHabit: map['dietaryHabit'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'specie': specie,
      'breed': breed,
      'gender': gender,
      'birthdate': birthdate.toIso8601String(),
      'weight': weight,
      'image': image,
      'activityHabit': activityHabit,
      'dietaryHabit': dietaryHabit,
    };
  }
}
