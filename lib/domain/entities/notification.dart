class GeneralNotification {
  final String title;
  final String description;
  final String? image;
  final String? name;
  final String id;
  final String type;
  final String payload;

  GeneralNotification({
    required this.title,
    required this.description,
    this.image,
    this.name,
    required this.id,
    required this.type,
    required this.payload,
  });
}
