import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:petto_app/UI/providers/pet_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/services/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PetRegisterScreen extends StatefulWidget {
  static const name = 'pet-register';
  const PetRegisterScreen({Key? key}) : super(key: key);

  @override
  State<PetRegisterScreen> createState() => _PetRegisterScreenState();
}

class _PetRegisterScreenState extends State<PetRegisterScreen> {
  File? petImage;
  TextEditingController petName = TextEditingController();
  String? petSpecie;
  String? petBreed;
  String? petSize;
  String? petGender;
  String? petBirthDate;
  double? petWeight;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    petName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.aboutYourPet,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.h),
                _PickPetImage(
                  petImage: petImage,
                  onTap: () async {
                    File? selectedImage = await ImagePickerService().pickImage();
                    if (selectedImage != null) {
                      setState(() {
                        petImage = selectedImage;
                      });
                    }
                  },
                ),
                SizedBox(height: 3.h),
                TextFormField(
                  controller: petName,
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.pets),
                    label: Text(AppLocalizations.of(context)!.name),
                  ),
                ),
                SizedBox(height: 3.h),
                _DefaultSection(
                  title: AppLocalizations.of(context)!.petType,
                  options: [AppLocalizations.of(context)!.dog, AppLocalizations.of(context)!.cat],
                  onOptionSelected: (option) => petSpecie = option,
                ),
                SizedBox(height: 3.h),
                _DefaultSection(
                  title: AppLocalizations.of(context)!.petBreed,
                  options: [AppLocalizations.of(context)!.purebred, AppLocalizations.of(context)!.mutt],
                  onOptionSelected: (option) => petBreed = option,
                ),
                SizedBox(height: 3.h),
                _DefaultSection(
                  title: AppLocalizations.of(context)!.petSize,
                  options: [
                    AppLocalizations.of(context)!.small,
                    AppLocalizations.of(context)!.medium,
                    AppLocalizations.of(context)!.large,
                  ],
                  onOptionSelected: (option) => petSize = option,
                ),
                SizedBox(height: 3.h),
                _DefaultSection(
                  title: AppLocalizations.of(context)!.gender,
                  options: [AppLocalizations.of(context)!.female, AppLocalizations.of(context)!.male],
                  onOptionSelected: (option) => petGender = option,
                ),
                SizedBox(height: 3.h),
                _BirthPetPicker(onTap: (date) => petBirthDate = date),
                SizedBox(height: 3.h),
                _PetWeightSection((value) => petWeight = double.parse(value)),
                SizedBox(height: 3.h),
                GlobalGeneralButton(
                  isLoading: context.watch<PetProvider>().isLoading,
                  text: AppLocalizations.of(context)!.save,
                  onPressed: () async {
                    final String petId = await context.read<PetProvider>().addPet(Pet(
                        name: petName.text,
                        specie: petSpecie!,
                        gender: petGender!,
                        breed: petBreed!,
                        size: petSize!,
                        birthdate: petBirthDate!,
                        weight: petWeight!,
                        image: null));
                    if (petImage != null) {
                      context.read<PetProvider>().updatePetImage(petId, petImage!);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PickPetImage extends StatelessWidget {
  const _PickPetImage({
    required this.petImage,
    this.onTap,
  });

  final File? petImage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5.w),
          child: Ink(
            height: 35.w,
            width: 35.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [
                BoxShadow(blurRadius: 5, color: Theme.of(context).colorScheme.shadow, offset: const Offset(0, 0))
              ],
            ),
            child: petImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(5.w),
                    child: Image.file(
                      petImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: SvgPicture.asset(
                      'assets/petto.svg',
                      height: 32.w,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
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
// class PetRegisterScreen extends StatelessWidget {
//   static const name = 'pet-register';
//   const PetRegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     PetProvider petProvider = context.read<PetProvider>();
//     File? petImage;
//     String? petName;
//     String? petSpecie;
//     String? petGender;
//     String? petBreed;
//     String? petSize;
//     String? petBirthdate;
//     double? petWeight;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 10.h),
//               Text(
//                 AppLocalizations.of(context)!.aboutYourPet,
//                 style: Theme.of(context).textTheme.titleLarge,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 5.h),
//               _PetAvatar(
//                 onTap: () async {
//                   try {
//                     petImage = await ImagePickerService().pickImage();
//                   } catch (e) {
//                     logger.e('ERROR: $e');
//                   }
//                 },
//                 image: petImage,
//               ),
//               SizedBox(height: 5.h),
//               _PetNameSection((value) => petName = value),
//               SizedBox(height: 5.h),
//
//               SizedBox(height: 5.h),
//               _DefaultSection(
//                 title: AppLocalizations.of(context)!.gender,
//                 options: [AppLocalizations.of(context)!.female, AppLocalizations.of(context)!.male],
//                 onOptionSelected: (option) => petGender = option,
//               ),
//
//               SizedBox(height: 5.h),
//               _BirthPetPicker((date) => petBirthdate = date),
//               SizedBox(height: 5.h),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(AppLocalizations.of(context)!.petWeight, style: Theme.of(context).textTheme.titleMedium),
//               ),
//               SizedBox(height: 1.h),
//               _PetWeightSection((value) => petWeight = double.parse(value)),
//               SizedBox(height: 5.h),
//               GlobalGeneralButton(
//                 onPressed: () async {
//                   String? petImageUrl;
//                   if (petImage != null) {
//                     petImageUrl = await FirebaseStorageService().uploadImage(petImage!, petImage!.path);
//                   }
//                   petProvider.addPet(
//                     Pet(
//                       name: petName!,
//                       specie: petSpecie!,
//                       gender: petGender!,
//                       breed: petBreed!,
//                       size: petSize!,
//                       birthdate: petBirthdate!,
//                       weight: petWeight!,
//                       image: petImageUrl,
//                     ),
//                   );
//                 },
//                 child: Text(AppLocalizations.of(context)!.save),
//               ),
//               // _SaveButton(Pet(
//               //   name: petName!,
//               //   specie: petSpecie!,
//               //   gender: petGender!,
//               //   breed: petBreed!,
//               //   size: petSize!,
//               //   birthdate: petBirthdate!,
//               //   weight: petWeight!,
//               //   image: petImage,
//               // )),
//               SizedBox(height: 1.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
          Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 1.h),
          Row(
            children: List.generate(widget.options.length, (index) {
              final option = widget.options[index];
              return Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: OnboardingDefaultOption(
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
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _PetWeightSection extends StatelessWidget {
  final Function(String)? onChanged;
  const _PetWeightSection(this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 27.w,
          child: TextFormField(
            onChanged: onChanged,
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

class _BirthPetPicker extends StatefulWidget {
  final Function(String date) onTap;
  const _BirthPetPicker({required this.onTap});

  @override
  _BirthPetPickerState createState() => _BirthPetPickerState();
}

class _BirthPetPickerState extends State<_BirthPetPicker> {
  TextEditingController dateController = TextEditingController();
  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          widget.onTap(formattedDate);
        }
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.pets),
        label: Text(AppLocalizations.of(context)!.petDateOfBirth),
      ),
    );
  }
}
