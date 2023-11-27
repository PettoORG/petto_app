import 'package:petto_app/domain/entities/user.dart';

class UserMapper {
  static UserModel localPettipToEntity(json) => UserModel(
        displayName: json['displayName'],
        email: json['email'],
        image: json['image'],
        pets: json['pets'],
        allowEmailNotifications: json['allowEmailNotifications'],
        allowPhoneNotifications: json['allowPhoneNotifications'],
      );
}
