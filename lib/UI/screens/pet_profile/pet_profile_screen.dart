// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/pet_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:petto_app/domain/entities/pet.dart';
import 'package:petto_app/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetProfileScreen extends StatelessWidget {
  static const name = 'pet-profile';
  final Pet pet;
  const PetProfileScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            actions: [
              IconButton(
                  onPressed: () {
                    context.pushNamed('pet-info-editor', extra: {'pet': pet});
                  },
                  icon: const Icon(BoxIcons.bx_edit)),
              SizedBox(width: 1.w)
            ],
          ),
          SliverList.list(
            children: [
              _PetAvatarSection(pet.image!),
              _BasicInformation(pet),
              SizedBox(height: 3.h),
              _GeneralInformation(pet),
              SizedBox(height: 3.h),
              _DeleteButton(pet.id!),
              SizedBox(height: 3.h),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final String petId;
  const _DeleteButton(this.petId);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text('Eliminar mascota'),
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            ColorScheme colors = Theme.of(context).colorScheme;
            return AlertDialog(
              backgroundColor: colors.surface,
              surfaceTintColor: colors.surface,
              shadowColor: colors.shadow,
              elevation: 10,
              actionsPadding: EdgeInsets.all(1.h),
              actionsAlignment: MainAxisAlignment.spaceAround,
              contentPadding: EdgeInsets.all(5.w),
              actions: [
                TextButton(onPressed: () => context.pop(), child: Text(AppLocalizations.of(context)!.cancel)),
                TextButton(
                  onPressed: () async {
                    try {
                      PetProvider petProvider = context.read<PetProvider>();
                      await petProvider.deletePet(petId);
                      await petProvider.getPets();
                      if (petProvider.pets.isEmpty) return context.pushReplacementNamed('pet-register');
                      petProvider.currentPet = 0;
                      context.pushReplacementNamed('home');
                    } catch (e) {
                      showToast('error', context);
                    }
                  },
                  child: const Text('aceptar'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _GeneralInformation extends StatelessWidget {
  final Pet pet;
  const _GeneralInformation(this.pet);

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.general, style: textStyle.titleMedium),
          SizedBox(height: 1.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: color.surfaceVariant,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [
                BoxShadow(
                  color: color.shadow,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Title(title: AppLocalizations.of(context)!.food.toUpperCase()),
                _Text(title: pet.foodType == null ? 'No registrado' : pet.foodType!),
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.lastVeterinarySession.toUpperCase()),
                _Text(title: pet.lastVeterinarySession == null ? 'No registrado' : pet.lastVeterinarySession!),
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.lastDeworming.toUpperCase()),
                _Text(title: pet.lastDeworming == null ? 'No registrado' : pet.lastDeworming!),
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.microchip.toUpperCase()),
                _Text(title: pet.microchipId == null ? 'No registrado' : pet.microchipId!),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BasicInformation extends StatelessWidget {
  final Pet pet;
  const _BasicInformation(this.pet);

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyle = Theme.of(context).textTheme;
    List<OptionModel> options = [
      OptionModel(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(pet.age, style: textStyle.bodySmall!.copyWith(color: color.primary)),
              Text('años', style: textStyle.bodySmall!.copyWith(color: color.primary)),
            ],
          ),
          title: AppLocalizations.of(context)!.age,
          color: color.primaryContainer),
      OptionModel(
          child: Icon(
            (pet.gender == 'Macho' || pet.gender == 'Male') ? BoxIcons.bx_male_sign : BoxIcons.bx_female_sign,
            color: color.secondary,
          ),
          title: AppLocalizations.of(context)!.gender,
          color: color.secondaryContainer),
      // OptionModel(
      //     child: Icon(
      //       BoxIcons.bx_check_circle,
      //       color: color.primary,
      //     ),
      //     title: AppLocalizations.of(context)!.vaccinated,
      //     color: color.primaryContainer),
      OptionModel(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(pet.weight, style: textStyle.bodySmall!.copyWith(color: color.tertiary)),
              Text('Kg', style: textStyle.bodySmall!.copyWith(color: color.tertiary)),
            ],
          ),
          title: AppLocalizations.of(context)!.petWeight,
          color: color.tertiaryContainer),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          Text(
            pet.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            pet.specie,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 3.h),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(options.length, (index) => GlobalPetOptionCard(option: options[index]))),
        ],
      ),
    );
  }
}

class _PetAvatarSection extends StatelessWidget {
  final String petImage;
  const _PetAvatarSection(this.petImage);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: Stack(
        children: [
          GlobalStackDecoration(size: 40.w, left: -10.w, angle: 50),
          GlobalStackDecoration(size: 50.w, right: -15.w, bottom: -2.h, angle: -40),
          Center(
            child: Container(
              height: 40.w,
              width: 40.w,
              decoration: BoxDecoration(
                color: lightSurfaceVariant,
                borderRadius: BorderRadius.circular(5.w),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: lightShadowColor,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.w),
                child: Image.network(
                  petImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _Text extends StatelessWidget {
  final String title;

  const _Text({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
      ],
    );
  }
}
