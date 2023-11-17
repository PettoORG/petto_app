import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/services/services.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterView extends StatefulWidget {
  final Function()? onTap;
  const RegisterView({super.key, this.onTap});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: context.read<AuthenticationProvider>().sigInUp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _Logo(),
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
              SizedBox(height: 2.h),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_user),
                  labelText: AppLocalizations.of(context)!.name,
                ),
              ),
              SizedBox(height: 1.5.h),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_envelope),
                  labelText: AppLocalizations.of(context)!.email,
                ),
                onChanged: (value) => context.read<AuthenticationProvider>().email = value,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_lock),
                  labelText: AppLocalizations.of(context)!.password,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() => _passwordVisible = !_passwordVisible);
                    },
                    child: !_passwordVisible ? const Icon(BoxIcons.bx_hide) : const Icon(BoxIcons.bx_show),
                  ),
                ),
                onChanged: (value) => context.read<AuthenticationProvider>().password = value,
              ),
              SizedBox(
                height: 4.h,
              ),
              SharedButton(
                onPressed: () async {
                  final bool isOnline = await context.read<ConnectionStatusProvider>().checkInternetConnection();
                  if (!context.mounted) return;
                  if (isOnline) {
                    final email = context.read<AuthenticationProvider>().email;
                    final password = context.read<AuthenticationProvider>().password;
                    try {
                      await Auth().siginUpWithEmailAndPassword(email: email, password: password);
                      logger.d('AUTH USER UID: ${Auth().authInfo.user!.uid}');
                      // ignore: use_build_context_synchronously
                      context.pushReplacementNamed("home");
                    } on FirebaseAuthException catch (e) {
                      logger.e('AUTH ERROR: $e');
                    }
                  } else {
                    context.pushNamed('offline');
                  }
                },
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
                      onTap: widget.onTap,
                      child: Text(
                        AppLocalizations.of(context)!.signIn,
                        style: TextStyle(color: color.primary),
                      ))
                ],
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
    ColorScheme color = Theme.of(context).colorScheme;
    return Container(
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
    );
  }
}
