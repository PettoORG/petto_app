// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/UI/widgets/onboarding_default_option.dart';
import 'package:petto_app/UI/widgets/shared/global_general_button.dart';
import 'package:petto_app/domain/entities/pet.dart';
import 'package:petto_app/services/image_pick_service.dart';
import 'package:petto_app/utils/form_validatros.dart';
import 'package:petto_app/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PetProfileEditorScreen extends StatefulWidget {
  static const name = 'pet-info-editor';
  final Pet pet;

  const PetProfileEditorScreen({Key? key, required this.pet}) : super(key: key);

  @override
  State<PetProfileEditorScreen> createState() => _PetProfileEditorScreenState();
}

class _PetProfileEditorScreenState extends State<PetProfileEditorScreen> {
  File? petImageFile;
  String? petSize;
  String? petWeight;
  String? foodType;
  String? lastDeworming;
  String? lastVeterinarySession;
  String? microchip;

  @override
  Widget build(BuildContext context) {
    PetProvider petProvider = context.read<PetProvider>();
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                title: Text(
                  widget.pet.name,
                ),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      SizedBox(height: 3.h),
                      _PickPetImage(
                        petImage: petImageFile,
                        onTap: () async {
                          File? selectedImage = await ImagePickerService().pickImage();
                          if (selectedImage != null) {
                            setState(() {
                              petImageFile = selectedImage;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 3.h),
                      _DefaultSection(
                        title: 'petSize'.tr(),
                        options: [
                          'small'.tr(),
                          'medium'.tr(),
                          'large'.tr(),
                        ],
                        onOptionSelected: (option) => petSize = option,
                      ),
                      SizedBox(height: 3.h),
                      _PetWeightSection((value) {
                        if (RegExp(r'^\d+\.?\d{0,2}').hasMatch(value)) {
                          petWeight = value;
                        }
                      }),
                      SizedBox(height: 3.h),
                      _DefaultSection(
                        title: 'food'.tr(),
                        options: [
                          'comercial'.tr(),
                          'natural'.tr(),
                        ],
                        onOptionSelected: (option) => foodType = option,
                      ),
                      SizedBox(height: 3.h),
                      _DatePetPicker(
                        onTap: (date) => lastDeworming = date,
                        label: 'lastDeworming'.tr(),
                        title: 'deworming'.tr(),
                      ),
                      SizedBox(height: 3.h),
                      _DatePetPicker(
                        onTap: (date) => lastVeterinarySession = date,
                        label: 'lastVeterinarySession'.tr(),
                        title: 'veterinarySession'.tr(),
                      ),
                      SizedBox(height: 3.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'microchip'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(prefixIcon: const Icon(Icons.pets), labelText: 'microchip'.tr()),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 3.h,
            left: 0,
            right: 0,
            child: GlobalGeneralButton(
              isLoading: context.watch<PetProvider>().isLoading,
              text: 'save'.tr(),
              onPressed: () async {
                if (petSize == null ||
                    petWeight == null ||
                    foodType == null ||
                    lastDeworming == null ||
                    lastVeterinarySession == null) {
                  showToast('missingOrIncorrectData'.tr(), context);
                } else {
                  if (petImageFile != null) {
                    await petProvider.updatePetImage(widget.pet.id!, petImageFile!);
                  }
                  await petProvider.updatePet(
                    widget.pet.id!,
                    {
                      'size': petSize,
                      'weight': petWeight,
                      'foodType': foodType,
                      'lastDeworming': lastDeworming,
                      'lastVeterinarySession': lastVeterinarySession,
                    },
                  );
                  context.pushReplacementNamed('home');
                }
              },
            ),
          )
        ],
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
            'imageOfYourPet'.tr(),
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'petWeight'.tr(),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              SizedBox(
                width: 27.w,
                child: TextFormField(
                  onChanged: onChanged,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    LengthLimitingTextInputFormatter(4)
                  ],
                  validator: (value) => FormValidators.validateWeight(value),
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
                'enterYourPetsWeight'.tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.justify,
              ))
            ],
          ),
        ],
      ),
    );
  }
}

class _DatePetPicker extends StatefulWidget {
  final Function(String date) onTap;
  final String label;
  final String title;
  const _DatePetPicker({required this.onTap, required this.label, required this.title});

  @override
  _DatePetPickerState createState() => _DatePetPickerState();
}

class _DatePetPickerState extends State<_DatePetPicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 1.h),
          TextFormField(
            style: Theme.of(context).inputDecorationTheme.labelStyle,
            controller: dateController,
            validator: (value) => FormValidators.validateDate(value),
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: color.surface,
                      colorScheme: ColorScheme.dark(
                        primary: color.primary,
                        onPrimary: color.surface,
                        surface: color.surface,
                        onSurface: color.primary,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (selectedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                dateController.text = formattedDate;
                widget.onTap(formattedDate);
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.pets),
              label: Text(widget.label),
            ),
          ),
        ],
      ),
    );
  }
}
