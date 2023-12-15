import 'package:petto_app/domain/entities/pettip.dart';

abstract class PettipsDatasource {
  Future<List<Pettip>> getGeneralPettips(String language);
}
