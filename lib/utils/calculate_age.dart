String calculateAge(DateTime birthDate) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(birthDate);

  if (difference.inDays < 7) {
    return '${difference.inDays} days';
  } else if (difference.inDays < 30) {
    int weeks = difference.inDays ~/ 7;
    return '$weeks weeks';
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
        return '$ageYears ${ageYears == 1 ? 'year' : 'years'}';
      } else {
        return '$ageYears ${ageYears == 1 ? 'year' : 'years'} and $ageMonths ${ageMonths == 1 ? 'month' : 'months'}';
      }
    } else {
      if (ageMonths == 0) {
        return '$ageDays days';
      } else {
        return '$ageMonths ${ageMonths == 1 ? 'month' : 'months'}';
      }
    }
  }
}
