import 'package:easy_localization/easy_localization.dart';

String calculateAge(DateTime birthDate) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(birthDate);

  if (difference.inDays < 7) {
    return 'days'.plural(difference.inDays);
  } else if (difference.inDays < 30) {
    int weeks = difference.inDays ~/ 7;
    return 'weeks'.plural(weeks);
  } else {
    int ageYears = now.year - birthDate.year;
    int ageMonths = now.month - birthDate.month;
    int ageDays = now.day - birthDate.day;

    if (ageMonths < 0 || (ageMonths == 0 && ageDays < 0)) {
      ageYears--;
      ageMonths += 12;
    }

    if (ageYears > 0) {
      if (ageMonths == 0) {
        return 'years'.plural(ageYears);
      } else {
        return '${'years'.plural(ageYears)} ${'months'.plural(ageMonths)}';
      }
    } else {
      if (ageMonths == 0) {
        return 'days'.plural(ageDays);
      } else {
        print('${'months'.plural(ageMonths)}');
        return 'months'.plural(ageMonths);
      }
    }
  }
}
