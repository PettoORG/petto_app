import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petto_app/UI/providers/language_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    const _NonData();
                    logger.e(snapshot.error);
                    return Container();
                  }
                  if (snapshot.hasData) {
                    return Column(children: [
                      Text(
                        AppLocalizations.of(context)!.securityPolicies,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ...List.generate(
                        snapshot.data!.length,
                        (index) {
                          _PrivacyPolity privacyPoint = snapshot.data![index];
                          return _PointSection(privacyPoint: privacyPoint);
                        },
                      ),
                    ]);
                  } else {
                    //LOADING
                    return Center(
                      child: PettoLoading(
                        color: Theme.of(context).colorScheme.primary,
                        size: 10.w,
                      ),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          privacyPoint.title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 3.w),
          child: Column(
            children: [
              Text(privacyPoint.point, textAlign: TextAlign.justify),
              SizedBox(
                height: 2.h,
              ),
              privacyPoint.details != ""
                  ? Column(
                      children: [
                        Text(
                          privacyPoint.details,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
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

class _NonData extends StatelessWidget {
  const _NonData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset("assets/not_data.svg"),
            SizedBox(
              height: 5.h,
            ),
            const Text(
                "Lo sentimos ocurrio un problema en la carga de la data, no te preocupes estamos corrigiendo para mejorar.")
          ],
        ),
      ),
    );
  }
}
