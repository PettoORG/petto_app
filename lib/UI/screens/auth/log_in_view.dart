import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  final Function()? onTap;
  final Function()? onTapTwo;
  const LoginView({super.key, this.onTap, this.onTapTwo});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(8.sp),
                margin: EdgeInsets.only(bottom: 7.h, top: 12.h),
                height: 11.h,
                width: 11.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  color: color.primary,
                ),
                child: SvgPicture.asset(
                  "assets/petto.svg",
                  height: 10.h,
                  width: 10.w,
                )),
            ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.8.h),
                child: Text(AppLocalizations.of(context)!.welcomeBack,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18.5.sp,
                          fontWeight: FontWeight.w900,
                        )),
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.enterYourEmail,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_envelope), labelText: AppLocalizations.of(context)!.email),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(BoxIcons.bx_lock),
                labelText: AppLocalizations.of(context)!.password,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  child: !_passwordVisible ? const Icon(BoxIcons.bx_hide) : const Icon(BoxIcons.bx_show),
                ),
              ),
              obscureText: !_passwordVisible,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              children: [
                Flexible(child: Container()),
                GestureDetector(
                  onTap: widget.onTapTwo,
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 3.2.w,
                          color: color.primary,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            SharedButton(
                onPressed: () async {
                  final bool isOnline = await context.read<ConnectionStatusProvider>().checkInternetConnection();
                  if (!context.mounted) {
                    return;
                  }
                  if (isOnline) {
                    context.pushReplacementNamed('home');
                  } else {
                    context.pushNamed('offline');
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.signIn,
                  style: TextStyle(color: color.surfaceVariant),
                )),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.dontHaveAccount),
                SizedBox(width: 1.w),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    AppLocalizations.of(context)!.register,
                    style: TextStyle(color: color.primary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
