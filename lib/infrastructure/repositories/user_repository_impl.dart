import 'package:petto_app/domain/datasources/user_datasource.dart';
import 'package:petto_app/domain/entities/user.dart';
import 'package:petto_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;
  UserRepositoryImpl(this.datasource);

  @override
  Future<void> deleteUser(String uid) async {
    await datasource.deleteUser(uid);
  }

  @override
  Future<User> getUser(String uid) async {
    return await datasource.getUser(uid);
  }

  @override
  Future<void> updateAllowEmailNotifications(String uid, bool isAllow) async {
    await datasource.updateAllowEmailNotifications(uid, isAllow);
  }

  @override
  Future<void> updateAllowPhoneNotifications(String uid, bool isAllow) async {
    await datasource.updateAllowPhoneNotifications(uid, isAllow);
  }

  @override
  Future<void> updateName(String uid, String newName) async {
    await datasource.updateName(uid, newName);
  }

  @override
  Future<void> updateEmail(String uid, String newEmail) async {
    await datasource.updateEmail(uid, newEmail);
  }

  @override
  Future<void> registerUser(String uid, User user) async {
    await datasource.registerUser(uid, user);
  }
}
