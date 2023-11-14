import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/connection_status_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  static const name = 'auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late PageController controller;
  late int currentPage = 0;

  @override
  void initState() {
    controller = PageController(initialPage: 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            _ForgotPassView(onPressNext: () {
              controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInQuint);
            }),
            _LoginView(
              onTap: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInQuint,
                );
              },
              onTapTwo: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInQuint,
                );
              },
            ),
            _RegisterView(press: () {
              controller.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInQuint,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _LoginView extends StatefulWidget {
  final Function()? onTap;
  final Function()? onTapTwo;
  const _LoginView({this.onTap, this.onTapTwo});

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
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
            ElevatedButton(
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
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(75.w, 6.5.h)),
              ),
              child: Text(
                AppLocalizations.of(context)!.signIn,
                style: TextStyle(color: color.surfaceVariant),
              ),
            ),
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
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _RegisterView extends StatefulWidget {
  final Function()? press;
  const _RegisterView({this.press});

  @override
  State<_RegisterView> createState() => __RegisterViewState();
}

class __RegisterViewState extends State<_RegisterView> {
  bool _passwordVisible = false;

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
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.8.h),
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.register,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18.5.sp,
                          fontWeight: FontWeight.w900,
                        )),
                subtitle: Text(
                  AppLocalizations.of(context)!.enterYourCredentials,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_user), labelText: AppLocalizations.of(context)!.name),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_envelope), labelText: AppLocalizations.of(context)!.email),
            ),
            SizedBox(
              height: 1.5.h,
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
            ),
            SizedBox(
              height: 4.h,
            ),
            ElevatedButton(
              onPressed: () async {
                final bool isOnline = await context.read<ConnectionStatusProvider>().checkInternetConnection();
                if (!context.mounted) {
                  return;
                }
                if (isOnline) {
                  context.pushReplacementNamed("home");
                } else {
                  context.pushNamed('offline');
                }
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(75.w, 6.5.h)),
              ),
              child: Text(
                AppLocalizations.of(context)!.register,
                style: TextStyle(color: color.surfaceVariant),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.haveAnAccount),
                SizedBox(width: 1.w),
                GestureDetector(
                    onTap: widget.press,
                    child: Text(
                      AppLocalizations.of(context)!.signIn,
                      style: TextStyle(color: color.primary),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ForgotPassView extends StatefulWidget {
  final Function()? onPressNext;

  const _ForgotPassView({
    this.onPressNext,
  });

  @override
  State<_ForgotPassView> createState() => _ForgotPassViewState();
}

class _ForgotPassViewState extends State<_ForgotPassView> {
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: widget.onPressNext, alignment: Alignment.center, icon: const Icon(Icons.arrow_back_ios)),
                Flexible(
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.forgetPassword,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Container(
              height: 30.h,
              width: 30.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.h), color: color.primary.withOpacity(0.2)),
              padding: EdgeInsets.all(4.w),
              child: SvgPicture.asset("assets/forgot_password.svg"),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              AppLocalizations.of(context)!.textHelpForgotPassword,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 4.h,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_envelope), labelText: AppLocalizations.of(context)!.email),
            ),
            SizedBox(
              height: 2.h,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                AppLocalizations.of(context)!.tryAgain,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: color.primary, decoration: TextDecoration.underline, decorationColor: color.primary),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(75.w, 6.5.h)),
              ),
              child: Text(
                AppLocalizations.of(context)!.send,
                style: TextStyle(color: color.surfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
