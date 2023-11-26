import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:petto_app/UI/screens/screens.dart';
import 'package:petto_app/UI/widgets/shared/global_card_section.dart';
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
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20 )),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: const Center(
                      child: TermsAndCondicionsView(),
                    ),
                  ),
                );
              },
            );
          }),
      CardModel(
          title: AppLocalizations.of(context)!.privacyPolicy,
          icon: BoxIcons.bx_shield,
          onTap: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20 )),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: const Center(
                      child: PrivacyPoliciesView(),
                    ),
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
                (index) => GlobalCardOption(
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
