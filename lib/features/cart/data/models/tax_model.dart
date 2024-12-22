class TaxModel {
  final String id;
  final String title;
  final double percent;

  TaxModel({
    required this.id,
    required this.title,
    required this.percent,
  });

  factory TaxModel.fromJson(Map<String, dynamic> json) {
    return TaxModel(
      id: json['id'],
      title: json['title'],
      percent: json['percent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'percent': percent,
    };
  }
}
