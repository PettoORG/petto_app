// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/UI/screens/screens.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/utils/utils.dart';
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
  GlobalKey<FormState> logInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Form(
          key: logInKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              const _Logo(),
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
              SizedBox(height: 2.h),
              TextFormField(
                controller: emailController,
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => auth.validateEmail(value, context),
                decoration: InputDecoration(
                    prefixIcon: const Icon(BoxIcons.bx_envelope), labelText: AppLocalizations.of(context)!.email),
              ),
              SizedBox(height: 2.h),
              TextFormField(
                controller: passwordController,
                obscureText: !_passwordVisible,
                style: Theme.of(context).textTheme.bodyMedium,
                validator: (value) => auth.validatePassword(value, context),
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
              ),
              SizedBox(height: 1.5.h),
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
              SizedBox(height: 4.h),
              GlobalGeneralButton(
                isLoading: (context.watch<AuthenticationProvider>().isLoading ||
                    context.watch<PetProvider>().isLoading ||
                    context.watch<ReminderProvider>().isLoading),
                text: AppLocalizations.of(context)!.signIn,
                onPressed: context.watch<AuthenticationProvider>().isLoading
                    ? null
                    : () async {
                        PetProvider petsProvider = context.read<PetProvider>();
                        ReminderProvider reminderProvider = context.read<ReminderProvider>();
                        try {
                          if (!auth.isValidForm(logInKey)) return;
                          await auth.logIn(emailController.text, passwordController.text);
                          await petsProvider.getPets();
                          await reminderProvider.getReminders();
                          context.pushReplacementNamed("home");
                        } catch (e) {
                          if (e.toString().contains('INVALID_LOGIN_CREDENTIALS')) {
                            showToast(AppLocalizations.of(context)!.incorrectCredentials, context);
                          }
                        }
                      },
              ),
              SizedBox(height: 1.h),
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
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.byregisteringyouaccept,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 3.2.w,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: AppLocalizations.of(context)!.termsAndConditions.toLowerCase(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 3.2.w,
                            color: color.primary,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.80,
                                  child: const Center(
                                    child: TermsAndCondicionsView(),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.w),
      child: Image.asset(
        "assets/icon/icon.png",
        fit: BoxFit.cover,
        height: 35.w,
        width: 35.w,
      ),
    );
  }
}
