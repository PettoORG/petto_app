import 'package:petto_app/domain/datasources/pettips_datasource.dart';
import 'package:petto_app/domain/repositories/movies_repository.dart';

class PettipRepositoryImpl extends PettipsRepository {
  final PettipsDatasource datasource;

  PettipRepositoryImpl(this.datasource);
  @override
  getGeneralPettips() {
    return datasource.getGeneralPettips();
  }
}
