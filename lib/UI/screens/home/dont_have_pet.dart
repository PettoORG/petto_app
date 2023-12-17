import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
                AppLocalizations.of(context)!.dontHavePet,
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
                AppLocalizations.of(context)!.registerYourPet,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            IconButton(
              onPressed: () => context.pushNamed('pet-register'), 
              icon: Icon(BoxIcons.bx_plus_circle, size: 10.h, color: color.primary,)),
          ],
        ),
    );
  }
}