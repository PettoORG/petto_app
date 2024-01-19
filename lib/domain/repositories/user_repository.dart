import 'package:petto_app/domain/datasources/user_datasource.dart';
import 'package:petto_app/domain/entities/entities.dart';

abstract class UserRepository extends UserDatasource {
  @override
  Future<User> getUser(String uid);

  @override
  Future<void> registerUser(String uid, Map<String, dynamic> user);

  @override
  Future<void> deleteUser(String uid);

  @override
  Future<void> updateName(String uid, String newName);

  @override
  Future<void> updateEmail(String uid, String newEmail);

  @override
  Future<void> updateAllowEmailNotifications(String uid, bool isAllow);

  @override
  Future<void> updateAllowPhoneNotifications(String uid, bool isAllow);
}
