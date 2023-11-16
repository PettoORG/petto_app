import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPoliciesView extends StatelessWidget {
  static const name = 'privacy';

  const PrivacyPoliciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder(future: getPrivacyInfo(), 
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          return Column(
            children: [],
          );
        }else{
          return Container(
            color: Colors.red,
          );
        }
      },), 
    );
  }

Future<List<_PrivacyPolity>> getPrivacyInfo() async {
    try {
      final jsonString = await rootBundle.loadString("data/politics_es.json");
      Map<String, dynamic> response = json.decode(jsonString);
      final dynamic respuesta = response.entries.map((value) => _PrivacyPolity.fromJson(value.value)); 
      return [];
      //return List<_PrivacyPolity> data = privacyPolicyMap.map((key, value) => null);
    } catch (error) {
      // Imprime el error en la consola para diagnosticar
      print("Error al cargar y procesar JSON: $error");
      return [];
    }
  }
}


class _PrivacyPolity{
    final String? title;
    final String? point;
    final String? details;

  _PrivacyPolity({this.point = "", this.details = "", this.title = ""});
  factory _PrivacyPolity.fromJson(json){
    return _PrivacyPolity(title: json["title"], point: json["point"], details: json["details"] ?? "");
  } 
}