import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/auth_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const name = 'change-password';

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar contraseñá'),
        centerTitle: true,
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              validator: (value) => auth.validatePassword(value, context),
              decoration: InputDecoration(
                prefixIcon: const Icon(BoxIcons.bx_lock),
                labelText: 'Actual contraseña',
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(BoxIcons.bx_hide),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              validator: (value) => auth.validatePassword(value, context),
              decoration: InputDecoration(
                prefixIcon: const Icon(BoxIcons.bx_lock),
                labelText: 'Nueva contraseña',
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(BoxIcons.bx_hide),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              validator: (value) => auth.validatePassword(value, context),
              decoration: InputDecoration(
                prefixIcon: const Icon(BoxIcons.bx_lock),
                labelText: 'Confirma nueva contraseña',
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(BoxIcons.bx_hide),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            GlobalGeneralButton(
              isLoading: context.watch<AuthenticationProvider>().isLoading,
              onPressed: () {},
              child: const Text('Guardar'),
            )
          ],
        ),
      ),
    );
  }
}
