import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetProfileScreen extends StatelessWidget {
  static const name = 'pet-profile';

  const PetProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            actions: [IconButton(onPressed: () {}, icon: const Icon(BoxIcons.bx_edit)), SizedBox(width: 1.w)],
          ),
          SliverList.list(
            children: [
              const _PetAvatarSection(),
              const _BasicInformation(),
              SizedBox(height: 3.h),
              const _GeneralInformation(),
              SizedBox(height: 3.h),
              const _Vaccines(),
              SizedBox(height: 3.h),
              const _Medicaments(),
              SizedBox(height: 3.h),
              const _Diseases(),
              SizedBox(height: 3.h),
            ],
          ),
        ],
      ),
    );
  }
}

class _Medicaments extends StatelessWidget {
  const _Medicaments();

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.medications, style: textStyle.titleMedium),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.all(3.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.surfaceVariant,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [
                BoxShadow(
                  color: color.shadow,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Title(title: 'MEDICAMENTO 1'),
                SizedBox(height: .5.h),
                const _Title(title: 'MEDICAMENTO 2'),
                SizedBox(height: .5.h),
                const _Title(title: 'MEDICAMENTO 3'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Diseases extends StatelessWidget {
  const _Diseases();

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.diseases, style: textStyle.titleMedium),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.all(3.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.surfaceVariant,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [
                BoxShadow(
                  color: color.shadow,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Title(title: 'ENFERMEDAD 1'),
                SizedBox(height: .5.h),
                const _Title(title: 'ENFERMEDAD 2'),
                SizedBox(height: .5.h),
                const _Title(title: 'ENFERMEDAD 3'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Vaccines extends StatelessWidget {
  const _Vaccines();

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    ColorScheme color = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.vaccinations, style: textStyle.titleMedium),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.all(3.w),
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.surfaceVariant,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [
                BoxShadow(
                  color: color.shadow,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Title(title: AppLocalizations.of(context)!.lastApplication.toUpperCase()),
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.nextApplication.toUpperCase()),
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.pendingApplications.toUpperCase()),
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.vaccineComponentAllergies.toUpperCase()),
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.recommendedPlanCompliance.toUpperCase()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GeneralInformation extends StatelessWidget {
  const _GeneralInformation();

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
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.lastVeterinarySession.toUpperCase()),
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.lastDeworming.toUpperCase()),
                SizedBox(height: .5.h),
                _Title(title: AppLocalizations.of(context)!.microchip.toUpperCase()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BasicInformation extends StatelessWidget {
  const _BasicInformation();

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyle = Theme.of(context).textTheme;
    List<OptionModel> options = [
      OptionModel(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('9', style: textStyle.bodySmall!.copyWith(color: color.primary)),
              Text('meses', style: textStyle.bodySmall!.copyWith(color: color.primary)),
            ],
          ),
          title: AppLocalizations.of(context)!.age,
          color: color.primaryContainer),
      OptionModel(
          child: Icon(
            BoxIcons.bx_female_sign,
            color: color.secondary,
          ),
          title: AppLocalizations.of(context)!.gender,
          color: color.secondaryContainer),
      OptionModel(
          child: Icon(
            BoxIcons.bx_check_circle,
            color: color.primary,
          ),
          title: AppLocalizations.of(context)!.vaccinated,
          color: color.primaryContainer),
      OptionModel(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('8', style: textStyle.bodySmall!.copyWith(color: color.tertiary)),
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
            'Kamrexito',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '${AppLocalizations.of(context)!.dog}(raza)',
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
  const _PetAvatarSection();

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
