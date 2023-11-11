import 'package:petto_app/domain/datasources/pettips_datasource.dart';
import 'package:petto_app/domain/entities/pettip.dart';

class LocalPettipsDatasource extends PettipsDatasource {
  @override
  Future<List<Pettip>> getGeneralPettips() async {
    return [];
  }
}
