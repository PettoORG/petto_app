import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordView extends StatefulWidget {
  final Function()? onPressed;
  const ForgotPasswordView({
    super.key,
    this.onPressed,
  });

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  Timer? _resendTimer;
  int _secondsRemaining = 30;
  bool _timerActive = false;

  void _startResendTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _resendTimer?.cancel();
          _resendTimer = null;
          _timerActive = false;
          _secondsRemaining = 30;
        }
      });
    });

    _timerActive = true;
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    emailController.clear();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    ColorScheme colors = Theme.of(context).colorScheme;
    String buttonText =
        _resendTimer != null ? 'resendInXSeconds'.tr(args: [_secondsRemaining.toString()]) : 'send'.tr();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Text('forgetPassword'.tr()),
          leading: IconButton(onPressed: widget.onPressed, icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 30.h,
                    width: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h), color: colors.primary.withOpacity(0.2)),
                    padding: EdgeInsets.all(4.w),
                    child: SvgPicture.asset("assets/forgot_password.svg"),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'textHelpForgotPassword'.tr(),
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      validator: (value) => FormValidators.email(value),
                      autocorrect: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(prefixIcon: const Icon(BoxIcons.bx_envelope), labelText: 'email'.tr()),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  GlobalGeneralButton(
                    isLoading: context.watch<AuthenticationProvider>().isLoading,
                    text: buttonText,
                    onPressed: _timerActive
                        ? null
                        : () async {
                            try {
                              if (!FormValidators.isValidForm(formKey)) return;
                              await auth.sendPasswordResetEmail(emailController.text);
                              _startResendTimer();
                            } catch (e) {
                              logger.e('AUTH ERROR: $e');
                            }
                          },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
