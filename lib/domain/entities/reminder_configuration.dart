class ReminderConfig {
  final List<ReminderCategory> categories;
  final List<ReminderFrecuency> frequencies;

  ReminderConfig({required this.categories, required this.frequencies});
}

class ReminderCategory {
  final String text;
  final String value;
  ReminderCategory({required this.text, required this.value});
}

class ReminderFrecuency {
  final String text;
  final String value;
  ReminderFrecuency({required this.text, required this.value});
}
