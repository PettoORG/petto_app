class GeneralNotification {
  final String title;
  final String description;
  final String? image;
  final String? name;
  final String id;

  GeneralNotification({
    required this.title,
    required this.description,
    this.image,
    this.name,
    required this.id,
  });
}
