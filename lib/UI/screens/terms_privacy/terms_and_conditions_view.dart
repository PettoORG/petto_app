import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsAndCondicionsView extends StatelessWidget {
    static const name = 'terms';

  const TermsAndCondicionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.termsAndCondition, 
                style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.termsAndCondition,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: 2.h,),
              const _TermsAndConditionsBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleAndSubTitle extends StatelessWidget {
  final String? title;
  final String? one;
  final String? two;
  final String? three;

  
  const _TitleAndSubTitle({this.title,  this.one,  this.two,  this.three});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall,),
        SizedBox(height: 2.h,),
        Padding(
          padding: EdgeInsets.only(left: 3.w),
          child: Column(
            children: [
              Text(one ?? ""),
        SizedBox(height: 2.h,),
        two != null ? Column(
                  children: [
                    Text(two ?? ""),
                    SizedBox(height: 2.h,),
                  ],
        ) : Container(),
        three != null ? Column(
                  children: [
                    Text(three ?? ""),
                    SizedBox(height: 2.h,),
                  ],
        ) : Container(),
            ],
          ),),
        SizedBox(height: 2.h,),
      ],
    );
  }
}

class _TermsAndConditionsBody extends StatelessWidget {
  const _TermsAndConditionsBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionAcceptation,
          one: AppLocalizations.of(context)!.termsAndConditionAcceptationOne,
        ),
         _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionRegister,
          one: AppLocalizations.of(context)!.termsAndConditionRegisterOne,
          two: AppLocalizations.of(context)!.termsAndConditionRegisterTwo,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionProperty,
          one: AppLocalizations.of(context)!.termsAndConditionPropertyOne,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionPrivacy,
          one: AppLocalizations.of(context)!.termsAndConditionPrivacyOne,
          two: AppLocalizations.of(context)!.termsAndConditionPrivacyTwo,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionResponsibility,
          one: AppLocalizations.of(context)!.termsAndConditionResponsibilityOne,
          two: AppLocalizations.of(context)!.termsAndConditionResponsibilityTwo,
          three: AppLocalizations.of(context)!.termsAndConditionResponsibilityThree,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionUser,
          one: AppLocalizations.of(context)!.termsAndConditionUserOne,
          two: AppLocalizations.of(context)!.termsAndConditionUserTwo,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionNotifications,
          one: AppLocalizations.of(context)!.termsAndConditionNotificationsOne,
          two: AppLocalizations.of(context)!.termsAndConditionNotificationsTwo,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionModifications,
          one: AppLocalizations.of(context)!.termsAndConditionModificationsOne,
          two: AppLocalizations.of(context)!.termsAndConditionModificationsTwo,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionCancelation,
          one: AppLocalizations.of(context)!.termsAndConditionCancelationOne,
          two: AppLocalizations.of(context)!.termsAndConditionCancelationTwo,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionDispute,
          one: AppLocalizations.of(context)!.termsAndConditionDisputeOne,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionLimitation,
          one: AppLocalizations.of(context)!.termsAndConditionLimitationOne,
        ), _TitleAndSubTitle(
          title: AppLocalizations.of(context)!.termsAndConditionInformation,
          one: AppLocalizations.of(context)!.termsAndConditionInformationOne,
        ),
      ],
    );
  }
}