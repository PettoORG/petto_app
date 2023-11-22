import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/utils/logger_prints.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:petto_app/UI/providers/language_provider.dart';

class TermsAndCondicionsView extends StatelessWidget {
  static const name = 'terms';

  const TermsAndCondicionsView({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<_TermsAndConditions>> getPrivacyInfo() async {
      String language = context.read<LanguageProvider>().language;
      String path = 'data/terms_$language.json';
      String jsonString = await rootBundle.loadString(path);
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      List<_TermsAndConditions> termsList =
          jsonMap.entries.map((entry) => _TermsAndConditions.fromJson(entry.value)).toList();
      return termsList;
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
                        AppLocalizations.of(context)!.termsAndConditions,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ...List.generate(
                        snapshot.data!.length,
                        (index) {
                          _TermsAndConditions termsPoint = snapshot.data![index];
                          return _TitleAndSubTitle(termsPoint: termsPoint);
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

class _TitleAndSubTitle extends StatelessWidget {
  final _TermsAndConditions termsPoint;
  const _TitleAndSubTitle({
    required this.termsPoint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          termsPoint.title,
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
              Text(termsPoint.point),
              SizedBox(
                height: 2.h,
              ),
              termsPoint.details != ""
                  ? Column(
                      children: [
                        Text(termsPoint.details),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    )
                  : Container(),
              termsPoint.subpoint != ""
                  ? Column(
                      children: [
                        Text(termsPoint.subpoint),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}

class _TermsAndConditions {
  final String title;
  final String point;
  final String details;
  final String subpoint;

  _TermsAndConditions({required this.point, required this.details, required this.title, required this.subpoint});
  factory _TermsAndConditions.fromJson(json) {
    return _TermsAndConditions(
      title: json["title"] ?? "",
      point: json["point"] ?? "",
      details: json["details"] ?? "",
      subpoint: json["subpoint"] ?? "",
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
