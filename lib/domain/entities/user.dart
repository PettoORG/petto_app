class User {
  final String displayName;
  final String email;
  final String? image;
  final bool allowEmailNotifications;
  final bool allowPhoneNotifications;

  User({
    required this.displayName,
    required this.email,
    required this.image,
    required this.allowEmailNotifications,
    required this.allowPhoneNotifications,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      displayName: map['displayName'],
      email: map['email'],
      image: map['image'],
      allowEmailNotifications: map['allowEmailNotifications'],
      allowPhoneNotifications: map['allowPhoneNotifications'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'image': image,
      'allowEmailNotifications': allowEmailNotifications,
      'allowPhoneNotifications': allowPhoneNotifications,
    };
  }
}
