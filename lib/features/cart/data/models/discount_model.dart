class DiscountModel {
  final String id;
  final String title;
  final double amount;

  DiscountModel({
    required this.id,
    required this.title,
    required this.amount,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
    };
  }
}