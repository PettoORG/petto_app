import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileView extends StatelessWidget {
  static const name = 'user-profile';

  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    List<_CardModel> options = [
      _CardModel(
          title: AppLocalizations.of(context)!.myAccount,
          icon: BoxIcons.bx_face,
          onTap: () {
            context.pushNamed('account');
          }),
      _CardModel(
          title: AppLocalizations.of(context)!.notifications,
          icon: BoxIcons.bx_bell,
          onTap: () {
            context.pushNamed('notifications-settings');
          }),
      //TODO: IMPLEMENTAR SOPORTE

      // _CardModel(
      //   title: AppLocalizations.of(context)!.support,
      //   icon: BoxIcons.bx_support,
      //   onTap: () => context.pushNamed('suport'),
      // ),
      _CardModel(
          title: AppLocalizations.of(context)!.securityPolicies,
          icon: BoxIcons.bx_shield_quarter,
          onTap: () {
            context.pushNamed('terms-privacy');
          }),
      _CardModel(
        title: AppLocalizations.of(context)!.logOut,
        icon: BoxIcons.bx_log_out_circle,
        onTap: () async {
          try {
            await userProvider.signOut();
            if (!context.mounted) return;
            context.pushReplacementNamed('auth');
          } catch (e) {
            showToast(AppLocalizations.of(context)!.error, context);
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
                  color: colors.shadow,
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
    UserProvider userProvider = context.read<UserProvider>();
    PetProvider petProvider = context.watch<PetProvider>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      margin: EdgeInsets.symmetric(horizontal: 7.w),
      height: 25.h,
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_world)),
          //     Container(
          //       height: 12.h,
          //       width: 12.h,
          //       decoration: BoxDecoration(
          //         color: Theme.of(context).colorScheme.primaryContainer,
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(5.w),
          //         ),
          //         boxShadow: [
          //           BoxShadow(
          //             blurRadius: 5,
          //             color: Theme.of(context).colorScheme.shadow,
          //             offset: const Offset(0, 0),
          //           ),
          //         ],
          //       ),
          //     ),
          //     IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_brightness)),
          //   ],
          // ),
          // SizedBox(height: .5.h),
          Text(userProvider.getAuthUser()!.displayName!),
          SizedBox(height: .5.h),
          Text(userProvider.getAuthUser()!.email!),
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
              child: const Center(
                child: Text(
                  'Agregar',
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
        height: 35.h,
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
