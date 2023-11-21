import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordView extends StatelessWidget {
  final Function()? onPressed;

  const ForgotPasswordView({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.forgetPassword),
          leading: IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_back_ios_new_rounded)),
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
                  GlobalGeneralButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.send,
                      style: TextStyle(color: color.surfaceVariant),
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
