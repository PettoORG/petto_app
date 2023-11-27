import 'package:petto_app/domain/datasources/user_datasource.dart';
import 'package:petto_app/domain/entities/entities.dart';

abstract class UserRepository extends UserDatasource {
  @override
  Future<User> getUser();

  @override
  Future<void> addUser(Map<String, dynamic> user);

  @override
  Future<void> deleteUser();

  @override
  Future<void> updateDisplayName(String newDisplayName);

  @override
  Future<void> updateEmail(String newEmail);

  @override
  Future<void> updateAllowEmailNotifications(bool isAllow);

  @override
  Future<void> updateAllowPhoneNotifications(bool isAllow);
}
