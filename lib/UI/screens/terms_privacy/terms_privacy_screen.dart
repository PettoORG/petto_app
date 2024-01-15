import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
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
          title: 'termsAndConditions'.tr(),
          icon: BoxIcons.bx_book,
          onTap: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
          title: 'privacyPolicy'.tr(),
          icon: BoxIcons.bx_shield,
          onTap: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
        title: Text('securityPolicies'.tr()),
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
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: GlobalCardOption(
                    options[index],
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
