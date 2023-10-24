import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
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
                  const _PetAvatar(),
                  SizedBox(height: 5.h),
                  const _PetNameSection(),
                  SizedBox(height: 5.h),
                  _DefaultSection(
                    firstCardChild: Center(
                      child: SvgPicture.asset(
                        'assets/dog.svg',
                        height: 18.w,
                      ),
                    ),
                    secondCardChild: Center(
                      child: SvgPicture.asset(
                        'assets/cat.svg',
                        height: 15.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  _DefaultSection(
                    firstCardChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(AppLocalizations.of(context)!.female, style: Theme.of(context).textTheme.bodyMedium),
                        const Icon(Icons.female),
                      ],
                    ),
                    secondCardChild: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(AppLocalizations.of(context)!.male, style: Theme.of(context).textTheme.bodyMedium),
                        const Icon(Icons.male),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  _DefaultSection(
                    firstCardChild: Center(
                        child: Text(AppLocalizations.of(context)!.mutt, style: Theme.of(context).textTheme.bodyMedium)),
                    secondCardChild: Center(
                        child: Text(AppLocalizations.of(context)!.purebred,
                            style: Theme.of(context).textTheme.bodyMedium)),
                  ),
                  SizedBox(height: 5.h),
                  const Visibility(visible: true, child: _MuttDogSizeSection()),
                  const Visibility(visible: false, child: _MuttCatSizeSection()),
                  SizedBox(height: 5.h),
                  const _BirthPetPicker(),
                  SizedBox(height: 5.h),
                  const _PetWeightSection(),
                  SizedBox(height: 5.h),
                  const _SaveButton(),
                ],
              ),
            )
          ],
        ),
      ],
    ));
  }
}

class _MuttDogSizeSection extends StatefulWidget {
  const _MuttDogSizeSection();

  @override
  State<_MuttDogSizeSection> createState() => _MuttDogSizeSectionState();
}

class _MuttDogSizeSectionState extends State<_MuttDogSizeSection> {
  late Color firstCardColor = Theme.of(context).colorScheme.surfaceVariant;
  late Color secondCardColor = Theme.of(context).colorScheme.surfaceVariant;
  late Color thirdCardColor = Theme.of(context).colorScheme.surfaceVariant;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OnboardingPetSizeOption(
          asset: 'assets/small-dog.svg',
          color: firstCardColor,
          text: 'Pequeño',
          width: 27.w,
          onTap: () {
            setState(() {
              firstCardColor = Theme.of(context).colorScheme.primaryContainer;
              secondCardColor = Theme.of(context).colorScheme.surfaceVariant;
              thirdCardColor = Theme.of(context).colorScheme.surfaceVariant;
            });
          },
        ),
        const Spacer(),
        OnboardingPetSizeOption(
          asset: 'assets/medium-dog.svg',
          color: secondCardColor,
          text: 'Mediano',
          width: 27.w,
          onTap: () {
            setState(() {
              firstCardColor = Theme.of(context).colorScheme.surfaceVariant;
              secondCardColor = Theme.of(context).colorScheme.primaryContainer;
              thirdCardColor = Theme.of(context).colorScheme.surfaceVariant;
            });
          },
        ),
        const Spacer(),
        OnboardingPetSizeOption(
          asset: 'assets/big-dog.svg',
          color: thirdCardColor,
          text: 'Grande',
          width: 27.w,
          onTap: () {
            setState(() {
              firstCardColor = Theme.of(context).colorScheme.surfaceVariant;
              secondCardColor = Theme.of(context).colorScheme.surfaceVariant;
              thirdCardColor = Theme.of(context).colorScheme.primaryContainer;
            });
          },
        ),
      ],
    );
  }
}

class _MuttCatSizeSection extends StatefulWidget {
  const _MuttCatSizeSection();

  @override
  State<_MuttCatSizeSection> createState() => _MuttCatSizeSectionState();
}

