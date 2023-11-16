import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petto_app/UI/providers/language_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PrivacyPoliciesView extends StatelessWidget {
  static const name = 'privacy';

  const PrivacyPoliciesView({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<_PrivacyPolity>> getPrivacyInfo() async {
      String language = context.read<LanguageProvider>().language;
      String path = 'data/politics_$language.json';
      String jsonString = await rootBundle.loadString(path);
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      List<_PrivacyPolity> privacyList = jsonMap.entries.map((entry) => _PrivacyPolity.fromJson(entry.value)).toList();
      return privacyList;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: FutureBuilder(
                future: getPrivacyInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    //TODO IMPLEMENTAR VISTA DEL ERROR
                    logger.e(snapshot.error);
                    return Container();
                  }
                  if (snapshot.hasData) {
                    return Column(
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          _PrivacyPolity privacyPoint = snapshot.data![index];
                          return Column(
                            children: [
                              //TITLE
                              const Text('Politicas de privacidad'),
                              //DATA
                              _PointSection(privacyPoint: privacyPoint),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    //LOADING
                    return const Center(
                      child: PettoLoading(),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PointSection extends StatelessWidget {
  final _PrivacyPolity privacyPoint;
  const _PointSection({
    required this.privacyPoint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(privacyPoint.title),
        Text(privacyPoint.point),
        Text(privacyPoint.details),
      ],
    );
  }
}

class _PrivacyPolity {
  final String title;
  final String point;
  final String details;

  _PrivacyPolity({required this.point, required this.details, required this.title});
  factory _PrivacyPolity.fromJson(json) {
    return _PrivacyPolity(
      title: json["title"] ?? "",
      point: json["point"] ?? "",
      details: json["details"] ?? "",
    );
  }
}
