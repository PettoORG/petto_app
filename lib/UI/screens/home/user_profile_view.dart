import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class UserProfileView extends StatelessWidget {
  static const name = 'user-profile';

  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authProvider = context.read<AuthenticationProvider>();
    List<_CardModel> options = [
      _CardModel(
          title: 'myAccount'.tr(context: context),
          icon: BoxIcons.bx_face,
          onTap: () {
            context.pushNamed('account');
          }),
      _CardModel(
          title: 'notifications'.tr(context: context),
          icon: BoxIcons.bx_bell,
          onTap: () {
            context.pushNamed('notifications-settings');
          }),
      _CardModel(
          title: 'securityPolicies'.tr(context: context),
          icon: BoxIcons.bx_shield_quarter,
          onTap: () {
            context.pushNamed('terms-privacy');
          }),
      _CardModel(
        title: 'logOut'.tr(context: context),
        icon: BoxIcons.bx_log_out_circle,
        onTap: () async {
          try {
            await authProvider.signOut();
            if (!context.mounted) return;
            context.pushReplacementNamed('auth');
          } catch (e) {
            showToast('error'.tr(), context);
          }
        },
      ),
    ];
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: double.infinity,
        height: 90.h,
        child: Stack(
          children: [
            const _DecorationBox(),
            Positioned(
              top: 7.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const _UserResume(),
                  SizedBox(height: 4.h),
                  ...List.generate(
                    options.length,
                    (index) => Column(
                      children: [
                        _CardOption(options[index]),
                        SizedBox(height: 1.5.h),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CardOption extends StatelessWidget {
  final _CardModel option;
  const _CardOption(this.option);

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Material(
        elevation: 10,
        shadowColor: colors.shadow,
        borderRadius: BorderRadius.circular(5.w),
        child: InkWell(
          onTap: option.onTap,
          borderRadius: BorderRadius.circular(5.w),
          child: Ink(
            padding: EdgeInsets.all(4.w),
            width: double.infinity,
            height: 9.h,
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(5.w),
            ),
            child: Row(
              children: [
                Container(
                    height: 5.5.h,
                    width: 5.5.h,
                    decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(1.h)),
                    child: Icon(option.icon, color: colors.primary)),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  option.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 7.w,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserResume extends StatelessWidget {
  const _UserResume();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    UserProvider userProvider = context.read<UserProvider>();
    bool isDarkMode = context.watch<ThemeProvider>().isDarMode;
    PetProvider petProvider = context.watch<PetProvider>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      margin: EdgeInsets.symmetric(horizontal: 7.w),
      height: 30.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.all(Radius.circular(5.w)),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Theme.of(context).colorScheme.shadow,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Locale? currentLocale = context.locale;
                  if (currentLocale == const Locale('es')) {
                    context.setLocale(const Locale('en'));
                  } else {
                    context.setLocale(const Locale('es'));
                  }
                },
                icon: const Icon(BoxIcons.bx_world),
              ),
              Text(userProvider.name!),
              IconButton(
                onPressed: () {
                  themeProvider.changeTheme();
                },
                icon: Icon(isDarkMode ? BoxIcons.bxs_sun : BoxIcons.bxs_moon),
              ),
            ],
          ),
          SizedBox(height: .5.h),
          Text(userProvider.email!),
          SizedBox(height: 2.h),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const _AddPet();
                      }
                      Pet pet = petProvider.pets[index - 1];
                      return _PetAvatar(pet: pet);
                    },
                    itemCount: petProvider.pets.length + 1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AddPet extends StatelessWidget {
  const _AddPet();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => context.pushNamed('pet-register'),
              child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: lightPrimaryContainer,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Center(
                    child: Icon(
                      BoxIcons.bx_plus_circle,
                      color: lightPrimary,
                      size: 7.h,
                    ),
                  )),
            ),
            SizedBox(
              width: 20.w,
              child: Center(
                child: Text(
                  'add'.tr(context: context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PetAvatar extends StatelessWidget {
  final Pet pet;
  const _PetAvatar({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: lightBackground,
                borderRadius: BorderRadius.circular(10.w),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: Image.network(
                  pet.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
              child: Center(
                child: Text(
                  pet.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DecorationBox extends StatelessWidget {
  const _DecorationBox();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.h), bottomRight: Radius.circular(5.h))),
      ),
    );
  }
}

class _CardModel {
  final String title;
  final IconData icon;
  final Function()? onTap;

  _CardModel({required this.title, required this.icon, required this.onTap});
}
