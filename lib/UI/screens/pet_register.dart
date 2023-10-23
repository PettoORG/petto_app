import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetRegisterScreen extends StatelessWidget {
  static const name = 'pet-register';
  const PetRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverList.list(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  const _Title(),
                  SizedBox(height: 5.h),
                  const _PetNameSection(),
                  SizedBox(height: 5.h),
                  const _PetSpeciesSection(),
                  SizedBox(height: 5.h),
                  const _PetGenderSection(),
                  SizedBox(height: 5.h),
                  const _PetBreedSection()
                ],
              ),
            )
          ],
        ),
      ],
    ));
  }
}

class _PetNameSection extends StatelessWidget {
  const _PetNameSection();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        label: Text(AppLocalizations.of(context)!.name),
      ),
    );
  }
}

class _PetBreedSection extends StatefulWidget {
  const _PetBreedSection();

  @override
  State<_PetBreedSection> createState() => _PetBreedSectionState();
}

class _PetBreedSectionState extends State<_PetBreedSection> {
  late Color mutt = Theme.of(context).colorScheme.surfaceVariant;
  late Color purebred = Theme.of(context).colorScheme.surfaceVariant;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CardOption(
          color: mutt,
          borderColor: (mutt == Theme.of(context).colorScheme.secondaryContainer)
              ? Theme.of(context).colorScheme.secondary
              : null,
          onTap: () {
            setState(() {
              mutt = Theme.of(context).colorScheme.secondaryContainer;
              purebred = Theme.of(context).colorScheme.surfaceVariant;
            });
          },
          child: Center(child: Text(AppLocalizations.of(context)!.mutt)),
        ),
        const Spacer(),
        _CardOption(
          color: purebred,
          borderColor: (purebred == Theme.of(context).colorScheme.secondaryContainer)
              ? Theme.of(context).colorScheme.secondary
              : null,
          onTap: () {
            setState(() {
              mutt = Theme.of(context).colorScheme.surfaceVariant;
              purebred = Theme.of(context).colorScheme.secondaryContainer;
            });
          },
          child: Center(child: Text(AppLocalizations.of(context)!.purebred)),
        ),
      ],
    );
  }
}

class _PetSpeciesSection extends StatefulWidget {
  const _PetSpeciesSection();

  @override
  State<_PetSpeciesSection> createState() => _PetSpeciesSectionState();
}

class _PetSpeciesSectionState extends State<_PetSpeciesSection> {
  late Color dogColor = Theme.of(context).colorScheme.surfaceVariant;
  late Color catColor = Theme.of(context).colorScheme.surfaceVariant;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CardOption(
          color: dogColor,
          borderColor: (dogColor == Theme.of(context).colorScheme.primaryContainer)
              ? Theme.of(context).colorScheme.primary
              : null,
          onTap: () {
            setState(() {
              catColor = Theme.of(context).colorScheme.surfaceVariant;
              dogColor = Theme.of(context).colorScheme.primaryContainer;
            });
          },
          child: Center(
            child: SvgPicture.asset(
              'assets/dog.svg',
              height: 18.w,
            ),
          ),
        ),
        const Spacer(),
        _CardOption(
          color: catColor,
          borderColor: (catColor == Theme.of(context).colorScheme.primaryContainer)
              ? Theme.of(context).colorScheme.primary
              : null,
          onTap: () {
            setState(() {
              catColor = Theme.of(context).colorScheme.primaryContainer;
              dogColor = Theme.of(context).colorScheme.surfaceVariant;
            });
          },
          child: Center(
            child: SvgPicture.asset(
              'assets/cat.svg',
              height: 15.w,
            ),
          ),
        ),
      ],
    );
  }
}

class _PetGenderSection extends StatefulWidget {
  const _PetGenderSection();

  @override
  State<_PetGenderSection> createState() => __PetGenderSectionState();
}

class __PetGenderSectionState extends State<_PetGenderSection> {
  late Color female = Theme.of(context).colorScheme.surfaceVariant;
  late Color male = Theme.of(context).colorScheme.surfaceVariant;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CardOption(
          color: female,
          borderColor: (female == Theme.of(context).colorScheme.tertiaryContainer)
              ? Theme.of(context).colorScheme.tertiary
              : null,
          onTap: () {
            setState(() {
              female = Theme.of(context).colorScheme.tertiaryContainer;
              male = Theme.of(context).colorScheme.surfaceVariant;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(AppLocalizations.of(context)!.female),
              const Icon(Icons.female),
            ],
          ),
        ),
        const Spacer(),
        _CardOption(
          color: male,
          borderColor:
              (male == Theme.of(context).colorScheme.tertiaryContainer) ? Theme.of(context).colorScheme.tertiary : null,
          onTap: () {
            setState(() {
              female = Theme.of(context).colorScheme.surfaceVariant;
              male = Theme.of(context).colorScheme.tertiaryContainer;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(AppLocalizations.of(context)!.male),
              const Icon(Icons.male),
            ],
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.aboutYourPet,
      style: Theme.of(context).textTheme.titleMedium,
      textAlign: TextAlign.center,
    );
  }
}

class _CardOption extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final Color? borderColor;
  final Widget? child;

  const _CardOption({
    this.onTap,
    required this.color,
    this.child,
    this.borderColor, // No es necesario el "required" aquí
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.w),
      child: Ink(
        height: 10.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: borderColor ?? Colors.transparent),
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Theme.of(context).colorScheme.shadow, offset: const Offset(0, 0))
          ],
        ),
        child: child,
      ),
    );
  }
}
