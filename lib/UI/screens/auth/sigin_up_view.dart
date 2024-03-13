// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    nameController.dispose();
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
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              const _Logo(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.8.h),
                child: ListTile(
                  title: Text('register'.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18.5.sp,
                            fontWeight: FontWeight.w900,
                          )),
                  subtitle: Text(
                    'enterYourCredentials'.tr(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextFormField(
                controller: nameController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_user),
                  labelText: 'name'.tr(),
                ),
                validator: (value) => FormValidators.name(value),
              ),
              SizedBox(height: 1.5.h),
              TextFormField(
                controller: emailController,
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_envelope),
                  labelText: 'email'.tr(),
                ),
                validator: (value) => FormValidators.email(value),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              TextFormField(
                controller: passwordController,
                style: Theme.of(context).textTheme.bodyMedium,
                obscureText: !_passwordVisible,
                validator: (value) => FormValidators.password(value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(BoxIcons.bx_lock),
                  labelText: 'password'.tr(),
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
              PettoGeneralButton(
                isLoading: context.watch<AuthenticationProvider>().isLoading,
                text: 'register'.tr(),
                onPressed: context.watch<AuthenticationProvider>().isLoading
                    ? null
                    : () async {
                        UserProvider userProvider = context.read<UserProvider>();
                        try {
                          final bool isOnline = await context.read<ConnectionProvider>().checkInternetConnection();
                          if (!isOnline) {
                            context.pushNamed('offline');
                            return;
                          }
                          if (!FormValidators.isValidForm(formKey)) return;
                          await auth.signInUp(
                            emailController.text,
                            passwordController.text,
                            nameController.text,
                          );

                          await userProvider.getUser();
                          context.pushReplacementNamed("pet-register");
                        } catch (e) {
                          if (e.toString().contains('email-already-in-use')) {
                            showToast('emailAlreadyRegistered'.tr(), context);
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
                  Text('haveAnAccount'.tr()),
                  SizedBox(width: 1.w),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'signIn'.tr(),
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
