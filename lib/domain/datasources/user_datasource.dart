import 'package:petto_app/domain/entities/user.dart';

abstract class UserDatasource {
  Future<UserModel> getUserInformation();
}
