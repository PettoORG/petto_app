class User {
  final String uid;
  final String name;
  final String email;
  final String? image;
  final bool allowEmailNotifications;
  final bool allowPhoneNotifications;

  User({
    required this.name,
    required this.uid,
    required this.email,
    this.image,
    required this.allowEmailNotifications,
    required this.allowPhoneNotifications,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      image: map['image'],
      allowEmailNotifications: map['allowEmailNotifications'],
      allowPhoneNotifications: map['allowPhoneNotifications'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'allowEmailNotifications': allowEmailNotifications,
      'allowPhoneNotifications': allowPhoneNotifications,
    };
  }
}
