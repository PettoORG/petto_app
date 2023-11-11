// import 'dart:convert';
// import 'dart:io';
// import 'package:petto_app/domain/datasources/pettips_datasource.dart';
// import 'package:petto_app/domain/entities/pettip.dart';
// import 'package:petto_app/infrastructure/mappers/pettip_mapper.dart';
// import 'package:petto_app/infrastructure/models/local_pettip.dart';

// class LocalPettipsDatasource extends PettipsDatasource {
//   @override
//   Future<List<Pettip>> getGeneralPettips() async {
//     final file = File('data/pettips_es.json');
//     final jsonData = await file.readAsString();
//     Map<String, dynamic> jsonMap = json.decode(jsonData);
//     final data = LocalPettip.fromJson(jsonMap);
//     final List<Pettip> generalPettips = data.data.map();
//     // return data['data'].map((localPettip) => PettipMapper.localPettipToEntity(localPettip)).toList();
//   }
// }
