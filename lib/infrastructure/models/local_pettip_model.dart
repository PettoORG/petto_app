class LocalPettipModel {
  final String asset;
  final String title;

  LocalPettipModel({required this.asset, required this.title});

  factory LocalPettipModel.fromJson(Map<String, dynamic> json) {
    return LocalPettipModel(
      asset: json['asset'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
