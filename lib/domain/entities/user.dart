import 'package:petto_app/domain/entities/pet.dart';

class User {
  final String displayName;
  final String email;
  final String? image;
  final List<Pet> pets;
  final bool allowEmailNotifications;
  final bool allowPhoneNotifications;

  User({
    required this.displayName,
    required this.email,
    required this.image,
    required this.pets,
    required this.allowEmailNotifications,
    required this.allowPhoneNotifications,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      displayName: map['displayName'],
      email: map['email'],
      image: map['image'],
      pets: (map['pets'] as List<dynamic>?)?.map((petMap) => Pet.fromMap(petMap)).toList() ?? [],
      allowEmailNotifications: map['allowEmailNotifications'],
      allowPhoneNotifications: map['allowPhoneNotifications'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'image': image,
      'pets': pets.map((pet) => pet.toMap()).toList(),
      'allowEmailNotifications': allowEmailNotifications,
      'allowPhoneNotifications': allowPhoneNotifications,
    };
  }
}
