import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:petto_app/UI/providers/connection_status_provider.dart';
import 'package:petto_app/UI/widgets/shared/global_general_button.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class OfflineScreen extends StatelessWidget {
  static const name = 'offline';
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
            Text(
              'noConection'.tr(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 18.5.sp,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Text(
                'checkConection'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            GlobalGeneralButton(
                text: 'tryAgain'.tr(),
                onPressed: () async {
                  final bool isOnline = await context.read<ConnectionProvider>().checkInternetConnection();
                  if (!context.mounted) {
                    return;
                  }
                  if (isOnline) {
                    context.pop();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
