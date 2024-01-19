abstract class AuthDatasource {
  Future<void> logIn(String email, String password);

  Future<void> signInUp(String email, String password, String name);

  Future<void> updateName(String newName);

  Future<void> updatePassword(String newPassWord);

  Future<void> reAuth(credential);

  Future<void> updateEmail(String newEmail);

  Future<void> deleteAccount();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();

  dynamic getCurrentUser();
}
