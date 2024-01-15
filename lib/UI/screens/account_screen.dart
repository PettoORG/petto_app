import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/utils/form_validatros.dart';
import 'package:petto_app/utils/logger_prints.dart';
import 'package:petto_app/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AccountScreen extends StatefulWidget {
  static const name = 'account';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<FormState> myAccountKey = GlobalKey<FormState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    displayNameController.text = auth.getCurrentUser()!.displayName!;
    emailController.text = auth.getCurrentUser()!.email!;
    super.initState();
  }

  @override
  void dispose() {
    displayNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool isEdited() {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    String displayName = auth.getCurrentUser()?.displayName ?? '';
    String email = auth.getCurrentUser()?.email ?? '';
    return displayNameController.text != displayName || emailController.text != email;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    TextTheme textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('myAccount'.tr()),
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
                    'name'.tr(),
                    style: textStyle.titleMedium,
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    controller: displayNameController,
                    validator: (value) => FormValidators.validateName(value, context),
                    autocorrect: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(BoxIcons.bx_user),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'email'.tr(),
                    style: textStyle.titleMedium,
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    controller: emailController,
                    validator: (value) => FormValidators.validateEmail(value, context),
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
                            return const _DeletAccountDialog();
                          },
                        );
                      },
                      child: Text('deleteAccount'.tr()),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  GlobalGeneralButton(
                    isLoading: context.watch<AuthenticationProvider>().isLoading,
                    text: 'save'.tr(),
                    onPressed: isEdited()
                        ? () async {
                            try {
                              if (!FormValidators.isValidForm(myAccountKey)) return;
                              if (displayNameController.text != userProvider.getAuthUser()!.displayName &&
                                  emailController.text != userProvider.getAuthUser()!.email) {
                                await userProvider.updateDisplayName(displayNameController.text);
                                await userProvider.updateEmail(emailController.text);
                                return;
                              }
                              if (displayNameController.text != userProvider.getAuthUser()!.displayName) {
                                await userProvider.updateDisplayName(displayNameController.text);
                                return;
                              }
                              if (emailController.text != userProvider.getAuthUser()!.email) {
                                await userProvider.updateEmail(emailController.text);
                                return;
                              }
                            } catch (e) {
                              if (e.toString().contains('email-already-in-use')) {
                                showToast('emailAlreadyRegistered'.tr(), context);
                              }
                              if (e.toString().contains('requires-recent-login')) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const _ReAuthDialog();
                                  },
                                );
                              }
                            }
                          }
                        : null,
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

class _ReAuthDialog extends StatelessWidget {
  const _ReAuthDialog();

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    TextTheme textStyle = Theme.of(context).textTheme;
    ColorScheme colors = Theme.of(context).colorScheme;
    TextEditingController passwordController = TextEditingController();
    return AlertDialog(
      backgroundColor: colors.surface,
      surfaceTintColor: colors.surface,
      shadowColor: colors.shadow,
      elevation: 10,
      actionsPadding: EdgeInsets.all(1.h),
      actionsAlignment: MainAxisAlignment.spaceAround,
      contentPadding: EdgeInsets.all(5.w),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text('cancel'.tr())),
        TextButton(
            onPressed: () async {
              try {
                await auth.reAuth(passwordController.text);
                // ignore: use_build_context_synchronously
                context.pop();
              } catch (e) {
                logger.e('AUTH ERROR: $e');
              }
            },
            child: Text('next'.tr())),
      ],
      content: SizedBox(
        height: 19.h,
        child: Column(
          children: [
            Text(
              'checkYourIdentity'.tr(),
              style: textStyle.titleMedium,
            ),
            SizedBox(height: 1.h),
            Text(
              auth.getCurrentUser()!.email!,
              style: textStyle.titleSmall,
            ),
            SizedBox(height: 3.h),
            TextFormField(
              controller: passwordController,
              style: Theme.of(context).textTheme.bodyMedium,
              validator: (value) => auth.validatePassword(value, context),
              decoration: InputDecoration(
                prefixIcon: const Icon(BoxIcons.bx_lock),
                labelText: 'password'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeletAccountDialog extends StatelessWidget {
  const _DeletAccountDialog();

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider auth = context.read<AuthenticationProvider>();
    TextTheme textStyle = Theme.of(context).textTheme;
    ColorScheme colors = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: colors.surface,
      surfaceTintColor: colors.surface,
      shadowColor: colors.shadow,
      elevation: 10,
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsPadding: EdgeInsets.only(bottom: 1.h),
      contentPadding: EdgeInsets.fromLTRB(6.w, 6.w, 6.w, 0.0),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text('cancel'.tr())),
        TextButton(
            onPressed: () {
              try {
                auth.isLoading = true;
                auth.deleteAccount();
                auth.isLoading = false;
                context.pushReplacementNamed('auth');
              } catch (e) {
                auth.isLoading = false;
                if (e.toString().contains('requires-recent-login')) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const _ReAuthDialog();
                    },
                  );
                }
              }
            },
            child: Text('confirm'.tr())),
      ],
      content: SizedBox(
        height: 19.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'confirmDeleteAccount'.tr(),
              style: textStyle.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              'warningDataLoss'.tr(),
              style: textStyle.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
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
            Text('changePassword'.tr()),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
