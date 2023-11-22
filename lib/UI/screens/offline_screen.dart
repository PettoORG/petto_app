import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petto_app/UI/providers/connection_status_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class OfflineScreen extends StatelessWidget {
  static const name = 'offline';
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30.h,
              width: 30.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.h), color: color.primary.withOpacity(0.2)),
              padding: EdgeInsets.all(4.w),
              child: SvgPicture.asset("assets/signal_sleep.svg"),
            ),
            SizedBox(
              height: 7.w,
            ),
            Text(
              AppLocalizations.of(context)!.noConection,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 18.5.sp,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Text(
                AppLocalizations.of(context)!.checkConection,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            ElevatedButton(
              onPressed: () async {
                final bool isOnline = await context.read<ConnectionProvider>().checkInternetConnection();
                if (!context.mounted) {
                  return;
                }
                if (isOnline) {
                  context.pop();
                }
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(75.w, 6.5.h)),
              ),
              child: Text(
                AppLocalizations.of(context)!.tryAgain,
                style: TextStyle(color: color.surfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
