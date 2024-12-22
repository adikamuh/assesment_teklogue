import 'package:equatable/equatable.dart';

class PaymentModel extends Equatable {
  final String id;
  final String title;

  const PaymentModel({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];

  PaymentModel copyWith({
    String? id,
    String? title,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
