import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petto_app/UI/providers/providers.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ReminderFrecuencyModal extends StatefulWidget {
  const ReminderFrecuencyModal({Key? key}) : super(key: key);

  @override
  State<ReminderFrecuencyModal> createState() => _ReminderFrecuencyModalState();
}

class _ReminderFrecuencyModalState extends State<ReminderFrecuencyModal> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: const [
        _CustomFrecuencySelector(),
        _FrecuencySelectorView(),
        _RepeatTimesPerDaySelector(),
      ],
    );
  }
}

class _FrecuencySelectorView extends StatefulWidget {
  const _FrecuencySelectorView();

  @override
  State<_FrecuencySelectorView> createState() => _FrecuencySelectorViewState();
}

class _FrecuencySelectorViewState extends State<_FrecuencySelectorView> {
  String selectedFrequencyValue = 'none';

  @override
  Widget build(BuildContext context) {
    ReminderProvider reminderProvider = context.watch<ReminderProvider>();
    ColorScheme colors = Theme.of(context).colorScheme;

    List<ReminderFrecuency> frequencies = reminderProvider.reminderConfig!.frequencies;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(2.h),
          height: 1.h,
          width: 20.w,
          decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(3.w)),
        ),
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 2.h,
              mainAxisSpacing: 2.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            itemCount: frequencies.length,
            itemBuilder: (context, index) {
              return _FrecuencyCard(
                frequency: frequencies[index],
                isSelected: selectedFrequencyValue == frequencies[index].value,
                onTap: () {
                  setState(() {
                    selectedFrequencyValue = frequencies[index].value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FrecuencyCard extends StatelessWidget {
  final ReminderFrecuency frequency;
  final bool isSelected;
  final VoidCallback onTap;

  const _FrecuencyCard({required this.frequency, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        if (isSelected)
          Positioned(
            bottom: -4.w,
            right: -4.w,
            child: Transform.rotate(
              angle: -0.3, // Ajusta el ángulo según necesites
              child: SvgPicture.asset(
                'assets/svgs/pet-footprint.svg',
                width: 25.w,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(3.w),
          child: Ink(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.w),
              color: colors.surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: colors.shadow,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Expanded(
              child: Center(
                child: Text(
                  frequency.text,
                  style: textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomFrecuencySelector extends StatefulWidget {
  const _CustomFrecuencySelector();

  @override
  State<_CustomFrecuencySelector> createState() => _CustomFrecuencySelectorState();
}

class _CustomFrecuencySelectorState extends State<_CustomFrecuencySelector> {
  int selectedFrequency = 2;
  String selectedPeriod = 'Días';
  final List<int> frequencyOptions = List.generate(30, (index) => index + 2);
  final List<String> periodOptions = ['Días', 'Semanas', 'Meses'];
  int selectedRepeatCount = 2;
  String selectedRepeatType = 'Días';
  List<String> repeatTypeOptions = ['Días', 'Semanas', 'Meses'];
  Set<int> selectedWeekDays = <int>{};
  int selectedDayOfMonth = 1;

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 3.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Repetir cada', style: textTheme.titleMedium),
                    SizedBox(width: 3.w),
                    DropdownButton<int>(
                      elevation: 0,
                      value: selectedRepeatCount,
                      iconEnabledColor: colors.primary,
                      items: List.generate(30, (index) => 2 + index).map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value'),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedRepeatCount = newValue!;
                        });
                      },
                    ),
                    SizedBox(width: 3.w),
                    DropdownButton<String>(
                      elevation: 0,
                      value: selectedRepeatType,
                      iconEnabledColor: colors.primary,
                      items: repeatTypeOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRepeatType = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                const Divider(height: 30),
              ],
            ),
          ),
          if (selectedRepeatType == 'Días')
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                'El recordatorio se repetira cada $selectedRepeatCount días',
                style: textTheme.titleSmall,
              ),
            ),
          if (selectedRepeatType == 'Semanas') const _WeekDaysSelector(),
          if (selectedRepeatType == 'Meses')
            _DayOfMonthSelector(
              selectedDayOfMonth: selectedDayOfMonth,
              onDayChanged: (value) {},
            ),
        ],
      ),
    );
  }
}

class _DayOfMonthSelector extends StatelessWidget {
  final int selectedDayOfMonth;
  final Function(int?) onDayChanged;

  const _DayOfMonthSelector({
    Key? key,
    required this.selectedDayOfMonth,
    required this.onDayChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Text('El', style: textTheme.titleMedium),
          SizedBox(width: 3.w),
          DropdownButton<int>(
            value: selectedDayOfMonth,
            iconEnabledColor: colors.primary,
            items: List.generate(31, (index) => 1 + index).map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: onDayChanged,
          ),
        ],
      ),
    );
  }
}

class _WeekDaysSelector extends StatefulWidget {
  const _WeekDaysSelector({Key? key}) : super(key: key);

  @override
  State<_WeekDaysSelector> createState() => _WeekDaysSelectorState();
}

class _WeekDaysSelectorState extends State<_WeekDaysSelector> {
  List<bool> selectedWeekDays = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    List<String> weekDays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

    return Column(
      children: List.generate(weekDays.length, (index) {
        return CheckboxListTile(
          title: Text(weekDays[index]),
          value: selectedWeekDays[index],
          onChanged: (bool? newValue) {
            setState(() {
              selectedWeekDays[index] = newValue!;
            });
          },
        );
      }),
    );
  }
}

