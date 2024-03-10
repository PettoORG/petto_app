import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:petto_app/config/constants/colors.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:petto_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    TextTheme textStyles = Theme.of(context).textTheme;
    ColorScheme colors = Theme.of(context).colorScheme;
    List<Pet> pets = context.watch<PetProvider>().pets;
    List<Reminder> reminders = context.watch<ReminderProvider>().reminders;
    PetProvider petProvider = context.read<PetProvider>();
    if (pets.isEmpty) {
      return const DontHavePet();
    }
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const _SliverAppbar(),
        SliverList.list(
          children: [
            SharedCardSwiper(
              viewportFraction: .7,
              itemCount: pets.length,
              onTap: (_) {
                context.pushNamed('pet-profile', extra: {'pet': pets[petProvider.currentPet]});
              },
              listener: (pet) => petProvider.currentPet = pet,
              children: List.generate(pets.length, (index) {
                Pet pet = pets[index];
                return Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Row(
                    children: [
                      Ink(
                        height: 30.w,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.w),
                          child: Image.network(
                            pet.image!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: colors.surface,
                                    borderRadius: BorderRadius.circular(5.w),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              pet.name,
                              style: textStyles.titleLarge!
                                  .copyWith(fontFamily: 'Pacifico-Regular', fontWeight: FontWeight.normal),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              pet.specie,
                              style: textStyles.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              pet.age,
                              style: textStyles.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              pet.gender,
                              style: textStyles.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _RemindersTitle(),
                  (reminders.isEmpty)
                      ? const NoPendingReminders()
                      : Column(
                          children: List.generate(
                            reminders.length < 3 ? reminders.length : 3,
                            (index) {
                              return GlobalReminderCard(
                                reminder: reminders[index],
                              );
                            },
                          ),
                        ),
                  SizedBox(height: 2.h),
                  Text('pettips'.tr(), style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
            const _Pettips(),
          ],
        )
      ],
    );
  }
}

class _Pettips extends StatelessWidget {
  const _Pettips();

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    TextTheme textStyle = Theme.of(context).textTheme;
    return FutureBuilder(
      future: context.read<PettipsProvider>().getGeneralPettips(context.locale.languageCode),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SharedCardSwiper(
              onTap: (index) => context.pushNamed('pettips', extra: {"pettip": snapshot.data![index]}),
              listener: (page) {},
              viewportFraction: .8,
              itemCount: snapshot.data!.length,
              autoAdvance: true,
              children: List.generate(
                snapshot.data!.length,
                (index) => Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Image.asset(
                        snapshot.data![index].asset,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 2.w,
                        left: 2.w,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.w),
                            color: color.surfaceVariant.withOpacity(.6),
                          ),
                          child: Text(
                            snapshot.data![index].title,
                            style: textStyle.bodySmall,
                          ),
                        ))
                  ],
                ),
              ));
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                height: 25.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: lightSurfaceVariant,
                  borderRadius: BorderRadius.circular(5.w),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class _RemindersTitle extends StatelessWidget {
  const _RemindersTitle();

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'upcomingReminders'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const _AddReminderBuilder();
                },
              );
            },
            icon: Icon(
              BoxIcons.bx_plus_circle,
              color: color.primary,
            ))
      ],
    );
  }
}

class _AddReminderBuilder extends StatefulWidget {
  const _AddReminderBuilder();

  @override
  State<_AddReminderBuilder> createState() => _AddReminderBuilderState();
}

class _AddReminderBuilderState extends State<_AddReminderBuilder> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    ReminderProvider reminderProvider = context.read<ReminderProvider>();
    if (reminderProvider.categories.isNotEmpty) return const _ReminderDialog();
    return FutureBuilder(
      future: reminderProvider.getCategories(context.locale.languageCode),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: PettoLoading(color: colors.primary, size: 20.w),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error al cargar las categorías"));
        } else if (snapshot.hasData) {
          return const _ReminderDialog();
        } else {
          return const Text("No hay datos disponibles");
        }
      },
    );
    //
  }
}

class _ReminderDialog extends StatefulWidget {
  const _ReminderDialog();

  @override
  State<_ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<_ReminderDialog> {
  TextEditingController dateController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ReminderCategory category;

  @override
  void dispose() {
    dateController.clear();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    ColorScheme colors = Theme.of(context).colorScheme;
    PetProvider petProvider = context.read<PetProvider>();
    ReminderProvider reminderProvider = context.read<ReminderProvider>();
    Pet pet = petProvider.pets[petProvider.currentPet];

    List<DropdownMenuItem<ReminderCategory>> dropdownItems = reminderProvider.categories
        .map(
          (category) => DropdownMenuItem<ReminderCategory>(
            value: category,
            child: Text(category.text),
          ),
        )
        .toList();

    return AlertDialog(
      backgroundColor: colors.background,
      surfaceTintColor: colors.surface,
      shadowColor: colors.shadow,
      elevation: 10,
      actionsPadding: EdgeInsets.only(bottom: 1.h),
      contentPadding: EdgeInsets.fromLTRB(6.w, 6.w, 6.w, 0.0),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text('cancel'.tr()),
        ),
        TextButton(
          onPressed: () async {
            DateFormat format = DateFormat("dd-MM-yyyy");
            DateTime dateTime = format.parse(dateController.text);
            if (!FormValidators.isValidForm(formKey)) return;
            await context
                .read<ReminderProvider>()
                .addReminder(
                  pet.id,
                  pet.image!,
                  titleController.text,
                  bodyController.text,
                  dateTime,
                  category.text,
                )
                .then(
                  (_) => context.pop(),
                )
                .catchError(
                  (e) => showToast('error'.tr(), context),
                );
          },
          child: Text('accept'.tr()),
        ),
      ],
      content: SingleChildScrollView(
        child: SizedBox(
          height: 55.h,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'addReminderForPet'.tr(args: [pet.name]),
                  style: textStyle.titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                DropdownButtonFormField(
                  decoration: const InputDecoration(label: Text('categorie')),
                  items: dropdownItems,
                  onChanged: (cat) => category = cat!,
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: titleController,
                  validator: (value) => FormValidators.reminderTitle(value),
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    label: Text('reminderTitle'.tr()),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: bodyController,
                  validator: (value) => FormValidators.reminderBody(value),
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    label: Text('description'.tr()),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
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
                    label: Text('date'.tr()),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppbar extends StatelessWidget {
  const _SliverAppbar();

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;
    return SliverAppBar(
      floating: true,
      centerTitle: true,
      title: Text(
        'petto'.tr(),
        style: textStyle.titleLarge!.copyWith(fontFamily: 'Pacifico-Regular'),
      ),
    );
  }
}
