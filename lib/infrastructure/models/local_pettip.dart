class LocalPettip {
  final String asset;
  final String title;

  LocalPettip({required this.asset, required this.title});

  factory LocalPettip.fromJson(Map<String, dynamic> json) {
    return LocalPettip(
      asset: json['asset'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
