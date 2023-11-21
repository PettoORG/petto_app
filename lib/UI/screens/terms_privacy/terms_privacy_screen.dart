import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:petto_app/UI/screens/screens.dart';
import 'package:petto_app/UI/widgets/shared/card_option.dart';
import 'package:sizer/sizer.dart';

class TCScreen extends StatelessWidget {
  static const name = 'terms-privacy';

  const TCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CardModel> options = [
      CardModel(
          title: AppLocalizations.of(context)!.termsAndConditions,
          icon: BoxIcons.bx_book,
          onTap: () {
            showModalBottomSheet<void>(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.80,
                  child: const Center(
                    child: TermsAndCondicionsView(),
                  ),
                );
              },
            );
          }),
      CardModel(
          title: AppLocalizations.of(context)!.privacyPolicies,
          icon: BoxIcons.bx_shield,
          onTap: () {
            showModalBottomSheet<void>(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(100))),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.80,
                  child: const Center(
                    child: PrivacyPoliciesView(),
                  ),
                );
              },
            );
          }),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          AppLocalizations.of(context)!.securityPolicies,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            Column(children: [
              ...List.generate(
                options.length,
                (index) => CardOption(
                  options[index],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
