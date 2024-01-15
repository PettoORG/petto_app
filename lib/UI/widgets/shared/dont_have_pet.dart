import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class DontHavePet extends StatelessWidget {
  const DontHavePet({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            'assets/animations/petto-sleep.json',
            width: 90.w,
          ),
          SizedBox(
            height: 7.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Text(
              'dontHavePet'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 18.5.sp,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: Text(
              'registerYourPet'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          IconButton(
              onPressed: () => context.pushNamed('pet-register'),
              icon: Icon(
                BoxIcons.bx_plus_circle,
                size: 10.h,
                color: color.primary,
              )),
        ],
      ),
    );
  }
}
