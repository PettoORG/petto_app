import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:petto_app/UI/providers/language_provider.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 10.h)),
        SliverList.list(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Calendar(),
                SizedBox(height: 3.h),
                Text(
                  AppLocalizations.of(context)!.upcomingReminders,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 1.h),
                ...List.generate(7, (index) => const GlobalReminderCard()),
              ],
            ),
          )
        ]),
      ],
    );
  }
}

class _Calendar extends StatelessWidget {
  const _Calendar();

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    DateTime subtractMonths(DateTime date, int months) {
      final year = date.year + (date.month - months) ~/ 12;
      final month = (date.month - months) % 12;
      return DateTime(year, month + 1, date.day);
    }

    DateTime addMonths(DateTime date, int months) {
      final year = date.year + (date.month + months - 1) ~/ 12;
      final month = (date.month + months - 1) % 12;
      return DateTime(year, month + 1, date.day);
    }

    DateTime startDate = subtractMonths(now, 3);
    DateTime endDate = addMonths(now, 12);
    ColorScheme color = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: color.surfaceVariant,
        borderRadius: BorderRadius.circular(5.w),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: color.shadow,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: TableCalendar(
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(color: color.primary, shape: BoxShape.circle),
        ),
        locale: context.watch<LanguageProvider>().language,
        focusedDay: DateTime.now(),
        firstDay: startDate,
        lastDay: endDate,
        rowHeight: 5.h,
        availableGestures: AvailableGestures.all,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }
}
