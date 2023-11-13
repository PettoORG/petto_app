import 'package:flutter/material.dart';
import 'package:petto_app/domain/entities/pettip.dart';
import 'package:petto_app/infrastructure/datasources/local_pettips_datasource.dart';
import 'package:petto_app/infrastructure/repositories/pettip_repository_impl.dart';

class PettipsProvider extends ChangeNotifier {
  final PettipRepositoryImpl _pettipsRepository = PettipRepositoryImpl(LocalPettipsDatasource());
  List<Pettip> _generalPettips = [];

  Future<List<Pettip>> getGeneralPettips() async {
    if (_generalPettips.isNotEmpty) {
      return _generalPettips;
    } else {
      _generalPettips = await _pettipsRepository.getGeneralPettips();
      return _generalPettips;
    }
  }
}