class _MuttCatSizeSectionState extends State<_MuttCatSizeSection> {
  late Color firstCardColor = Theme.of(context).colorScheme.surfaceVariant;
  late Color secondCardColor = Theme.of(context).colorScheme.surfaceVariant;
  late Color thirdCardColor = Theme.of(context).colorScheme.surfaceVariant;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OnboardingPetSizeOption(
          asset: 'assets/cat-size.svg',
          color: firstCardColor,
          text: 'Pequeño',
          width: 40.w,
          onTap: () {
            setState(() {
              firstCardColor = Theme.of(context).colorScheme.primaryContainer;
              secondCardColor = Theme.of(context).colorScheme.surfaceVariant;
              thirdCardColor = Theme.of(context).colorScheme.surfaceVariant;
            });
          },
        ),
        const Spacer(),
        OnboardingPetSizeOption(
          asset: 'assets/cat-size.svg',
          color: thirdCardColor,
          text: 'Mediano',
          width: 40.w,
          onTap: () {
            setState(() {
              firstCardColor = Theme.of(context).colorScheme.surfaceVariant;
              secondCardColor = Theme.of(context).colorScheme.surfaceVariant;
              thirdCardColor = Theme.of(context).colorScheme.primaryContainer;
            });
          },
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          context.pushReplacementNamed('home');
        },
        style: OutlinedButton.styleFrom(
          fixedSize: Size(70.w, 6.h),
        ),
        child: Text(AppLocalizations.of(context)!.next));
  }
}

class _PetWeightSection extends StatelessWidget {
  const _PetWeightSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 27.w,
          child: TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(3)],
            style: Theme.of(context).inputDecorationTheme.labelStyle,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              suffixIcon: Center(
                widthFactor: 1,
                child: Text(
                  'Kg',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6.w),
        Flexible(
            child: Text(
          AppLocalizations.of(context)!.enterYourPetsWeight,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          textAlign: TextAlign.justify,
        ))
      ],
    );
  }
}

class _BirthPetPicker extends StatelessWidget {
  const _BirthPetPicker();

  @override
  Widget build(BuildContext context) {
    TextEditingController dateController = TextEditingController();
    return TextFormField(
      style: Theme.of(context).inputDecorationTheme.labelStyle,
      controller: dateController,
      readOnly: true,
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime.now(),
        );
        if (selectedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
          dateController.text = formattedDate;
        }
      },
      decoration: InputDecoration(label: Text(AppLocalizations.of(context)!.petDateOfBirth)),
    );
  }
}

class _PetAvatar extends StatelessWidget {
  const _PetAvatar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 35.w,
          width: 35.w,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(17.w),
            boxShadow: [
              BoxShadow(blurRadius: 5, color: Theme.of(context).colorScheme.shadow, offset: const Offset(0, 0))
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/petto.svg',
              height: 32.w,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Flexible(
          child: Text(
            AppLocalizations.of(context)!.imageOfYourPet,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

class _DefaultSection extends StatefulWidget {
  final Widget? firstCardChild;
  final Widget? secondCardChild;
  const _DefaultSection({this.firstCardChild, this.secondCardChild});

  @override
  State<_DefaultSection> createState() => __DefaultSectionState();
}

class __DefaultSectionState extends State<_DefaultSection> {
  late Color _firstCardColor = Theme.of(context).colorScheme.surfaceVariant;
  late Color _secondCardColor = Theme.of(context).colorScheme.surfaceVariant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OnboardingCardOption(
          color: _firstCardColor,
          onTap: () {
            setState(() {
              _firstCardColor = Theme.of(context).colorScheme.primaryContainer;
              _secondCardColor = Theme.of(context).colorScheme.surfaceVariant;
            });
          },
          borderColor: (_firstCardColor == Theme.of(context).colorScheme.primaryContainer)
              ? Theme.of(context).colorScheme.primary
              : null,
          child: widget.firstCardChild,
        ),
        const Spacer(),
        OnboardingCardOption(
          color: _secondCardColor,
          onTap: () {
            setState(() {
              _firstCardColor = Theme.of(context).colorScheme.surfaceVariant;
              _secondCardColor = Theme.of(context).colorScheme.primaryContainer;
            });
          },
          borderColor: (_secondCardColor == Theme.of(context).colorScheme.primaryContainer)
              ? Theme.of(context).colorScheme.primary
              : null,
          child: widget.secondCardChild,
        ),
      ],
    );
  }
}

class _PetNameSection extends StatelessWidget {
  const _PetNameSection();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).inputDecorationTheme.labelStyle,
      autocorrect: false,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        label: Text(AppLocalizations.of(context)!.name),
      ),
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
