import 'package:petto_app/domain/entities/user.dart';

abstract class UserDatasource {
  Future<User> getUser();

  Future<void> addUser(Map<String, dynamic> user);

  Future<void> updateDisplayName(String newDisplayName);

  Future<void> updateEmail(String newEmail);

  Future<void> updateAllowEmailNotifications(bool isAllow);

  Future<void> updateAllowPhoneNotifications(bool isAllow);

  Future<void> deleteUser();
}
