import 'package:petto_app/domain/datasources/user_datasource.dart';
import 'package:petto_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;
  UserRepositoryImpl(this.datasource);

  @override
  getUserInformation() {
    return datasource.getUserInformation();
  }
}
