class Pet {
  final PetSpecie specie;
  final String breed;
  final Gender gender;
  final DateTime birthdate;
  final double weight;
  final String? image;
  final ActivityHabit activityHabit;
  final DietaryHabit dietaryHabit;

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

enum PetSpecie { dog, cat }

enum Gender { female, male }

enum ActivityHabit { active, sedentary }

enum DietaryHabit { natural, commercial }
