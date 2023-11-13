import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:petto_app/domain/datasources/pettips_datasource.dart';
import 'package:petto_app/domain/entities/pettip.dart';
import 'package:petto_app/infrastructure/mappers/pettip_mapper.dart';

class LocalPettipsDatasource extends PettipsDatasource {
  @override
  Future<List<Pettip>> getGeneralPettips() async {
    final response = await rootBundle.loadString('data/pettips_es.json');
    Map<String, dynamic> localResponse = json.decode(response);
    final List<Pettip> generalPettips =
        localResponse.entries.map((pettip) => PettipMapper.localPettipToEntity(pettip.value)).toList();
    return generalPettips;
  }
}
