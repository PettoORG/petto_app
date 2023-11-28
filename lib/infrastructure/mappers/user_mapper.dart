import 'package:petto_app/domain/entities/user.dart';

class UserMapper {
  static User localPettipToEntity(json) => User(
        displayName: json['displayName'],
        email: json['email'],
        image: json['image'],
        allowEmailNotifications: json['allowEmailNotifications'],
        allowPhoneNotifications: json['allowPhoneNotifications'],
      );
}
