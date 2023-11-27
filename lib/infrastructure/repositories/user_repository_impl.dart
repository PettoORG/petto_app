import 'package:petto_app/domain/datasources/user_datasource.dart';
import 'package:petto_app/domain/entities/user.dart';
import 'package:petto_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;
  UserRepositoryImpl(this.datasource);

  @override
  Future<void> deleteUser() async {
    await datasource.deleteUser();
  }

  @override
  Future<User> getUser() async {
    return await datasource.getUser();
  }

  @override
  Future<void> updateAllowEmailNotifications(bool isAllow) async {
    await datasource.updateAllowEmailNotifications(isAllow);
  }

  @override
  Future<void> updateAllowPhoneNotifications(bool isAllow) async {
    await datasource.updateAllowPhoneNotifications(isAllow);
  }

  @override
  Future<void> updateDisplayName(String newDisplayName) async {
    await datasource.updateDisplayName(newDisplayName);
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    await datasource.updateEmail(newEmail);
  }

  @override
  Future<void> addUser(Map<String, dynamic> user) async {
    await datasource.addUser(user);
  }
}
