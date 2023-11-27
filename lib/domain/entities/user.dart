import 'package:petto_app/domain/entities/pet.dart';

class UserModel {
  final String displayName;
  final String email;
  final String? image;
  final List<Pet> pets;
  final bool allowEmailNotifications;
  final bool allowPhoneNotifications;

  UserModel({
    required this.displayName,
    required this.email,
    required this.image,
    required this.pets,
    required this.allowEmailNotifications,
    required this.allowPhoneNotifications,
  });

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
