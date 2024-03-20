import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddReminderScreen extends StatefulWidget {
  static const name = 'add-reminder';
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    dateController.clear();
    dateController.dispose();
    descriptionController.clear();
    descriptionController.dispose();
    titleController.clear();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    ReminderProvider reminderProvider = context.read<ReminderProvider>();
    return Scaffold(
      body: CustomScrollView(slivers: [
        const _SliverAppBar(),
        SliverToBoxAdapter(
          child: FutureBuilder(
            future: reminderProvider.getReminderConfig(context.locale.languageCode),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: PettoLoading(color: colors.primary, size: 20.w),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error al cargar datos"));
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _PetSelector(),
                      SizedBox(height: 1.h),
                      const _CategorySelector(),
                      SizedBox(height: 1.h),
                      TextFormField(
                        controller: titleController,
                        validator: (value) => FormValidators.reminderTitle(value),
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(BoxIcons.bx_alarm),
                          label: Text(
                            'reminderTitle'.tr(),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      TextFormField(
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        controller: dateController,
                        validator: (value) => FormValidators.date(value),
                        readOnly: true,
                        onTap: () async {
                          DateTime now = DateTime.now();
                          DateTime lastDate = DateTime(now.year + 100, now.month, now.day);
                          DateTime firstDate = DateTime(now.year, now.month, now.day + 1);
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: firstDate,
                            firstDate: firstDate,
                            lastDate: lastDate,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: colors.surface,
                                  colorScheme: ColorScheme.dark(
                                    primary: colors.primary,
                                    onPrimary: colors.surface,
                                    surface: colors.surface,
                                    onSurface: colors.primary,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (selectedDate != null) {
                            String formattedDate = DateFormat('dd-MM-yyy').format(selectedDate);
                            dateController.text = formattedDate;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(BoxIcons.bx_calendar),
                          label: Text('Fecha de inicio'.tr()),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      TextFormField(
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        controller: timeController,
                        validator: (value) => FormValidators.date(value),
                        readOnly: true,
                        onTap: () async {
                          final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                            initialEntryMode: TimePickerEntryMode.dial,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: colors.surface,
                                  colorScheme: ColorScheme.dark(
                                    primary: colors.primary,
                                    onPrimary: colors.surface,
                                    surface: colors.surface,
                                    onSurface: colors.primary,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (timeOfDay != null) {
                            timeController.text = timeOfDay.toString();
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(BoxIcons.bx_time),
                          label: Text('hora del recordatorio'.tr()),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: colors.background,
                            builder: (BuildContext context) => const ReminderFrecuencyModal(),
                          );
                        },
                        child: Ink(
                          padding: EdgeInsets.all(3.w),
                          width: double.infinity,
                          height: 7.5.h,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(5.w),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Theme.of(context).colorScheme.shadow,
                                offset: const Offset(0, 0),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(BoxIcons.bx_calendar_event),
                              SizedBox(width: 3.w),
                              const Text('Repetir'),
                              const Spacer(),
                              const Text('No repetir')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      TextFormField(
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        controller: descriptionController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          label: Text('description'.tr()),
                          alignLabelWithHint: true,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      PettoGeneralButton(
                        onPressed: () {},
                        text: 'save'.tr(),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        )
      ]),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ReminderProvider reminderProvider = context.read<ReminderProvider>();
    List<DropdownMenuItem<ReminderCategory>> dropdownItems = reminderProvider.reminderConfig!.categories
        .map(
          (category) => DropdownMenuItem<ReminderCategory>(
            value: category,
            child: Text(category.text),
          ),
        )
        .toList();
    return DropdownButtonFormField(
      onChanged: (cat) {},
      items: dropdownItems,
      style: textTheme.bodyLarge,
      icon: Icon(BoxIcons.bx_chevron_down, size: 8.w),
      decoration: const InputDecoration(
        label: Text('categorie'),
        prefixIcon: Icon(
          BoxIcons.bx_category,
        ),
      ),
    );
  }
}

class _PetSelector extends StatelessWidget {
  const _PetSelector();

  @override
  Widget build(BuildContext context) {
    PetProvider petProvider = context.read<PetProvider>();
    List<Pet> pets = petProvider.pets;
    Pet currentPet = context.watch<PetProvider>().pets[petProvider.currentPet];
    ColorScheme colors = Theme.of(context).colorScheme;
    return _BaseSelector(
      text: currentPet.name,
      icon: BoxIcons.bx_chevron_down,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3.w),
        child: Image.network(
          currentPet.image!,
          height: 5.5.h,
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SizedBox(
            height: 11.5.h * pets.length,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(2.h),
                  height: 1.h,
                  width: 20.w,
                  decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(3.w)),
                ),
                ...List.generate(
                  pets.length,
                  (index) => InkWell(
                    onTap: () {
                      petProvider.currentPet = index;
                      context.pop();
                    },
                    child: Ink(
                      padding: EdgeInsets.all(3.w),
                      width: double.infinity,
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(3.w),
                              child: Image.network(pets[index].image!, height: 5.5.h)),
                          SizedBox(width: 3.w),
                          Text(
                            pets[index].name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          const Icon(BoxIcons.bx_chevron_right)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BaseSelector extends StatelessWidget {
  const _BaseSelector({
    this.onTap,
    required this.child,
    required this.text,
    required this.icon,
  });

  final Function()? onTap;
  final Widget child;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.w),
      child: Ink(
        padding: EdgeInsets.all(3.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(5.w),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).colorScheme.shadow,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Row(
          children: [
            child,
            SizedBox(
              width: 3.w,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Icon(icon)
          ],
        ),
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      title: const Text('Agregar recordatorio'),
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
