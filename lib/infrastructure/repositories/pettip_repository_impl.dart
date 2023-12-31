import 'package:petto_app/domain/datasources/pettips_datasource.dart';
import 'package:petto_app/domain/repositories/pettips_repository.dart';

class PettipRepositoryImpl extends PettipsRepository {
  final PettipsDatasource datasource;
  PettipRepositoryImpl(this.datasource);

  @override
  getGeneralPettips(String language) {
    return datasource.getGeneralPettips(language);
  }
}
