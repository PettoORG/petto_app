import 'package:petto_app/domain/datasources/auth_datasource.dart';
import 'package:petto_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;
  AuthRepositoryImpl(this.datasource);

  @override
  Future<void> deleteAccount() async {
    await datasource.deleteAccount();
  }

  @override
  dynamic getCurrentUser() {
    return datasource.getCurrentUser();
  }

  @override
  Future<void> logIn(String email, String password) async {
    await datasource.logIn(email, password);
  }

  @override
  Future<void> signInUp(String email, String password, String name) async {
    await datasource.signInUp(email, password, name);
  }

  @override
  Future<void> signOut() async {
    await datasource.signOut();
  }

  @override
  Future<void> updateName(String newName) async {
    await datasource.updateName(newName);
  }

  @override
  Future<void> updatePassword(String newPassWord) async {
    await datasource.updatePassword(newPassWord);
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    await datasource.updateEmail(newEmail);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await datasource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> reAuth(credential) async {
    await datasource.reAuth(credential);
  }
}
