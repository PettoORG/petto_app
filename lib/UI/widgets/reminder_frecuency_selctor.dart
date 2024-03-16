import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petto_app/domain/entities/entities.dart';
import 'package:sizer/sizer.dart';

class ReminderFrecuencyModal extends StatefulWidget {
  const ReminderFrecuencyModal({super.key});

  @override
  State<ReminderFrecuencyModal> createState() => _ReminderFrecuencyModalState();
}

class _ReminderFrecuencyModalState extends State<ReminderFrecuencyModal> {
  List<Map<String, dynamic>> repeatOptions = [
    {'text': 'No se repite', 'value': RepeatType.none, 'isSelected': true},
    {'text': 'Varias veces al día', 'value': RepeatType.multipleTimesADay, 'icon': true},
    {'text': 'Cada día', 'value': RepeatType.daily},
    {'text': 'Cada semana', 'value': RepeatType.weekly},
    {'text': 'Cada mes', 'value': RepeatType.monthly},
    {'text': 'Cada año', 'value': RepeatType.yearly},
    {'text': 'Personalizado', 'value': RepeatType.custom, 'icon': true},
  ];
  int numRepetitions = 3;
  List<TimeOfDay> repeatTimes = [];
  int selectedRepetitionTimesPerDay = 2;
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

    void handleSelection(int selectedIndex) {
      setState(() {
        for (int i = 0; i < repeatOptions.length; i++) {
          repeatOptions[i]['isSelected'] = i == selectedIndex;
        }
      });
    }

    return PageView(
      children: [
        //FRECUENCY SELECTOR
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(2.h),
              height: 1.h,
              width: 20.w,
              decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(3.w)),
            ),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 2.h,
                mainAxisSpacing: 2.h,
                childAspectRatio: 2,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                crossAxisCount: 2,
                children: List.generate(
                  repeatOptions.length,
                  (index) => _FrecuencyCard(
                    repeatOptions[index],
                    () {
                      handleSelection(index);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
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
                          value: selectedRepetitionTimesPerDay,
                          items: repetitionOptionsPerDay.map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('$value veces al día'),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedRepetitionTimesPerDay = newValue!;
                              numRepetitions = newValue;
                              _initializeRepeatTimes();
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(
                      height: 30,
                    ),
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
        )
      ],
    );
  }
}

class _FrecuencyCard extends StatelessWidget {
  final dynamic option;
  final Function()? onTap;
  const _FrecuencyCard(this.option, this.onTap);

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        (option['isSelected'] == true)
            ? Positioned(
                bottom: -4.w,
                right: -4.w,
                child: Transform.rotate(
                  angle: -19.5,
                  child: SvgPicture.asset(
                    'assets/svgs/pet-footprint.svg',
                    width: 25.w,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(3.w),
          child: Ink(
            height: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.w),
              color: colors.surface,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Theme.of(context).colorScheme.shadow,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option['text'],
                    style: textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
