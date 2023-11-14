import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileView extends StatelessWidget {
  static const name = 'user-profile';

  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<_CardModel> options = [
      _CardModel(
          title: AppLocalizations.of(context)!.myAccount,
          icon: BoxIcons.bx_face,
          onTap: () {
            context.pushNamed('account');
          }),
      _CardModel(title: AppLocalizations.of(context)!.notifications, icon: BoxIcons.bx_bell, onTap: () {}),
      _CardModel(title: AppLocalizations.of(context)!.support, icon: BoxIcons.bx_support, onTap: () {}),
      _CardModel(title: AppLocalizations.of(context)!.securityPolicies, icon: BoxIcons.bx_shield_quarter, onTap: () {}),
      _CardModel(title: AppLocalizations.of(context)!.logOut, icon: BoxIcons.bx_log_out_circle, onTap: () {}),
    ];
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: double.infinity,
        height: 100.h,
        child: Stack(
          children: [
            const _DecorationBox(),
            Positioned(
              top: 7.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const _UserResume(),
                  SizedBox(height: 3.h),
                  ...List.generate(
                    options.length,
                    (index) => Column(
                      children: [
                        _CardOption(options[index]),
                        SizedBox(height: 1.5.h),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CardOption extends StatelessWidget {
  final _CardModel option;
  const _CardOption(this.option);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: InkWell(
        onTap: option.onTap,
        borderRadius: BorderRadius.circular(5.w),
        child: Ink(
          padding: EdgeInsets.all(4.w),
          width: double.infinity,
          height: 9.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(5.w),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Theme.of(context).colorScheme.shadow,
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                  height: 5.5.h,
                  width: 5.5.h,
                  decoration: BoxDecoration(color: lightPrimaryContainer, borderRadius: BorderRadius.circular(1.h)),
                  child: Icon(option.icon, color: lightPrimary)),
              SizedBox(
                width: 3.w,
              ),
              Text(
                option.title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 7.w,
                color: lightShadowColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _UserResume extends StatelessWidget {
  const _UserResume();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      margin: EdgeInsets.symmetric(horizontal: 7.w),
      height: 35.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.all(Radius.circular(5.w)),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Theme.of(context).colorScheme.shadow,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_world)),
              Container(
                height: 12.h,
                width: 12.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.w),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Theme.of(context).colorScheme.shadow,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_brightness)),
            ],
          ),
          SizedBox(height: .5.h),
          const Text('Jorge Arrieta'),
          SizedBox(height: .5.h),
          const Text('jorge.arrieta@gmail.com'),
          SizedBox(height: 2.h),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => const _PetAvatar(),
                    itemCount: 5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PetAvatar extends StatelessWidget {
  const _PetAvatar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(color: lightBackground, borderRadius: BorderRadius.circular(10.w)),
      ),
    );
  }
}

class _DecorationBox extends StatelessWidget {
  const _DecorationBox();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        height: 35.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.h), bottomRight: Radius.circular(5.h))),
      ),
    );
  }
}

class _CardModel {
  final String title;
  final IconData icon;
  final Function()? onTap;

  _CardModel({required this.title, required this.icon, required this.onTap});
}
