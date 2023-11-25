import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/auth_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/utils/logger_prints.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountScreen extends StatelessWidget {
  static const name = 'account';
  final GlobalKey<FormState> myAccountKey = GlobalKey<FormState>();
  AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    TextTheme textStyle = Theme.of(context).textTheme;
    ColorScheme colors = Theme.of(context).colorScheme;
    bool isEdited() {
      if (auth.displayName != auth.getCurrentUser()?.displayName || auth.email != auth.getCurrentUser()?.email) {
        return true;
      }
      return false;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.myAccount),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: 88.h,
            child: Form(
              key: myAccountKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  Text(
                    AppLocalizations.of(context)!.name,
                    style: textStyle.titleMedium,
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    initialValue: auth.displayName,
                    validator: (value) => auth.validateDisplayName(value, context),
                    onChanged: (value) => auth.displayName = value,
                    autocorrect: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(BoxIcons.bx_user),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    AppLocalizations.of(context)!.email,
                    style: textStyle.titleMedium,
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    initialValue: auth.email,
                    validator: (value) => auth.validateEmail(value, context),
                    onChanged: (value) => auth.email = value,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: true,
                    style: textStyle.bodyMedium,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(BoxIcons.bx_user),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  const _ChangePassword(),
                  SizedBox(height: 3.h),
                  Center(
                      child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: colors.surface,
                                  surfaceTintColor: colors.surface,
                                  shadowColor: colors.shadow,
                                  elevation: 10,
                                  actionsPadding: EdgeInsets.all(1.h),
                                  actionsAlignment: MainAxisAlignment.spaceAround,
                                  contentPadding: EdgeInsets.all(5.w),
                                  actions: [
                                    TextButton(onPressed: () => context.pop(), child: const Text('cancelar')),
                                    TextButton(
                                        onPressed: () {
                                          try {
                                            auth.isLoading = true;
                                            auth.deleteAccount();
                                            auth.isLoading = false;
                                            context.pushReplacementNamed('auth');
                                          } catch (e) {
                                            auth.isLoading = false;
                                            logger.e('AUTH ERROR: $e');
                                          }
                                        },
                                        child: const Text('confirmar')),
                                  ],
                                  content: SizedBox(
                                    height: 19.h,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Deseas eliminar tu cuenta?',
                                          style: textStyle.titleMedium,
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          'Si lo haces, perderas todos tus datos y no podras recuperarla',
                                          style: textStyle.titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.deleteAccount))),
                  const Spacer(),
                  GlobalGeneralButton(
                    isLoading: context.watch<AuthenticationProvider>().isLoading,
                    onPressed: isEdited()
                        ? () async {
                            try {
                              if (!auth.isValidForm(myAccountKey)) return;
                              auth.isLoading = true;
                              if (auth.displayName != auth.getCurrentUser()?.displayName &&
                                  auth.email != auth.getCurrentUser()?.email) {
                                await auth.updateDisplayName();
                                await auth.updateEmail();
                                auth.isLoading = false;
                                return;
                              }
                              if (auth.displayName != auth.getCurrentUser()?.displayName) {
                                await auth.updateDisplayName();
                                auth.isLoading = false;
                                return;
                              }
                              if (auth.email != auth.getCurrentUser()?.email) {
                                await auth.updateEmail();
                                auth.isLoading = false;
                                return;
                              }
                            } catch (e) {
                              auth.isLoading = false;
                              logger.e('AUTH ERROR: $e');
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return AlertDialog(
                              //       backgroundColor: colors.surface,
                              //       surfaceTintColor: colors.surface,
                              //       shadowColor: colors.shadow,
                              //       elevation: 10,
                              //       actionsPadding: EdgeInsets.all(1.h),
                              //       actionsAlignment: MainAxisAlignment.spaceAround,
                              //       contentPadding: EdgeInsets.all(5.w),
                              //       actions: [
                              //         TextButton(onPressed: () => context.pop(), child: const Text('cancelar')),
                              //         TextButton(onPressed: () {}, child: const Text('continuar')),
                              //       ],
                              //       content: SizedBox(
                              //         height: 19.h,
                              //         child: Column(
                              //           children: [
                              //             Text(
                              //               'Comprueba tu identidad',
                              //               style: textStyle.titleMedium,
                              //             ),
                              //             SizedBox(height: 1.h),
                              //             Text(
                              //               'Correo@gmail.com',
                              //               style: textStyle.titleSmall,
                              //             ),
                              //             SizedBox(height: 3.h),
                              //             TextFormField(
                              //               style: Theme.of(context).textTheme.bodyMedium,
                              //               onChanged: (value) => auth.password = value,
                              //               validator: (value) => auth.validatePassword(value, context),
                              //               decoration: InputDecoration(
                              //                 prefixIcon: const Icon(BoxIcons.bx_lock),
                              //                 labelText: AppLocalizations.of(context)!.password,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
                            }
                          }
                        : null,
                    child: Text(AppLocalizations.of(context)!.save),
                  ),
                ],
              ),
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
      onTap: () => context.pushNamed('change-password'),
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
