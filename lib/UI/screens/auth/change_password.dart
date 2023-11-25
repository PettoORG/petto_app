import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/auth_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const name = 'change-password';

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    TextEditingController newPassWord = TextEditingController();
    TextEditingController oldPassWord = TextEditingController();
    TextEditingController confirmNewPassWord = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar contraseñá'),
        centerTitle: true,
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: oldPassWord,
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
                controller: newPassWord,
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
                controller: confirmNewPassWord,
                style: Theme.of(context).textTheme.bodyMedium,
                validator: (value) => auth.confirmPassword(value, newPassWord.text, context),
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
                onPressed: () {
                  try {
                    if (!auth.isValidForm(formKey)) return;
                    auth.isLoading = true;
                    auth.updatePassWord(newPassWord.text);
                    auth.isLoading = true;
                    showToast('Cambio de contraseña exitoso', context);
                  } catch (e) {
                    logger.e('AUTH ERROR: $e');
                    //TODO: MANEJAR ERRORES
                  }
                },
                child: const Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