class _RepeatTimesPerDaySelector extends StatefulWidget {
  const _RepeatTimesPerDaySelector();

  @override
  State<_RepeatTimesPerDaySelector> createState() => __RepeatTimesPerDaySelectorState();
}

class __RepeatTimesPerDaySelectorState extends State<_RepeatTimesPerDaySelector> {
  int numRepetitions = 3;
  List<TimeOfDay> repeatTimes = [];
  final List<int> repetitionOptionsPerDay = [2, 3, 4, 5, 6];

  void _initializeRepeatTimes() {
    final now = DateTime.now();
    List<TimeOfDay> newTimes = [];

    final nextBaseTime = now.minute >= 30
        ? DateTime(now.year, now.month, now.day, now.hour + 1)
        : DateTime(now.year, now.month, now.day, now.hour, 30);

    for (int i = 0; i < numRepetitions; i++) {
      final interval = i == 0 ? 0 : (numRepetitions == 2 ? 12 : 24) / numRepetitions;
      final nextTime = nextBaseTime.add(Duration(hours: (i * interval).toInt()));

      newTimes.add(TimeOfDay(hour: nextTime.hour, minute: nextTime.minute));
    }

    setState(() {
      repeatTimes = newTimes;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeRepeatTimes();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Repetir:', style: textTheme.titleMedium),
                    const Spacer(),
                    DropdownButton<int>(
                      iconEnabledColor: colors.primary,
                      padding: EdgeInsets.symmetric(horizontal: 1.h),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(3.w),
                      value: numRepetitions,
                      items: repetitionOptionsPerDay.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value veces al día'),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          numRepetitions = newValue!;
                          numRepetitions = newValue;
                          _initializeRepeatTimes();
                        });
                      },
                    ),
                  ],
                ),
                const Divider(height: 30),
                Text('El recordatorio se repetira 2 veces al dia:', style: textTheme.titleMedium),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          ...List.generate(
            repeatTimes.length,
            (index) => ListTile(
              onTap: () {},
              trailing: Text(
                'Cambiar',
                style: textTheme.titleSmall!.copyWith(color: colors.primary),
              ),
              title: Text(
                '${repeatTimes[index].hour}:${repeatTimes[index].minute.toString().padLeft(2, '0')}', // Asegura dos dígitos para minutos
                style: textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
