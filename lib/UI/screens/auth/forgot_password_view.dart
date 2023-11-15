import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordView extends StatefulWidget {
  final Function()? onTap;

  const ForgotPasswordView({
    super.key,
    this.onTap,
  });

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
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
                    onPressed: widget.onTap, alignment: Alignment.center, icon: const Icon(Icons.arrow_back_ios)),
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
            SharedButton(
              onPressed: () {},
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
