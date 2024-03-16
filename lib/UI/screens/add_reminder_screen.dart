import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  late ReminderCategory category;

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
    List<DropdownMenuItem<ReminderCategory>> dropdownItems = reminderProvider.categories
        .map(
          (category) => DropdownMenuItem<ReminderCategory>(
            value: category,
            child: Text(category.text),
          ),
        )
        .toList();
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const _SliverAppBar(),
        SliverList.list(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _PetSelector(),
                  SizedBox(height: 1.h),
                  DropdownButtonFormField(
                    items: dropdownItems,
                    onChanged: (cat) => category = cat!,
                    decoration: const InputDecoration(label: Text('categorie'), prefixIcon: Icon(BoxIcons.bx_category)),
                  ),
                  SizedBox(height: 1.h),
                  TextFormField(
                    controller: titleController,
                    validator: (value) => FormValidators.reminderTitle(value),
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
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
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
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
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
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
                    style: Theme.of(context).inputDecorationTheme.labelStyle,
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
            ),
          ],
        )
      ],
    ));
  }
}

class _PetSelector extends StatelessWidget {
  const _PetSelector();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(5.w),
      child: Ink(
        padding: EdgeInsets.all(3.w),
        width: double.infinity,
        height: 8.h,
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
            Container(
                height: 5.5.h,
                width: 5.5.h,
                decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(1.h)),
                child: Icon(Icons.abc, color: colors.primary)),
            SizedBox(
              width: 3.w,
            ),
            Text(
              'Pet Name',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            Icon(
              BoxIcons.bx_chevron_down,
              size: 7.w,
            )
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
