import 'package:petto_app/domain/entities/entities.dart';

abstract class UserDatasource {
  Future<User> getUser(String uid);

  Future<void> registerUser(String uid, User user);

  Future<void> updateName(String uid, String newName);

  Future<void> updateEmail(String uid, String newEmail);

  Future<void> updateAllowEmailNotifications(String uid, bool isAllow);

  Future<void> updateAllowPhoneNotifications(String uid, bool isAllow);

  Future<void> deleteUser(String uid);
}
