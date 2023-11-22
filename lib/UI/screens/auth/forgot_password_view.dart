import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  GlobalKey<FormState> forgotPassKey = GlobalKey<FormState>();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    ColorScheme colors = Theme.of(context).colorScheme;
    String buttonText = _resendTimer != null ? 'Reenviar en ($_secondsRemaining segundos)' : 'Enviar';
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.forgetPassword),
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
                    AppLocalizations.of(context)!.textHelpForgotPassword,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Form(
                    key: forgotPassKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      onChanged: (value) => auth.email = value,
                      validator: (value) => auth.validateEmail(value, context),
                      autocorrect: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(BoxIcons.bx_envelope), labelText: AppLocalizations.of(context)!.email),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  GlobalGeneralButton(
                    isLoading: context.watch<AuthenticationProvider>().isLoading,
                    onPressed: _timerActive
                        ? null
                        : () async {
                            try {
                              auth.isLoading = true;
                              if (auth.isValidForm(forgotPassKey)) {
                                await auth.resetPassword();
                                auth.isLoading = false;
                                _startResendTimer();
                              } else {
                                showToast('Email invalido', context);
                                auth.isLoading = false;
                              }
                            } catch (e) {
                              auth.isLoading = false;
                              logger.e('AUTH ERROR: $e');
                            }
                          },
                    child: Text(
                      buttonText,
                      style: TextStyle(color: colors.surfaceVariant),
                    ),
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
