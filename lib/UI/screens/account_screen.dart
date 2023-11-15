import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountScreen extends StatelessWidget {
  static const name = 'account';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme texttStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.myAccount),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: 88.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Text(
                  AppLocalizations.of(context)!.name,
                  style: texttStyle.titleMedium,
                ),
                SizedBox(height: 1.h),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(BoxIcons.bx_user),
                    label: Text(AppLocalizations.of(context)!.name),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  AppLocalizations.of(context)!.email,
                  style: texttStyle.titleMedium,
                ),
                SizedBox(height: 1.h),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(BoxIcons.bx_user),
                    label: Text(AppLocalizations.of(context)!.email),
                  ),
                ),
                SizedBox(height: 3.h),
                const _ChangePassword(),
                SizedBox(height: 3.h),
                Center(child: TextButton(onPressed: () {}, child: Text(AppLocalizations.of(context)!.deleteAccount))),
                const Spacer(),
                SharedButton(child: Text(AppLocalizations.of(context)!.save)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChangePassword extends StatelessWidget {
  const _ChangePassword();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(5.w),
      child: Ink(
        padding: EdgeInsets.all(3.w),
        width: double.infinity,
        decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(5.w),
            boxShadow: [BoxShadow(blurRadius: 3, color: colors.shadow, offset: const Offset(0, 0))]),
        child: Row(
          children: [
            Text(AppLocalizations.of(context)!.changePassword),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
