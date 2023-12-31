// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
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
  GlobalKey<FormState> sigInUpKey = GlobalKey<FormState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    displayNameController.clear();
    emailController.clear();
    passwordController.clear();
    displayNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: sigInUpKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
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
                controller: displayNameController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_user),
                  labelText: AppLocalizations.of(context)!.name,
                ),
                validator: (value) => auth.validateDisplayName(value, context),
              ),
              SizedBox(height: 1.5.h),
              TextFormField(
                controller: emailController,
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_envelope),
                  labelText: AppLocalizations.of(context)!.email,
                ),
                validator: (value) => auth.validateEmail(value, context),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                controller: passwordController,
                style: Theme.of(context).textTheme.bodyMedium,
                obscureText: !_passwordVisible,
                validator: (value) => auth.validatePassword(value, context),
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
              ),
              SizedBox(
                height: 4.h,
              ),
              GlobalGeneralButton(
                isLoading: context.watch<AuthenticationProvider>().isLoading,
                text: AppLocalizations.of(context)!.register,
                onPressed: context.watch<AuthenticationProvider>().isLoading
                    ? null
                    : () async {
                        try {
                          final bool isOnline = await context.read<ConnectionProvider>().checkInternetConnection();
                          if (!isOnline) {
                            context.pushNamed('offline');
                            return;
                          }
                          if (!auth.isValidForm(sigInUpKey)) return;
                          await auth.signInUp(
                            emailController.text,
                            passwordController.text,
                            displayNameController.text,
                          );
                          context.pushReplacementNamed("pet-register");
                        } catch (e) {
                          if (e.toString().contains('email-already-in-use')) {
                            showToast(AppLocalizations.of(context)!.emailAlreadyRegistered, context);
                          }
                        }
                      },
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
