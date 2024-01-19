import 'package:petto_app/domain/datasources/auth_datasource.dart';

abstract class AuthRepository extends AuthDatasource {
  @override
  Future<void> deleteAccount();

  @override
  dynamic getCurrentUser();

  @override
  Future<void> logIn(String email, String password);

  @override
  Future<void> signInUp(String email, String password, String name);

  @override
  Future<void> signOut();

  @override
  Future<void> sendPasswordResetEmail(String email);

  @override
  Future<void> updateName(String newName);

  @override
  Future<void> updatePassword(String newPassWord);

  @override
  Future<void> reAuth(credential);

  @override
  Future<void> updateEmail(String newEmail);
}
