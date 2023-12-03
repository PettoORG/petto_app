import 'package:petto_app/domain/entities/user.dart';

abstract class UserDatasource {
  Future<User> getUser();

  dynamic getAuthUser();

  Future<void> addUser(Map<String, dynamic> user);

  Future<void> updateDisplayName(String newDisplayName);

  Future<void> updateEmail(String newEmail);

  Future<void> updatePassWord(String newPassWord);

  Future<void> updateAllowEmailNotifications(bool isAllow);

  Future<void> updateAllowPhoneNotifications(bool isAllow);

  Future<void> deleteUser();

  Future<void> signOut();
}
