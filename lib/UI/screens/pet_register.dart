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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Text(
                AppLocalizations.of(context)!.aboutYourPet,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.h),
              const _PetAvatar(),
              SizedBox(height: 5.h),
              const _PetNameSection(),
              SizedBox(height: 5.h),
              _DefaultSection(
                title: 'Tipo de mascota',
                options: const ['Perro', 'Gato'],
                onOptionSelected: (petType) {},
              ),
              SizedBox(height: 5.h),
              _DefaultSection(
                title: 'Genero',
                options: const ['Hembra', 'Macho'],
                onOptionSelected: (petType) {},
              ),
              SizedBox(height: 5.h),
              _DefaultSection(
                title: 'Tipo',
                options: const ['Raza', 'Criollo'],
                onOptionSelected: (petType) {},
              ),
              SizedBox(height: 5.h),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tamaño', style: Theme.of(context).textTheme.titleSmall)),
              SizedBox(height: 1.h),
              _MuttSizeSection(
                options: [
                  _MuttSizeOption(asset: 'assets/small-dog.svg', text: 'Pequeño', size: 27.w),
                  _MuttSizeOption(asset: 'assets/medium-dog.svg', text: 'Mediano', size: 27.w),
                  _MuttSizeOption(asset: 'assets/big-dog.svg', text: 'Grande', size: 27.w),
                ],
                onOptionSelected: (petSize) {},
              ),
              SizedBox(height: 5.h),
              const _BirthPetPicker(),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Peso', style: Theme.of(context).textTheme.titleSmall),
              ),
              SizedBox(height: 1.h),
              const _PetWeightSection(),
              SizedBox(height: 5.h),
              const _SaveButton(),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultSection extends StatefulWidget {
  final List options;
  final String title;
  final Function(String) onOptionSelected;
  const _DefaultSection({required this.options, required this.title, required this.onOptionSelected});

  @override
  State<_DefaultSection> createState() => _DefaultSectionState();
}

class _DefaultSectionState extends State<_DefaultSection> {
  List<Color> cardColors = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cardColors = List.generate(widget.options.length, (index) => Theme.of(context).colorScheme.surfaceVariant);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.titleSmall),
          SizedBox(height: 1.h),
          Row(
            children: List.generate(widget.options.length, (index) {
              final option = widget.options[index];
              return OnboardingDefaultOption(
                text: option,
                color: cardColors[index],
                onTap: () {
                  setState(() {
                    cardColors = List.generate(widget.options.length, (index) {
                      return Theme.of(context).colorScheme.surfaceVariant;
                    });
                    cardColors[index] = Theme.of(context).colorScheme.primary;
                  });
                  widget.onOptionSelected(option);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _MuttSizeSection extends StatefulWidget {
  final List<_MuttSizeOption> options;
  final Function(String) onOptionSelected;

  const _MuttSizeSection({
    required this.options,
    required this.onOptionSelected,
  });

  @override
  State<_MuttSizeSection> createState() => _MuttSizeSectionState();
}

class _MuttSizeSectionState extends State<_MuttSizeSection> {
  List<Color> cardColors = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cardColors = List.generate(widget.options.length, (index) => Theme.of(context).colorScheme.surfaceVariant);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.options.length, (index) {
        final option = widget.options[index];
        return OnboardingPetSizeOption(
          asset: option.asset,
          color: cardColors[index],
          text: option.text,
          width: option.size,
          onTap: () {
            setState(() {
              cardColors = List.generate(widget.options.length, (index) {
                return Theme.of(context).colorScheme.surfaceVariant;
              });
              cardColors[index] = Theme.of(context).colorScheme.primaryContainer;
            });
            widget.onOptionSelected(option.text);
          },
        );
      }),
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
          fixedSize: Size(75.w, 6.5.h),
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
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.pets), label: Text(AppLocalizations.of(context)!.petDateOfBirth)),
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

class _PetNameSection extends StatelessWidget {
  const _PetNameSection();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      autocorrect: false,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.pets),
        label: Text(AppLocalizations.of(context)!.name),
      ),
    );
  }
}

class _MuttSizeOption {
  final String asset;
  final String text;
  final double size;

  _MuttSizeOption({
    required this.asset,
    required this.text,
    required this.size,
  });
}
